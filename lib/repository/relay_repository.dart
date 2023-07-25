import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nostr/nostr.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import 'nip07_mock.dart' if (dart.library.html) 'nip07_web.dart';
import 'dart:io' if (dart.library.html) 'dart:html';

import 'repository_interfaces.dart';
part 'relay_repository.freezed.dart';

typedef SubscriptionId = String;
typedef RelayUrl = String;
typedef EventId = String;

@freezed
abstract class Subscription with _$Subscription {
  const factory Subscription({
    required SubscriptionId id,
    required Filter filter,
    required Function(SubscriptionId) eoseCallback,
  }) = _Subscription;
}

@freezed
abstract class EventWithJson with _$EventWithJson {
  const factory EventWithJson({
    required Event event,
    required String json,
  }) = _EventWithJson;
}

@unfreezed
abstract class ReceivingEvents with _$ReceivingEvents {
  factory ReceivingEvents({
    required Map<RelayUrl, Map<EventId, EventWithJson>> eventsOnRelays,
    required DateTime lastReceived,
  }) = _ReceivingEvents;
}

@Freezed(makeCollectionsUnmodifiable: false)
abstract class EventWithRelays with _$EventWithRelays {
  const factory EventWithRelays({
    required EventWithJson event,
    required List<RelayUrl> relays,
  }) = _EventWithRelays;
}

class RelayRepository implements RelayRepositoryInterface {
  // シングルトン
  static final RelayRepository _instance = RelayRepository._();
  factory RelayRepository() => _instance;

  // 接続リレープール
  final Map<RelayUrl, WebSocketChannel> _webSocketChannelList = {};

  // 接続したいリレーリスト
  final List<RelayUrl> _relays = [
    "wss://relay-jp.nostr.wirednet.jp",
    "wss://yabu.me"
  ];

  // 秘密鍵(nullの場合、未格納のためNIP-07を使用する)
  Keychain? _keychain;

  // イベント受信バッファ(サブスクID別、リレー別イベント)
  final Map<SubscriptionId, ReceivingEvents> _eventBuffer = {};

  // サブスクリプションID - Event callback
  final Map<SubscriptionId, Subscription> _subscriptions = {};

  // メタデータキャッシュ
  final Map<Pubkey, Metadata> _metadataCache = {};

  // 通信開始済みチェック
  bool _isConnected = false;

  // 最終送受信時間
  DateTime _lastCommunication = DateTime.now();

  // ログハンドラー
  Function(String)? _logHandler;

  // 名前付きコンストラクタ(プライベート)
  RelayRepository._() {
    /*
    Future.sync(() async {
      setSelfKey(await File("C:\\nostr.txt").readAsString());
      print("KEY OK");
    });
    */

    // 周期タイマー
    Timer.periodic(const Duration(seconds: 3), _onPeriodicTimer);
  }

  // ログ
  void log(String message) {
    debugPrint(message);
    _logHandler?.call(message);
  }

  void setLogHandler(Function(String message) handler) {
    _logHandler = handler;
  }

  // 周期イベント処理
  void _onPeriodicTimer(Timer timer) async {
    log("[onPeriodicTimer] Start");
    // 最終通信時間から10秒経ったら切断する
    if (DateTime.now().difference(_lastCommunication).inSeconds > 10 &&
        _isConnected) {
      log("[onPeriodicTimer] auto close");
      _disconnect();
    }

    if (_isConnected) {
      // 接続状態チェックと、自動再接続
      _webSocketChannelList.forEach((r, w) {
        if (w.closeCode != null) {
          log("[onPeriodicTimer] reconnect $r");
          // 既存の接続を閉じる
          try {
            w.sink.close();
          } catch (e) {
            // Do noting
          }

          // 接続を開始する
          var s = WebSocketChannel.connect(Uri.parse(r));
          s.stream.listen((message) {
            // なにか受信した: 受信物はすべて同じところに流し込む
            _onWebsocketReceived(r, message);
          });
          // 接続管理する
          _webSocketChannelList[r] = s;
        }
      });
    }
  }

