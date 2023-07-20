import 'dart:io';

Future<WebSocket> connectWebSocket(String r, Function(dynamic) onEvent,
    {required Function() onDone, required Function onError}) async {
  var w = await WebSocket.connect(r);
  w.pingInterval = const Duration(seconds: 3);
  w.listen(onEvent, onDone: onDone, onError: onError);
  return w;
}

void sendWebSocket(WebSocket w, dynamic d) {
  w.add(d);
}
