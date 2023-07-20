import 'dart:html';

Future<WebSocket> connectWebSocket(String r, Function(dynamic) onEvent) async {
  var w = WebSocket(r);
  w.onMessage.listen(
    (event) {
      onEvent(event.data);
    },
  );
  while (w.readyState == WebSocket.CONNECTING) {
    await Future.delayed(const Duration(milliseconds: 100));
    print("...");
  }
  print("OK");
  return Future.sync(() => w);
}

void sendWebSocket(WebSocket w, dynamic d) {
  w.send(d);
}