  // 通信可能かチェック
  Future<void> _checkConnection() async {
    // もし通信が始まっていないなら
    if (!_isConnected) {
      // 接続を開始
      await connect();
    }
  }

  // 単発リクエストを実施
  Future<Map<EventId, EventWithRelays>?> _oneshotRequest(
      Filter filter, List<RelayUrl>? relays) async {
    log("[oneshotRequest] Start");

    var completer = Completer<Map<EventId, EventWithRelays>?>();
    var isEOSE = false;

    // リクエストを生成
    String subscriptionId = generate64RandomHexChars().substring(0, 32);
    log("[oneshotRequest]$subscriptionId");

    // 完了時 or タイムアウト処理を追加
    void onComplete() async {
      // すでに完了済みの場合無視(期限切れタイマーによるもの)
      if (completer.isCompleted) {
        return;
      }

      // データを受信中であり、最後に受信してから200ms以内なら、追加で200ms待つ
      if (_eventBuffer[subscriptionId] != null &&
          (DateTime.now()
                  .difference(_eventBuffer[subscriptionId]!.lastReceived) <
              const Duration(milliseconds: 200))) {
        log("[oneshotRequest] Contine: $subscriptionId ${_eventBuffer[subscriptionId]!.lastReceived}");
        Future.delayed(const Duration(milliseconds: 200), onComplete);
        return;
      }
      log("[onComplete] Start");
      // サブスク解除
      // サブスクリプションを停止
      _subscriptions.remove(subscriptionId);
      await _sendAllRelay(Close(subscriptionId).serialize());

      // 終了状態を判定
      if (_eventBuffer[subscriptionId] != null) {
        log("[oneshotRequest] On data: $subscriptionId  ${_eventBuffer[subscriptionId]!.lastReceived} ${DateTime.now()} ${isEOSE.toString()}");
        // 最低一つは応答はあったので、対象の投稿を取り出す
        var eventsPerRelay = _eventBuffer[subscriptionId]!.eventsOnRelays;
        Map<EventId, EventWithRelays> events = {};

        // リレーごとの投稿を取り出し
        eventsPerRelay.forEach((relayUrl, eventsOfId) {
          // 同じIDは同じ内容なので内容チェックは不要
          eventsOfId.forEach((eventId, event) {
            if (!events.containsKey(eventId)) {
              // どのリレーからもまだ来ていない情報だった場合、格納
              events[eventId] = EventWithRelays(
                  event: event,
                  relays: List<RelayUrl>.from([relayUrl], growable: true));
            } else {
              // すでに到達済みの場合、リレー情報だけ追加
              events[eventId]!.relays.add(relayUrl);
            }
          });
        });

        // 受信バッファから消去
        _eventBuffer.remove(subscriptionId);

        // 打ち上げ
        completer.complete(events);
        return;
      }

      // データがなかった時
      if (isEOSE) {
        // EOSEは来たがデータが1件もなかった(リレーに存在しないデータ)
        log("[oneshotRequest] No data");
        completer.complete(null);
      } else {
        // どのリレーからも応答がなかった(通信切断 or EOSE非対応リレーしかいない)
        log("[oneshotRequest] Timeout");
        completer.completeError("Timeout");
      }
    }

    // callbackを登録
    _subscriptions[subscriptionId] = Subscription(
      id: subscriptionId,
      filter: filter,
      eoseCallback: (String subscriptionId) {
        // EOSE
        log("[oneshotRequest] EOSE: $subscriptionId");
        isEOSE = true;
        // 200ms後に確定処理
        Future.delayed(const Duration(milliseconds: 200), () {
          onComplete();
        });
      },
    );

    // サブスクリプションを開始
    Request request = Request(subscriptionId, [filter]);

    if (relays != null) {
      for (var relayUrl in relays) {
        await _sendRelay(relayUrl, request.serialize());
      }
    } else {
      await _sendAllRelay(request.serialize());
    }

    // 3秒後に強制タイムアウト
    Future.delayed(const Duration(seconds: 3), () {
      onComplete();
    });

    return completer.future;
  }

