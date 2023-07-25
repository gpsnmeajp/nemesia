import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/HomeTimelineModel.dart';
import '../common/common_design.dart';
import '../common/class.dart';
import './CommunicationDialogPage.dart';

class HomeTimelinePage extends StatelessWidget {
  const HomeTimelinePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Consumer<HomeTimelineModel>(
          builder: (context, model, _) => RefreshIndicator(
              onRefresh: () async {
                Navigator.push(context, CommunicationDialogPage());
                await model.renewHomeTimeline();

                if (!context.mounted) return;
                Navigator.pop(context);
              },
              child: ListView.builder(
                  controller: model.homeTimelineScrollController,
                  itemCount: model.getTimelineItemLength(),
                  itemBuilder: (context, index) {
                    return TimelineListItem(
                      model.getTimelineItem(index),
                      dataIndex: index,
                      key: key,
                      isChild: false,
                    );
                  }))),
    );
  }
}
