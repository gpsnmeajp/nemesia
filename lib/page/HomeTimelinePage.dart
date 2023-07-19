import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/GlobalModel.dart';
import '../common/common_design.dart';
import '../common/class.dart';

class HomeTimelinePage extends StatelessWidget {
  const HomeTimelinePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Consumer<GlobalModel>(
          builder: (context, model, _) => ListView.builder(
              controller: model.homeTimelineScrollController,
              itemCount: model.getTimelineItemLength(),
              itemBuilder: (context, index) {
                return TimelineListItem(
                  model.getTimelineItem(index),
                  key: key,
                  isShowBar: true,
                );
              })),
    );
  }
}