  // 接続済みWebsocketから何かを受け取った
  void _onWebsocketReceived(relayUrl, payload) async {
    // 文字列を受信した時
    if (payload is String) {
      // log('[onWebsocketReceived] Received event($relayUrl): $payload');

      // Web版ではEVENTは署名検証スキップする(負荷が非常に高いため)
      var data = jsonDecode(payload);
      if (data[0] == "EVENT") {
        Event e = Event.deserialize(data, verify: !kIsWeb);
        if (e.kind == 4) {
          // ignore: deprecated_member_use
          e = EncryptedDirectMessage(data);
        }

        // Subscriptionに存在するかチェック
        if (_subscriptions[e.subscriptionId] == null) {
          // 存在しないので(リレーが壊れてる?)無視する
          log("[onWebsocketReceived] REJECT: not subscription ${e.subscriptionId}");
          return;
        }

        var filter = _subscriptions[e.subscriptionId]!.filter;

        // 対象のkindsか調べます(リレー異常対策)
        if (!filter.kinds!.contains(e.kind)) {
          // 対象ではない
          log("[onWebsocketReceived] REJECT: not kind ${e.kind}  ${e.subscriptionId}");
          return;
        }

        // Filterにauthorsが含まれる場合、対象のpubkeyか調べます
        if (filter.authors != null) {
          // 対象ではない
          if (!filter.authors!.contains(e.pubkey)) {
            log("[onWebsocketReceived] REJECT: not authors ${e.pubkey}  ${e.subscriptionId}");
            return;
          }
        }

        // Filterにidsが含まれる場合、対象のidか調べます
        if (filter.ids != null) {
          // 対象ではない
          if (!filter.ids!.contains(e.id)) {
            log("[onWebsocketReceived] REJECT: not ids ${e.id}  ${e.subscriptionId}");
            return;
          }
        }

        //リレーバッファがない場合、作る
        if (_eventBuffer[e.subscriptionId!] == null) {
          _eventBuffer[e.subscriptionId!] =
              ReceivingEvents(eventsOnRelays: {}, lastReceived: DateTime.now());
        }
        //投稿のバッファがない場合、作る
        if (_eventBuffer[e.subscriptionId!]!.eventsOnRelays[relayUrl] == null) {
          _eventBuffer[e.subscriptionId!]!.eventsOnRelays[relayUrl] = {};
        }

        // イベントをリレー別バッファに詰める
        _eventBuffer[e.subscriptionId!]!.eventsOnRelays[relayUrl]![e.id] =
            EventWithJson(
                event: e,
                json: jsonEncode(data[2])); // [1]にはsubscription IDがあるので
        _eventBuffer[e.subscriptionId!]!.lastReceived = DateTime.now();
        log("OK ${e.subscriptionId}");

        // 最終通信時間を更新
        _lastCommunication = DateTime.now();
        return;
      }
      log('[onWebsocketReceived] Received event($relayUrl): $payload');
      //デシリアライズと、署名検証
      Message m = Message.deserialize(payload);
      switch (m.type) {
        case "EVENT":
          // ここには来ない
          break;
        case "EOSE":
          // 最終通信時間を更新
          _lastCommunication = DateTime.now();
          // EOSE通知を取り出す
          SubscriptionId subscriptionId = jsonDecode(m.message as String)[0];
          // EOSEをイベントバッファ処理のトリガとする
          _subscriptions[subscriptionId]?.eoseCallback.call(subscriptionId);
          break;
        default:
          // NOTICE, エラーなど
          log('Received event($relayUrl): $payload');
          break;
      }
    }
  }

