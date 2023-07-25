import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:nostr/nostr.dart';

import 'dart:convert';
import '../common/class.dart';
import '../repository/relay_repository.dart';
import '../repository/repository_interfaces.dart';
import '../repository/image_repository.dart';
import '../repository/metadata_repository.dart';
import 'package:http/http.dart' as http;
import 'package:metadata_fetch/metadata_fetch.dart';
import 'package:intl/intl.dart';

class HomeTimelineModel extends ChangeNotifier {
  late RelayRepository relayRepository;
  List<TimelineListItemData> timelineListItems = [];
  int tabIndex = 0;
  ScrollController homeTimelineScrollController = ScrollController();
  String logText = "Test";

  HomeTimelineModel() {
    //Repositoryを初期化
    relayRepository = RelayRepository();
    relayRepository.setLogHandler((String message) {
      logText =
          "[${DateFormat.Hms().format(DateTime.now())}] $message\n$logText";
      if (logText.length >= 4096) {
        logText = logText.substring(0, 4096);
      }
      notifyListeners();
    });

    renewHomeTimeline();
  }

  Future<void> renewHomeTimeline() async {
    var mypubkey = await relayRepository.getMyPubkey();
    List<String>? pubkeys;
    if (mypubkey != null) {
      pubkeys = await relayRepository.getContactList(mypubkey);
    }

    // --- kind 1

    List<TextNote> textNotes = await relayRepository.getTextNotes(
      authers: pubkeys,
      // since: (DateTime.now().subtract(const Duration(minutes: 30))),
      limit: 80,
    );

    //ID, subnote
    Map<String, String> subNotes = {};

    timelineListItems.clear();
    for (var n in textNotes) {
      TimelineListItemData v = TimelineListItemData();
      v.id = n.id;
      v.date = n.createdAt;
      v.body = n.content;
      v.cw = n.nip36;

      v.onLike = (_) async {
        if (!v.liked && !n.repost) {
          await relayRepository.postReaction(
              pubkey: n.pubkey, noteId: n.id, reaction: "+");
          v.liked = true;
          notifyListeners();
        }
      };
      v.onRepost = (_) async {
        if (!v.reposted && !n.repost) {
          await relayRepository.postRepost(n);
          v.reposted = true;
          notifyListeners();
        }
      };

      for (var r in n.relays) {
        v.detail += r + "\n";
      }

      v.userName = n.autherMetadata?.displayName ?? n.pubkey;
      v.handle = "@${n.autherMetadata?.name ?? ""}";

      Future.delayed(const Duration(milliseconds: 100), () async {
        timelineListItems.firstWhere((element) => element.id == v.id).icon =
            n.autherMetadata?.picture != null
                ? await FetchImageInterface.getImageFromURL(
                    n.autherMetadata!.picture!)
                : null;
      });

      RegExp _urlReg = RegExp(
        r'https?://([\w-]+\.)+[\w-]+(/[\w-./?%&=#]*)?',
      );
      String? url = _urlReg.firstMatch(n.content)?.group(0);
      if (url != null) {
        if (url.endsWith("png") ||
            url.endsWith("jpg") ||
            url.endsWith("jpeg") ||
            url.endsWith("gif")) {
          Future.delayed(const Duration(milliseconds: 100), () async {
            timelineListItems
                .firstWhere((element) => element.id == v.id)
                .ogpImage = await FetchImageInterface.getImageFromURL(url);
          });
        } else {
          try {
            Future.delayed(const Duration(milliseconds: 100), () async {
              var ogpRes = await OGPMetadataInterface.getMetaDataFromURL(url);
              timelineListItems
                  .firstWhere((element) => element.id == v.id)
                  .ogpImage = ogpRes?.image;
              timelineListItems
                  .firstWhere((element) => element.id == v.id)
                  .ogpText = ogpRes?.title ?? "";
            });
          } catch (e) {
            //Do noting (Failed)
          }
        }
      }

      EventId? note;
      try {
        note = Nip19.encodeNote(
            n.tags.firstWhere((element) => element[0] == "e")[1]);
        if (note != null) {
          subNotes[v.id] = note;
        }
      } catch (e) {
        // Do noting
      }

      RegExp _npubReg = RegExp(
        r'(nostr:npub([\w-]+))',
      );
      var npub = _npubReg.firstMatch(n.content)?.group(0);
      if (npub != null) {
        v.body = v.body.replaceAll(npub, "[nostr:npub]");
      }

      RegExp _neventReg = RegExp(
        r'(nostr:nevent1([\w-]+))',
      );
      var nevent = _neventReg.firstMatch(n.content)?.group(0);
      if (nevent != null) {
        v.body = v.body.replaceAll(nevent, "[nostr:nevent1]");
      }

      RegExp _noteReg = RegExp(
        r'(nostr:note1([\w-]+))',
      );
      note = _noteReg.firstMatch(n.content)?.group(0);
      if (note != null) {
        print("→→→→→ " + note);
        subNotes[v.id] = note.replaceFirst("nostr:", "");
      }

      timelineListItems.add(v);
    }
    timelineListItems.sort(((a, b) => b.date.compareTo(a.date)));
    notifyListeners();

    // 追加部分の読み込みを後回しにする
    Future.delayed(Duration(milliseconds: 100), () async {
      List<String> subNotesList = List.empty(growable: true);
      subNotes.forEach((key, value) async {
        subNotesList.add(value);
      });

      if (subNotesList.isNotEmpty) {
        List<TextNote> subtextNotes =
            await relayRepository.getTextNotes(ids: subNotesList);
        for (var n2 in subtextNotes) {
          var v = TimelineListItemData();
          v.date = n2.createdAt;
          v.body = n2.content;
          v.cw = n2.nip36;
          v.userName = n2.autherMetadata?.displayName ?? n2.pubkey;
          v.handle = "@${n2.autherMetadata?.name ?? ""}";
          v.icon = n2.autherMetadata?.picture != null
              ? await FetchImageInterface.getImageFromURL(
                  n2.autherMetadata!.picture!)
              : null;

          RegExp _urlReg = RegExp(
            r'https?://([\w-]+\.)+[\w-]+(/[\w-./?%&=#]*)?',
          );
          String? url = _urlReg.firstMatch(n2.content)?.group(0);
          if (url != null) {
            if (url.endsWith("png") ||
                url.endsWith("jpg") ||
                url.endsWith("jpeg") ||
                url.endsWith("gif")) {
              v.ogpImage = await FetchImageInterface.getImageFromURL(url);
            } else {
              try {
                var ogpRes = await OGPMetadataInterface.getMetaDataFromURL(url);
                v.ogpImage = ogpRes?.image;
                v.ogpText = ogpRes?.title ?? "";
              } catch (e) {
                //Do noting (Failed)
              }
            }
          }
          v.headDetail = "⇨ Repost";
          // 探索して代入
          try {
            var key = subNotes.entries
                .firstWhere((element) => element.value == n2.id)
                .key;

            timelineListItems
                .firstWhere((element) => element.id == key)
                .nextMemoData = v;
          } catch (e) {
            debugPrint(e.toString());
          }
        }
        notifyListeners();
      }
    });
  }

  TimelineListItemData getTimelineItem(int index) {
    if (index >= timelineListItems.length) {
      return TimelineListItemData();
    }
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
