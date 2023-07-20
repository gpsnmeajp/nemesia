import 'dart:io';

Future<WebSocket> connectWebSocket(String r, Function(dynamic) onEvent) async {
  var w = await WebSocket.connect(r);
  w.pingInterval = const Duration(seconds: 3);
  w.listen(onEvent);
  return w;
}

void sendWebSocket(WebSocket w, dynamic d) {
  w.add(d);
}
