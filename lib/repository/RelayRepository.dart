import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:nostr/nostr.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:metadata_fetch/metadata_fetch.dart';
import 'dart:async';
import 'dart:collection';
import 'dart:io' if (dart.library.html) 'dart:html';
import 'websocket_io.dart' if (dart.library.html) 'websocket_html.dart';
import 'package:async/async.dart';

class RelayRepository {
  // シングルトン
  static final RelayRepository _instance = RelayRepository._();
  factory RelayRepository() => _instance;

  // 名前付きコンストラクタ(プライベート)
  RelayRepository._() {
    // 100ms周期タイマー
    Future.delayed(const Duration(milliseconds: 100), onPeriodicTimer);
    Timer.periodic(const Duration(seconds: 15), (timer) async {
      // 15秒に1回、プロフィールを取得することでpingの代用とする
      // 本当はもっといい方法がある？
      try {
        await oneshotRequest([
          Filter(
              kinds: [0],
              limit: 1,
              authors: [
                "2235b39641a2e2ed57279aa6469d9912e28c1f0fa489ffe6eb2b1e68bc5f31d2"
              ])
        ]);
      } catch (e) {
        // ここに来るということは誰も応答しなかった
        // 再接続
        await connect();

        // サブスクリプションを再開
        _subscriptionRequest.forEach((key, request) {
          sendAllRelay(request.serialize());
        });
      }
    });
  }

  // 接続リレープール
  Map<String, WebSocket> _webSocketList = Map();

  // 接続したいリレーリスト
  List<String> _relays = ["wss://relay-jp.nostr.wirednet.jp", "wss://yabu.me"];

  // イベントキュー
  Queue<Event> _eventBuffer = Queue();

  // サブスクリプションID - Request (再接続時の再購読用)
  Map<String, Request> _subscriptionRequest = Map();

  // サブスクリプションID - Event callback
  Map<String, Function(Event)> _subscriptionEventCallback = Map();
  Map<String, Function(Event)> _subscriptionOneshotEventCallback = Map();

  // サブスクリプションID - EOSE callback(subscriptionId)
  Map<String, Function(String)> _subscriptionEoseCallback = Map();
  Map<String, Function(String)> _subscriptionOneshotEoseCallback = Map();

  // 受信済みイベント情報
  Map<String, List<String>> _receivedEventId = Map(); // ID, Relays

  // プロフィール情報
  Map<String, Event> profiles = {}; // npub, Event

  List<String> getRelays() {
    return _relays;
  }

  void setRelays(List<String> relays) {
    _relays = relays;
  }

  // 接続
  Future<void> connect() async {
    // すでに接続済みなら全部切断する
    _webSocketList.forEach((r, w) {
      w.close();
    });
    _webSocketList.clear();

    // 接続を開始する
    for (var r in _relays) {
      var w = await connectWebSocket(r, (event) {
        // なにか受信した: 受信物はすべて同じところに流し込む
        onWebsocketReceived(r, event);
      }, onDone: () {
        reconnect(r);
      }, onError: (e) {
        reconnect(r);
      });

      // 接続管理する
      _webSocketList[r] = w;
      print("Connect");
    }
  }

  void reconnect(String relayUrl) {
    print("reconnect");
    try {
      _webSocketList[relayUrl]?.close();
    } catch (e) {
      // Do noting
    }
    var r = relayUrl;
    // 5秒後に再接続
    Future.delayed(const Duration(milliseconds: 5000), () async {
      var w = await connectWebSocket(r, (event) {
        // なにか受信した: 受信物はすべて同じところに流し込む
        onWebsocketReceived(r, event);
      }, onDone: () {
        reconnect(r);
      }, onError: (e) {
        reconnect(r);
      });
      _webSocketList[r] = w;
    });
  }

  // すべてのリレーに送信する
  void sendAllRelay(dynamic data) {
    print("Send");
    _webSocketList.forEach((r, w) {
      sendWebSocket(w, data);
    });
  }

  // 接続済みWebsocketから何かを受け取った
  void onWebsocketReceived(relayUrl, payload) async {
    // 文字列を受信した時
    if (payload is String) {
      print('[onWebsocketReceived] Received event($relayUrl): $payload');

      // Web版ではEVENTは署名検証スキップする(負荷が非常に高いため)
      var data = jsonDecode(payload);
      if (data[0] == "EVENT") {
        Event e = Event.deserialize(data, verify: !kIsWeb);
        if (e.kind == 4) {
          // ignore: deprecated_member_use
          e = EncryptedDirectMessage(data);
        }

        if (_subscriptionOneshotEventCallback.containsKey(e.subscriptionId)) {
          // 単発はキューに入れず即時Callback
          _subscriptionOneshotEventCallback[e.subscriptionId]?.call(e);
        } else {
          if (_receivedEventId.containsKey(e.id)) {
            // このイベントIDはすでに受信済みなので、Relayの記録だけして処理しない
            // TODO: これは本来サブスクリプションIDごとに重複受信を区別する必要がある。でないと捨てすぎて通信できない。現にOneshotを除外しているのもこれが理由。
            _receivedEventId[e.id]?.add(relayUrl);
            return;
          } else {
            // 初回受信
            _receivedEventId[e.id] = [];
            _receivedEventId[e.id]?.add(relayUrl);
            _eventBuffer.add(e);
          }
        }
        return;
      }

      //デシリアライズと、署名検証
      Message m = Message.deserialize(payload);
      switch (m.type) {
        case "EVENT":
          // ここには来ない
          break;
        case "OK":
          Nip20 e = m.message as Nip20;
          break;
        case "REQ":
          Request e = m.message as Request;
          break;
        case "CLOSE":
          Close e = m.message as Close;
          break;
        case "EOSE":
          String subscriptionId = m.message as String;
          // EOSE コールバック
          if (_subscriptionOneshotEoseCallback.containsKey(subscriptionId)) {
            _subscriptionOneshotEoseCallback[subscriptionId]
                ?.call(subscriptionId);
          } else {
            _subscriptionEoseCallback[subscriptionId]?.call(subscriptionId);
          }
          break;
        default:
          // エラーなど
          // print('Received event($relayUrl): $payload');
          break;
      }
    }
  }

