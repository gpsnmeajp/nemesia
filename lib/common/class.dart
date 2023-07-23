import 'package:flutter/foundation.dart';

class TimelineListItemData {
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
  TimelineListItemData? nextMemoData;
}
