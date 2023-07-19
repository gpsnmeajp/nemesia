import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:url_launcher/url_launcher.dart';
import '../common/class.dart';
import '../model/GlobalModel.dart';

// スクロール設定
class CustomScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices =>
      {PointerDeviceKind.touch, PointerDeviceKind.mouse};
}

// グラデーション背景
class AppBarWithBackground extends StatelessWidget
    implements PreferredSizeWidget {
  AppBarWithBackground({
    super.key,
    required this.appBar,
  }) : preferredSize = appBar.preferredSize;

  final AppBar appBar;

  @override
  final Size preferredSize;

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(colors: [
        Color.fromARGB(255, 145, 48, 255),
        Color.fromARGB(255, 40, 34, 212)
      ], begin: Alignment.topLeft, end: Alignment.bottomRight))),
      appBar
    ]);
  }
}

// タイムラインのカード1枚
class TimelineListItem extends StatelessWidget {
  final TimelineListItemData data;
  final bool isShowBar;
  final Color? color;
  const TimelineListItem(this.data,
      {super.key, required, required this.isShowBar, this.color});

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
        constraints: const BoxConstraints(minHeight: 100),
        child: Card(
            color: color,
            margin: EdgeInsets.all(10),
            child: Container(
                padding: const EdgeInsets.all(10),
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.topRight,
                      child: Text(data.date.toString()),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(data.headDetail),
                        TimelineListItemNameplate(data),
                        Container(
                            padding: const EdgeInsets.all(10),
                            child: Linkify(
                                text: data.body,
                                linkStyle: const TextStyle(
                                    color: Colors.blue,
                                    decoration: TextDecoration.none),
                                onOpen: (url) =>
                                    launchUrl(Uri.parse(url.url)))),
                        data.nextMemoData != null
                            ? Container(
                                alignment: Alignment.center,
                                padding: const EdgeInsets.all(10),
                                child: TimelineListItem(
                                  data.nextMemoData!,
                                  isShowBar: false,
                                  color: const Color.fromARGB(255, 64, 64, 64),
                                ),
                              )
                            : Container(),
                        data.ogpImageUrl != null
                            ? TimelineListItemOGP(data)
                            : Container(),
                        isShowBar ? TimelineListItemBar(data) : Container(),
                      ],
                    )
                  ],
                ))));
  }
}

class TimelineListItemOGP extends StatelessWidget {
  final TimelineListItemData data;
  const TimelineListItemOGP(this.data, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                ConstrainedBox(
                  constraints:
                      const BoxConstraints(maxHeight: 500, maxWidth: 500),
                  child: Image.network(data.ogpImageUrl!),
                ),
                SizedBox(height: 5),
                Text(data.ogpText!)
              ],
            )));
  }
}

class TimelineListItemNameplate extends StatelessWidget {
  final TimelineListItemData data;
  const TimelineListItemNameplate(this.data, {super.key});

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      ConstrainedBox(
        constraints: const BoxConstraints(maxHeight: 50, maxWidth: 50),
        child: data.icon == ""
            ? const Icon(Icons.person, size: 50)
            : Image.network(
                data.icon,
                filterQuality: FilterQuality.medium,
              ),
      ),
      Container(padding: const EdgeInsets.fromLTRB(10, 0, 0, 0)),
      Expanded(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                  child: Text(
                data.userName,
              )),
              Container(padding: const EdgeInsets.fromLTRB(10, 0, 0, 0)),
              Expanded(
                child: Text(data.handle, overflow: TextOverflow.ellipsis),
              ),
            ],
          ),
          Text(data.detail),
        ],
      ))
    ]);
  }
}

class TimelineListItemBar extends StatelessWidget {
  final TimelineListItemData data;
  const TimelineListItemBar(this.data, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          IconButton(
              hoverColor: Colors.transparent,
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onPressed: () {},
              icon: Icon(Icons.reply_rounded)),
          IconButton(
              hoverColor: Colors.transparent,
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onPressed: () {},
              icon: Icon(Icons.repeat)),
          IconButton(
              hoverColor: Colors.transparent,
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onPressed: () {},
              icon: Icon(Icons.thumb_up)),
          IconButton(
              hoverColor: Colors.transparent,
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onPressed: () {},
              icon: Icon(Icons.menu)),
        ]));
  }
}
