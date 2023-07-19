import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'model/GlobalModel.dart';
import 'common/common_design.dart';
import 'page/HomeTimelinePage.dart';
import 'page/MyProfilePage.dart';
import 'page/NotificationsPage.dart';
import 'page/SettingsPage.dart';
import 'page/ToolsPage.dart';
import 'common/class.dart';
import 'repository/RelayRepository.dart';

// flutter build web --release --base-href /nemesia/

const title = 'Nemesia for nostr';

// エントリーポイント
void main() {
  RelayRepository();
  runApp(ChangeNotifierProvider(
      create: (_) => GlobalModel(), child: const MyApp()));
}

// トップレベル
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nemesia',
      scrollBehavior: CustomScrollBehavior(),
      themeMode: ThemeMode.dark,
      theme: ThemeData.light(useMaterial3: true),
      darkTheme: ThemeData.dark(useMaterial3: true),
      home: Align(
          alignment: Alignment.topCenter,
          child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 800),
              child: ScreenSwitcher())),
    );
  }
}

class ScreenSwitcher extends StatelessWidget {
  const ScreenSwitcher({super.key});

  static final _screens = [
    const HomeTimelinePage(),
    const NotificationsPage(),
    const MyProfilePage(),
    const ToolsPage(),
    const SettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<GlobalModel>(
        builder: (context, model, _) => Scaffold(
              appBar: AppBarWithBackground(
                  appBar: AppBar(
                title: const Text(title),
                backgroundColor: Colors.transparent,
                flexibleSpace: InkWell(
                  onTap: () {
                    model.homeTimelineScrollController.animateTo(0,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut);
                  },
                ),
              )),
              body: _screens[model.tabIndex],
              bottomNavigationBar: BottomNavigationBar(
                  currentIndex: model.tabIndex,
                  onTap: (int index) {
                    model.setTabPage(index);
                  },
                  type: BottomNavigationBarType.fixed,
                  items: const <BottomNavigationBarItem>[
                    BottomNavigationBarItem(
                        icon: Icon(Icons.home), label: "Home"),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.notifications), label: "Notification"),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.person), label: "Me"),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.build), label: "Tools"),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.settings), label: "Settings"),
                  ]),
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  model.setTabPage(0);
                },
                tooltip: 'Increment',
                child: const Icon(Icons.add),
              ),
            ));
  }
}
