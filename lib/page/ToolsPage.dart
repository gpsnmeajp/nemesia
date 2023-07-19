import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/GlobalModel.dart';
import '../common/common_design.dart';
import '../common/class.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
        child: Text(
      'Settings',
    ));
  }
}
