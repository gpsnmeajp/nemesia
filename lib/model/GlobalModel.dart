import 'package:flutter/material.dart';
import 'package:nostr/nostr.dart';

import 'dart:convert';
import '../common/class.dart';
import '../repository/RelayRepository.dart';
import 'package:http/http.dart' as http;
import 'package:metadata_fetch/metadata_fetch.dart';

class GlobalModel extends ChangeNotifier {
  late RelayRepository relayRepository;
  List<TimelineListItemData> timelineListItems = [];
  int tabIndex = 0;
  ScrollController homeTimelineScrollController = ScrollController();

  GlobalModel() {
    //Repositoryを初期化
    relayRepository = RelayRepository();

    Future.sync(() async {
      //リレーに接続
      await relayRepository.connect();

      print("Hello");
      // お試しkind1
      int epochTimeSec_before30min =
          ((DateTime.now().subtract(Duration(minutes: 30)))
                      .millisecondsSinceEpoch /
                  1000)
              .floor();

      relayRepository.addSubscribeRequestFromFilter([
        Filter(
          kinds: [1],
          //受信する最低時刻
          since: epochTimeSec_before30min,
          //最初に受信するイベント数の上限
          limit: 10,
        )
      ], (event) async {
        if (event.kind == 1) {
          TimelineListItemData v = TimelineListItemData();
          v.date = DateTime.fromMillisecondsSinceEpoch(event.createdAt * 1000);
          v.body = event.content;
          v.handle = event.pubkey;

          // NIP-36 Check
          try {
            v.cw = event.tags
                .firstWhere((element) => element[0] == "content-warning")[1];
          } catch (e) {
            // Do noting
          }

          if (relayRepository.profiles.containsKey(event.pubkey)) {
            var p = jsonDecode(relayRepository.profiles[event.pubkey]!.content);
            if (p.containsKey("name")) {
              v.userName = p["displayName"] ?? p["display_name"] ?? "";
              v.handle = "@" + (p["name"] ?? "");
            }
            if (p.containsKey("picture")) {
              if (p["picture"].startsWith("https://") ||
                  p["picture"].startsWith("http://")) {
                v.icon = p["picture"];
              }
            }
          }

          String? note;
          try {
            note = event.tags.firstWhere((element) => element[0] == "e")[1];
          } catch (e) {
            // Do noting
          }
          if (note != null) {
            final request = [
              Filter(
                kinds: [1],
                limit: 1,
                ids: [note],
              )
            ];
            try {
              final m = await relayRepository.oneshotRequest(request);
              v.nextMemoData = TimelineListItemData();
              v.nextMemoData!.date =
                  DateTime.fromMillisecondsSinceEpoch(m.createdAt * 1000);
              v.nextMemoData!.body = m.content;
              v.nextMemoData!.handle = m.pubkey;

              // NIP-36 Check
              try {
                v.nextMemoData!.cw = m.tags.firstWhere(
                    (element) => element[0] == "content-warning")[1];
              } catch (e) {
                // Do noting
              }

              if (relayRepository.profiles.containsKey(m.pubkey)) {
                var p = jsonDecode(relayRepository.profiles[m.pubkey]!.content);
                if (p.containsKey("name")) {
                  v.nextMemoData!.userName =
                      p["displayName"] ?? p["display_name"] ?? "";
                  v.nextMemoData!.handle = "@" + (p["name"] ?? "");
                }
                if (p.containsKey("picture")) {
                  if (p["picture"].startsWith("https://") ||
                      p["picture"].startsWith("http://")) {
                    v.nextMemoData!.icon = p["picture"];
                  }
                }
              }
            } catch (e) {
              print("timeout");
              //Do noting (timeout error)
            }
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

          RegExp _noteReg = RegExp(
            r'nostr:note1([\w-]+)',
          );
          v.body = v.body.replaceAll(_noteReg, "");

          timelineListItems.add(v);
          //print(event.content);
          //print(event.createdAt);

          timelineListItems.sort(((a, b) => b.date.compareTo(a.date)));
          notifyListeners();
        }
      },
          (subscriptionId) => {
                // NO EOSE
              });
    });
  }

  TimelineListItemData getTimelineItem(int index) {
    return timelineListItems[index];
  }

  int getTimelineItemLength() {
    return timelineListItems.length;
  }

  void cwOpen(int index, bool isChild) {
    if (isChild) {
      timelineListItems[index].nextMemoData?.cwOpen = true;
    } else {
      timelineListItems[index].cwOpen = true;
    }
    notifyListeners();
  }

  void setTabPage(int index) {
    tabIndex = index;
    notifyListeners();
  }

  void update() {
    notifyListeners();
  }
}