  // すべてのリレーに送信する
  Future<void> _sendAllRelay(dynamic data) async {
    log("[_sendAllRelay] SendAll");
    await _checkConnection();
    _webSocketChannelList.forEach((r, w) {
      w.sink.add(data);
    });

    // 最終通信時間を更新
    _lastCommunication = DateTime.now();
  }

  // 特定ののリレーに送信する
  Future<void> _sendRelay(RelayUrl url, dynamic data) async {
    log("[_sendRelay] Send");
    await _checkConnection();
    _webSocketChannelList[url]?.sink.add(data);

    // 最終通信時間を更新
    _lastCommunication = DateTime.now();
  }

  // 状況に応じて取得手段を使い分けて、NIP-19公開鍵を取得
  Future<Pubkey?> getMyPubkey() async {
    late var pubkeyHex;
    if (_keychain == null) {
      pubkeyHex = await Nip07.getPublicKey();
    } else {
      pubkeyHex = _keychain?.public;
    }
    if (pubkeyHex == null) {
      return null;
    }
    return Nip19.encodePubkey(pubkeyHex);
  }

  // 状況に応じて署名手段を使い分けて、署名して送信
  Future<void> signAndSend(
      int kind, List<List<String>> tags, String content) async {
    log("[signAndSend] Start");

    var pubkey = await getMyPubkey();
    if (pubkey == null) {
      throw Error();
    }

    Event event = Event.partial();
    event.createdAt = DateTime.now().millisecondsSinceEpoch ~/ 1000;
    event.content = content;
    event.kind = kind;
    event.tags = tags;
    event.pubkey = Nip19.decodePubkey(pubkey);

    if (_keychain == null) {
      Nip07Event nip07 = Nip07Event(
        created_at: event.createdAt,
        pubkey: event.pubkey,
        content: event.content,
        id: "",
        kind: event.kind,
        sig: "",
        tags: event.tags,
      );

      var result = await Nip07.signEvent(nip07);
      if (result == null) {
        throw Error();
      }
      event.id = result.id;
      event.sig = result.sig;
    } else {
      event.id = event.getEventId();
      event.sig = event.getSignature(_keychain!.private);
    }

    if (!event.isValid()) {
      throw Error();
    }

    await _sendAllRelay(event.serialize());
  }

  // 通信切断
  Future<void> _disconnect() async {
    log("[connect] _disconnect");
    _webSocketChannelList.forEach((r, w) {
      w.sink.close();
    });
    _webSocketChannelList.clear();
    _isConnected = false;
  }

  // -----------------------

  @override
  Future<void> connect() async {
    log("[connect] Start");
    // すでに接続済みなら全部切断する
    _disconnect();

    // 接続を開始する
    for (var r in _relays) {
      var w = WebSocketChannel.connect(Uri.parse(r));
      w.stream.listen((message) {
        // なにか受信した: 受信物はすべて同じところに流し込む
        _onWebsocketReceived(r, message);
      });
      // 接続管理する
      _webSocketChannelList[r] = w;
    }
    log("[connect] Connected");
    _isConnected = true;

    // 最終通信時間を更新
    _lastCommunication = DateTime.now();

    // 公開鍵の初回取得処理(NIP-07キャッシュを兼ねて)
    await getMyPubkey();
  }

  @override
  List<String> getRelay() {
    return _relays;
  }

  @override
  void setRelay(List<String> relays) {
    _relays.clear();
    _relays.addAll(relays);
  }

  @override
  void setSelfKey(String? privateKey) {
    log("[setSelfKey] Start");
    if (privateKey == null) {
      // NIP-07に任せる
      _keychain = null;
      log("[setSelfKey] NIP-07");
      return;
    }
    var privKey = Nip19.decodePrivkey(privateKey);
    if (privKey != "") {
      _keychain = Keychain(privKey);
    } else {
      throw ArgumentError("not private key");
    }
    log("[setSelfKey] OK");
  }

