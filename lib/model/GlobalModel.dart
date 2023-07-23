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

class GlobalModel extends ChangeNotifier {
  late RelayRepository relayRepository;
  List<TimelineListItemData> timelineListItems = [];
  int tabIndex = 0;
  ScrollController homeTimelineScrollController = ScrollController();

  GlobalModel() {
    //Repositoryを初期化
    relayRepository = RelayRepository();

    TimelineListItemData v = TimelineListItemData();
    v.userName = "Loading...";
    timelineListItems.add(v);

    Future.sync(() async {
      //リレーに接続
      await relayRepository.connect();

      //初回取得
      renewHomeTimeline();
    });
  }

  Future<void> renewHomeTimeline() async {
    print("Hello");
    var mypubkey = await relayRepository.getMyPubkey();
    List<String>? pubkeys;
    if (mypubkey != null) {
      pubkeys = await relayRepository.getContactList(mypubkey);
    }

    List<TextNote> textNotes = await relayRepository.getTextNotes(
      authers: pubkeys,
      since: (DateTime.now().subtract(const Duration(minutes: 30))),
      limit: 20,
    );

    timelineListItems.clear();
    for (var n in textNotes) {
      TimelineListItemData v = TimelineListItemData();
      v.date = n.createdAt;
      v.body = n.content;
      v.cw = n.nip36;

      for (var r in n.relays) {
        v.detail += r + "\n";
      }

      v.userName = n.autherMetadata?.displayName ?? n.pubkey;
      v.handle = "@${n.autherMetadata?.name ?? ""}";
      v.icon = n.autherMetadata?.picture != null
          ? await FetchImageInterface.getImageFromURL(
              n.autherMetadata!.picture!)
          : null;

      RegExp _urlReg = RegExp(
        r'https?://([\w-]+\.)+[\w-]+(/[\w-./?%&=#]*)?',
      );
      String? url = _urlReg.firstMatch(n.content)?.group(0);
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

      EventId? note;
      try {
        note = Nip19.encodeNote(
            n.tags.firstWhere((element) => element[0] == "e")[1]);
        if (note != null) {
          List<TextNote> res = await relayRepository.getTextNotes(ids: [note]);
          TextNote n2 = res[0];
          v.nextMemoData = TimelineListItemData();
          v.nextMemoData!.date = n2.createdAt;
          v.nextMemoData!.body = n2.content;
          v.nextMemoData!.cw = n2.nip36;
          v.nextMemoData!.userName =
              n2.autherMetadata?.displayName ?? n2.pubkey;
          v.nextMemoData!.handle = "@${n2.autherMetadata?.name ?? ""}";
          v.nextMemoData!.icon = n2.autherMetadata?.picture != null
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
              v.nextMemoData!.ogpImage =
                  await FetchImageInterface.getImageFromURL(url);
            } else {
              try {
                var ogpRes = await OGPMetadataInterface.getMetaDataFromURL(url);
                v.nextMemoData!.ogpImage = ogpRes?.image;
                v.nextMemoData!.ogpText = ogpRes?.title ?? "";
              } catch (e) {
                //Do noting (Failed)
              }
            }
          }
        }
      } catch (e) {
        // Do noting
      }

      timelineListItems.add(v);
    }
    timelineListItems.sort(((a, b) => b.date.compareTo(a.date)));
    notifyListeners();
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
