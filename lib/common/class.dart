import 'package:flutter/foundation.dart';

class TimelineListItemData {
  String id = "";
  DateTime date = DateTime.now();
  String headDetail = "";
  String detail = "";
  String userName = "";
  String handle = "";
  Uint8List? icon;
  String body = "";
  Uint8List? ogpImage;
  String ogpText = "";
  String? cw;
  bool cwOpen = false;
  bool liked = false;
  int likeCount = 0;
  Function(String id) onLike = (_) {};
  bool reposted = false;
  Function(String id) onRepost = (_) {};
  TimelineListItemData? nextMemoData;
}