  @override
  Future<List<TextNote>> getTextNotes({
    List<String>? ids, //NIP-19
    List<String>? authers, //NIP-19
    List<String>? e, //⚠non-NIP-19
    List<String>? p, //⚠non-NIP-19
    DateTime? since,
    DateTime? until,
    int? limit,
    List<String>? relays,
  }) async {
    log("[getTextNotes] Start");
    List<String>? idsHex;
    List<String>? authersHex;
    if (ids != null) {
      idsHex = ids.map((e) => Nip19.decodeNote(e)).toList();
    }
    if (authers != null) {
      authersHex = authers.map((e) => Nip19.decodePubkey(e)).toList();
    }

    var events = await _oneshotRequest(
        Filter(
          kinds: [1, 6],
          ids: idsHex,
          authors: authersHex,
          e: e,
          p: p,
          since: since != null ? since.millisecondsSinceEpoch ~/ 1000 : null,
          until: until != null ? until.millisecondsSinceEpoch ~/ 1000 : null,
          limit: limit,
        ),
        relays);

    // データがある
    if (events != null) {
      // autherを抽出
      List<String> authers = List.empty(growable: true);
      events.forEach((EventId id, EventWithRelays event) {
        authers.add(event.event.event.pubkey);
      });
      var metadatas = await getMetadatas(authers);

      // Note本体を取得
      List<TextNote> notes = List.empty(growable: true);
      events.forEach((EventId id, EventWithRelays event) {
        var e = event.event;
        if (e.event.kind == 1) {
          String? nip36;
          try {
            nip36 = e.event.tags
                .firstWhere((element) => element[0] == "content-warning")[1];
          } catch (e) {
            // Do noting
          }
          try {
            var note = TextNote(
              // --- 生データ
              rawJson: e.json,
              relays: event.relays,
              // --- 基本情報
              id: Nip19.encodeNote(e.event.id), // NIP-19
              pubkey: Nip19.encodePubkey(e.event.pubkey), // NIP-19
              createdAt:
                  DateTime.fromMillisecondsSinceEpoch(e.event.createdAt * 1000),
              // --- TextNote基本情報
              content: e.event.content,
              tags: e.event.tags,
              // --- TextNote付属情報
              nip36: nip36,
              autherMetadata: metadatas[e.event.pubkey],
              repost: false,
            );
            notes.add(note);
          } catch (e) {
            log("[getTextNotes] $e");
          }
        }
        if (e.event.kind == 6) {
          try {
            var note = TextNote(
              // --- 生データ
              rawJson: e.json,
              relays: event.relays,
              // --- 基本情報
              id: Nip19.encodeNote(e.event.id), // NIP-19
              pubkey: Nip19.encodePubkey(e.event.pubkey), // NIP-19
              createdAt:
                  DateTime.fromMillisecondsSinceEpoch(e.event.createdAt * 1000),
              // --- TextNote基本情報
              content: "",
              tags: e.event.tags,
              // --- TextNote付属情報
              nip36: null,
              autherMetadata: metadatas[e.event.pubkey],
              repost: true,
            );
            notes.add(note);
          } catch (e) {
            log("[getTextNotes] $e");
          }
        }
      });

      // 日時順に並び替え
      notes.sort(((a, b) => a.createdAt.compareTo(b.createdAt)));
      return notes;
    } else {
      // データがない
      return [];
    }
  }

