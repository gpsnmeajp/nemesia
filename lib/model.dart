import 'package:flutter/material.dart';
import 'package:dart_nostr/dart_nostr.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:metadata_fetch/metadata_fetch.dart';

class TimelineListItemData {
  DateTime date = DateTime.now();
  String headDetail = "";
  String detail = "";
  String userName = "";
  String handle = "";
  String icon = "";
  String body = "";
  String? ogpImageUrl;
  String ogpText = "";
}

class Model extends ChangeNotifier {
  Map<String, NostrEvent> profiles = {};
  List<TimelineListItemData> timelineListItems = [];
  int tabIndex = 0;

  Model() {
    print("Hello");
    Future.delayed(const Duration(seconds: 0), () async {
      print("Do");
      await Nostr.instance.relaysService.init(
        lazyListeningToRelays: false,
        retryOnError: true,
        retryOnClose: true,
        relaysUrl: <String>["wss://relay-jp.nostr.wirednet.jp"],
        onRelayError: (relay, error) {
          print("Relay error: $error");
        },
        onRelayDone: (relayUrl) => print("Relay done: $relayUrl"),
        onRelayListening: (relayUrl, receivedData) {
          // print("Relay listening: $relayUrl");
          // print("Relay listening data: $receivedData");
        },
      );
      print("OK");

      final request = NostrRequest(
        filters: <NostrFilter>[
          NostrFilter(
            kinds: <int>[1],
            since: DateTime.now().subtract(Duration(days: 2)),
          ),
        ],
      );

      final requestStream = Nostr.instance.relaysService
          .startEventsSubscription(request: request);

      requestStream.stream.listen((event) async {
        if (event.kind == 1) {
          TimelineListItemData v = TimelineListItemData();
          v.date = event.createdAt;
          v.body = event.content;

          v.handle = event.pubkey;
          if (!profiles.containsKey(event.pubkey)) {
            final request = NostrRequest(
              filters: <NostrFilter>[
                NostrFilter(kinds: <int>[0], limit: 1, authors: [event.pubkey]),
              ],
            );
            final requestStream = Nostr.instance.relaysService
                .startEventsSubscription(request: request);
            var s = requestStream.stream.timeout(Duration(seconds: 5),
                onTimeout: (sink) => sink.close());
            try {
              var p = await s.firstWhere((_) => true);
              profiles[p.pubkey] = p;
            } catch (e) {
              //Do noting (timeout error)
            }
          }

          if (profiles.containsKey(event.pubkey)) {
            var p = jsonDecode(profiles[event.pubkey]!.content);
            if (p.containsKey("name")) {
              v.userName = p["name"];
            }
            if (p.containsKey("picture")) {
              if (p["picture"].startsWith("https://") ||
                  p["picture"].startsWith("http://")) {
                v.icon = p["picture"];
              }
            }
            print(v.userName);
          }

          RegExp _urlReg = RegExp(
            r'https?://([\w-]+\.)+[\w-]+(/[\w-./?%&=#]*)?',
          );
          String? url = _urlReg.firstMatch(event.content)?.group(0);
          if (url != null) {
            if (url.endsWith("png") ||
                url.endsWith("jpg") ||
                url.endsWith("jpeg") ||
                url.endsWith("gif")) {
              v.ogpImageUrl = url;
            } else {
              try {
                var ogpRes = await MetadataFetch.extract(url);
                v.ogpImageUrl = ogpRes?.image;
                v.ogpText = ogpRes?.title ?? "";
              } catch (e) {
                //Do noting (Failed)
              }
            }
          }

          timelineListItems.add(v);
          //print(event.content);
          //print(event.createdAt);

          timelineListItems.sort(((a, b) => b.date.compareTo(a.date)));
          notifyListeners();
        }
      });
    });
  }

  TimelineListItemData getTimelineItem(int index) {
    return timelineListItems[index];
  }

  int getTimelineItemLength() {
    return timelineListItems.length;
  }

  void setTabPage(int index) {
    tabIndex = index;
    notifyListeners();
  }

  void update() {
    notifyListeners();
  }
}
