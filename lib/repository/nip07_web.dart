@JS()
library bridge;

import 'dart:convert';

import 'repository_interfaces.dart';
import 'package:js/js.dart';
import 'package:js/js_util.dart';

@JS("nip07getPublicKey")
external _nip07getPublicKey();

@JS("nip07signEvent")
external _nip07signEvent(String event);

class Nip07 {
  static String? pubkeyCache;

  static Future<String?> getPublicKey() async {
    if (pubkeyCache == null) {
      String pubkey = await promiseToFuture(_nip07getPublicKey());
      if (pubkey == "") {
        return null;
      }
      pubkeyCache = pubkey;
    }
    return pubkeyCache;
  }

  static Future<Nip07Event?> signEvent(Nip07Event event) async {
    String input = jsonEncode(event.toJson());
    String output = await promiseToFuture(_nip07signEvent(input));
    if (output == "") {
      return null;
    }
    return Nip07Event.fromJson(jsonDecode(output));
  }
}