  @override
  Future<List<Pubkey>> getContactList(String pubkey) async {
    log("[getContactList] Start");
    var events = await _oneshotRequest(
        Filter(
          kinds: [3],
          authors: [Nip19.decodePubkey(pubkey)],
          limit: 5,
        ),
        null);

    List<Event> contactListEvents = List.empty(growable: true);
    events?.forEach((EventId id, EventWithRelays event) {
      contactListEvents.add(event.event.event);
    });
    // 最新順に並べる
    contactListEvents.sort(((a, b) => b.createdAt.compareTo(a.createdAt)));

    if (contactListEvents.isEmpty) {
      return [];
    }

    // 最も最新のものを取り出す
    List<Pubkey> pubkeys = List.empty(growable: true);
    var newestContactList = contactListEvents[0];
    newestContactList.tags.forEach((element) {
      try {
        if (element[0] == "p") {
          pubkeys.add(Nip19.encodePubkey(element[1]));
        }
      } catch (e) {
        // Do nothing
      }
    });
    return pubkeys;
  }

  @override
  Future<Map<Pubkey, Metadata>> getMetadatas(List<String>? pubkeys) async {
    log("[getMetadatas] Start");
    var output = <Pubkey, Metadata>{};

    // 対象がない場合、自分を対象にする
    if (pubkeys == null) {
      var mypubkey = await getMyPubkey();
      if (mypubkey == null) {
        return {};
      }
      var mypubkeyHex = Nip19.decodePubkey(mypubkey);
      pubkeys = [mypubkeyHex];
    }

    // キャッシュ
    List<Pubkey> nonCachedPubkeys = [];
    for (var p in pubkeys) {
      if (_metadataCache[p] != null) {
        // キャッシュ済みのものは出力に反映する
        output[p] = _metadataCache[p]!;
      } else {
        // 未キャッシュのものは取得対象にする
        nonCachedPubkeys.add(p);
      }
    }
    log("[getMetadatas] Cache hit: ${output.length}");

    // 取得
    var autherevents = await _oneshotRequest(
        Filter(
          kinds: [0],
          authors: nonCachedPubkeys,
        ),
        null);
    autherevents?.forEach((EventId id, EventWithRelays e) {
      try {
        Map<String, dynamic> data = jsonDecode(e.event.event.content);
        Metadata metadata = Metadata(
          // --- 生データ
          rawJson: e.event.json,
          relays: e.relays,
          // --- 基本情報
          id: Nip19.encodeNote(e.event.event.id), // NIP-19
          pubkey: Nip19.encodePubkey(e.event.event.pubkey), // NIP-19
          createdAt: DateTime.fromMillisecondsSinceEpoch(
              e.event.event.createdAt * 1000),
          // --- Metadata情報(基本)
          name: data["name"],
          picture: data["picture"],
          about: data["about"],
          // --- Metadata情報(応用)
          banner: data["banner"],
          website: data["website"],
          nip05: data["nip05"],
          lud16: data["lud16"],
          displayName: data["display_name"] ?? data["displayName"] ?? "",
        );
        output[e.event.event.pubkey] = metadata;
        _metadataCache[e.event.event.pubkey] = metadata; //キャッシュにも保存
      } catch (e) {
        log("[getMetadatas] $e");
      }
    });

    return output;
  }

  @override
  Future<void> postMyTextNote(String content, List<List<String>> tags) async {
    log("[postMyTextNote] Start");
    if (content.isEmpty) {
      log("content is empty");
      return;
    }
    await signAndSend(1, tags, content);
  }

  @override
  Future<void> postReaction({
    required Pubkey pubkey, //NIP-19
    required String noteId, //NIP-19
    required String reaction,
    String? emojiUrl,
  }) async {
    log("[postReaction] Start");
    List<List<String>> tags = List.empty(growable: true);
    tags.add(["e", Nip19.decodeNote(noteId)]);
    tags.add(["p", Nip19.decodePubkey(pubkey)]);
    if (emojiUrl != null) {
      tags.add(["emoji", reaction.replaceAll(":", ""), emojiUrl]);
    }
    await signAndSend(7, tags, reaction);
  }

  @override
  Future<void> postRepost(TextNote textNote) async {
    log("[postRepost] Start");
    await signAndSend(
        6,
        [
          ["e", Nip19.decodeNote(textNote.id), textNote.relays[0]]
        ],
        textNote.rawJson);
  }
}
