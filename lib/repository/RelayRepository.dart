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
  }

  // 接続リレープール
  List<WebSocket> _webSocketList = [];

  // 接続したいリレーリスト
  List<String> _relays = ["wss://relay-jp.nostr.wirednet.jp", "wss://yabu.me"];

  // イベントキュー
  Queue<Event> _eventBuffer = Queue();

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
    for (var w in _webSocketList) {
      w.close();
    }
    _webSocketList.clear();

    // 接続を開始する
    for (var r in _relays) {
      var w = await connectWebSocket(r, (event) {
        // なにか受信した: 受信物はすべて同じところに流し込む
        onWebsocketReceived(r, event);
      }, onDone: () {
        // 通信が終了した
        // TODO: 再接続する
        print("onDone: [$r]");
      }, onError: (e) {
        // 異常が発生した
        // TODO: 再接続する
        print("onError: [$r]${e.toString()}");
      });

      // 接続管理する
      _webSocketList.add(w);
      print("Connect");
    }
  }

  // すべてのリレーに送信する
  void sendAllRelay(dynamic data) {
    print("Send");
    for (var w in _webSocketList) {
      sendWebSocket(w, data);
    }
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
        if (_receivedEventId.containsKey(e.id)) {
          // このイベントIDはすでに受信済みなので、Relayの記録だけして処理しない
          _receivedEventId[e.id]?.add(relayUrl);
          return;
        } else {
          // 初回受信
          _receivedEventId[e.id] = [];
          _receivedEventId[e.id]?.add(relayUrl);
        }

        if (e.kind == 4) {
          // ignore: deprecated_member_use
          e = EncryptedDirectMessage(data);
        }
        if (_subscriptionOneshotEventCallback.containsKey(e.subscriptionId)) {
          // 単発はキューに入れず即時Callback
          _subscriptionOneshotEventCallback[e.subscriptionId]?.call(e);
        } else {
          _eventBuffer.add(e);
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

    // callbackを削除
    _subscriptionEventCallback.remove(subscriptionId);
    _subscriptionEoseCallback.remove(subscriptionId);

    // サブスクリプションを停止
    sendAllRelay(Close(subscriptionId).serialize());
  }

  // 単発サブスクリプションを終了
  void closeOneshotSubscribeRequest(String subscriptionId) {
    print("[closeOneshotSubscribeRequest]$subscriptionId");

    // callbackを咲くじぃ
    _subscriptionOneshotEventCallback.remove(subscriptionId);
    _subscriptionOneshotEoseCallback.remove(subscriptionId);

    // サブスクリプションを停止
    sendAllRelay(Close(subscriptionId).serialize());
  }

  Future<Event> oneshotRequest(List<Filter> filters) async {
    print("[oneshotRequest] Start");
    var completer = Completer<Event>();

    String subscriptionId =
        addSubscribeRequestFromFilterOneshot(filters, (Event event) {
      // EVENT
      // サブスク解除
      closeOneshotSubscribeRequest(event.subscriptionId!);
      completer.complete(event);
      print("[oneshotRequest] OK: ${event.subscriptionId!}");
    }, (String subscriptionId) {
      // EOSE
      print("[oneshotRequest] EOSE: $subscriptionId");
    });

    // タイムアウト
    Future.delayed(const Duration(seconds: 3), () {
      // 3秒後までに完了していなかったら
      if (!completer.isCompleted) {
        // サブスク解除
        closeOneshotSubscribeRequest(subscriptionId);
        completer.completeError("Timeout");
        print("[oneshotRequest] Timeout");
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
          profiles[p.pubkey] = p;
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
