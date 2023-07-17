import 'package:flutter/material.dart';

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
