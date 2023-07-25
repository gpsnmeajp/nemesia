import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:nemesia/repository/relay_repository.dart';
import 'package:provider/provider.dart';
import '../model/HomeTimelineModel.dart';
import '../common/common_design.dart';
import '../common/class.dart';

class SendDialogPage extends ModalRoute<void> {
  @override
  Color? get barrierColor => Colors.black.withOpacity(0.5);

  @override
  bool get barrierDismissible => true;

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
    String message = "";
    return Material(
        type: MaterialType.transparency,
        child: Consumer<HomeTimelineModel>(
          builder: (context, model, _) => Container(
              margin: const EdgeInsets.fromLTRB(50, 50, 50, 50),
              color: Colors.black.withAlpha(240),
              child: Container(
                  margin: const EdgeInsets.all(20),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        Expanded(
                            child: TextField(
                                onChanged: (value) {
                                  message = value;
                                },
                                keyboardType: TextInputType.multiline,
                                maxLines: null,
                                decoration: InputDecoration(
                                    hintText: "Send a message",
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.transparent))))),
                        SizedBox(
                          height: 50,
                          child: ElevatedButton(
                              onPressed: () async {
                                await RelayRepository()
                                    .postMyTextNote(message, []);
                                message = "";
                                if (!context.mounted) return;
                                Navigator.pop(context);
                                Provider.of<HomeTimelineModel>(context,
                                        listen: false)
                                    .renewHomeTimeline();
                              },
                              child: Text("Send",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 24))),
                        ),
                      ]))),
        ));
  }
}
