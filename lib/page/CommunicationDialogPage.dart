import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/HomeTimelineModel.dart';
import '../common/common_design.dart';
import '../common/class.dart';

class CommunicationDialogPage extends ModalRoute<void> {
  @override
  Color? get barrierColor => Colors.black.withOpacity(0.5);

  @override
  bool get barrierDismissible => false;

  @override
  String? get barrierLabel => null;

  @override
  bool get maintainState => true;

  @override
  bool get opaque => false;

  @override
  Duration get transitionDuration => const Duration(milliseconds: 100);

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return Material(
        type: MaterialType.transparency,
        child: Consumer<HomeTimelineModel>(
          builder: (context, model, _) => Container(
              margin: const EdgeInsets.fromLTRB(20, 20, 20, 20),
              color: Colors.black.withAlpha(128),
              child: Container(
                  margin: const EdgeInsets.all(20),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const Text("Please wait...",
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.clip,
                            style:
                                TextStyle(color: Colors.white, fontSize: 24)),
                        SizedBox(
                          height: 20,
                        ),
                        Expanded(
                            child: Text(model.logText,
                                textAlign: TextAlign.left,
                                overflow: TextOverflow.clip,
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 10)))
                      ]))),
        ));
  }
}