  // サブスクリプションに登録
  String addSubscribeRequestFromFilter(List<Filter> filters,
      Function(Event event) eventCallback, Function(String) eoseCallback) {
    // リクエストを生成
    String subscriptionId = generate64RandomHexChars().substring(0, 32);
    print("[addSubscribeRequestFromFilter]$subscriptionId");

    Request request = Request(subscriptionId, filters);

    // フィルタを記憶
    _subscriptionRequest[subscriptionId] = request;

    // callbackを登録
    _subscriptionEventCallback[subscriptionId] = eventCallback;
    _subscriptionEoseCallback[subscriptionId] = eoseCallback;

    // サブスクリプションを開始
    sendAllRelay(request.serialize());

    // 外部からコントロール(強制終了)したい場合に使用する
    return subscriptionId;
  }

  // サブスクリプションに登録
  String addSubscribeRequestFromFilterOneshot(List<Filter> filters,
      Function(Event event) eventCallback, Function(String) eoseCallback) {
    // リクエストを生成
    String subscriptionId = generate64RandomHexChars().substring(0, 32);
    print("[addSubscribeRequestFromFilterOneshot]$subscriptionId");

    Request request = Request(subscriptionId, filters);

    // callbackを登録
    _subscriptionOneshotEventCallback[subscriptionId] = eventCallback;
    _subscriptionOneshotEoseCallback[subscriptionId] = eoseCallback;

    // サブスクリプションを開始
    sendAllRelay(request.serialize());

    // 外部からコントロール(強制終了)したい場合に使用する
    return subscriptionId;
  }

  // 継続的サブスクリプションを終了
  void closeSubscribeRequest(String subscriptionId) {
    print("[closeSubscribeRequest]$subscriptionId");

    // リクエストを削除
    _subscriptionRequest.remove(subscriptionId);

    // callbackを削除
    _subscriptionEventCallback.remove(subscriptionId);
    _subscriptionEoseCallback.remove(subscriptionId);

    // サブスクリプションを停止
    sendAllRelay(Close(subscriptionId).serialize());
  }

  // 単発サブスクリプションを終了
  void closeOneshotSubscribeRequest(String subscriptionId) {
    print("[closeOneshotSubscribeRequest]$subscriptionId");

    // callbackを削除
    _subscriptionOneshotEventCallback.remove(subscriptionId);
    _subscriptionOneshotEoseCallback.remove(subscriptionId);

    // サブスクリプションを停止
    sendAllRelay(Close(subscriptionId).serialize());
  }

  Future<Event?> oneshotRequest(List<Filter> filters) async {
    print("[oneshotRequest] Start");
    var completer = Completer<Event>();
    var isEOSE = false;

    String subscriptionId =
        addSubscribeRequestFromFilterOneshot(filters, (Event event) {
      // EVENT
      // サブスク解除
      print("[oneshotRequest] OK: ${event.subscriptionId!}");
      closeOneshotSubscribeRequest(event.subscriptionId!);
      completer.complete(event);
    }, (String subscriptionId) {
      // EOSE
      print("[oneshotRequest] EOSE: $subscriptionId");
      isEOSE = true;
    });

    // タイムアウト
    Future.delayed(const Duration(seconds: 3), () {
      // 3秒後までに完了していなかったら
      if (!completer.isCompleted) {
        // サブスク解除
        closeOneshotSubscribeRequest(subscriptionId);
        if (isEOSE) {
          // 応答はあったが見つからなかった
          completer.complete(null);
        } else {
          // 応答がなかった
          completer.completeError("Timeout");
          print("[oneshotRequest] Timeout");
        }
      }
    });

    return completer.future;
  }

  void onPeriodicTimer() async {
    // イベントキューからイベントをすべて取り出す
    while (_eventBuffer.isNotEmpty) {
      var event = _eventBuffer.removeLast();
      print(event);

      if (!profiles.containsKey(event.pubkey)) {
        try {
          final p = await oneshotRequest([
            Filter(kinds: [0], limit: 1, authors: [event.pubkey])
          ]);
          if (p != null) {
            profiles[p.pubkey] = p;
          }
        } catch (e) {
          print("timeout");
          //Do noting (timeout error)
        }
      }

      // 各コールバックに振り分け
      _subscriptionEventCallback[event.subscriptionId]?.call(event);
    }
    // 次のタイマーをセットする
    Future.delayed(const Duration(milliseconds: 100), onPeriodicTimer);
  }
}
