import 'package:flutter/material.dart';
import 'package:nemesia/page/CommunicationDialogPage.dart';
import 'package:nemesia/page/SendDialogPage.dart';
import 'package:provider/provider.dart';
import 'model/HomeTimelineModel.dart';
import 'common/common_design.dart';
import 'page/HomeTimelinePage.dart';
import 'page/MyProfilePage.dart';
import 'page/NotificationsPage.dart';
import 'page/SettingsPage.dart';
import 'page/ToolsPage.dart';
import 'common/class.dart';
import 'repository/relay_repository.dart';

// flutter build web --release --base-href /nemesia/

const title = 'Nemesia for nostr';

class FlutterErrorHolder {
  static List<FlutterErrorDetails> errors = List.empty(growable: true);
  static void add(FlutterErrorDetails details) {
    errors.add(details);
  }
}

// エントリーポイント
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  FlutterError.onError = (FlutterErrorDetails details) {
    debugPrint(details.exception.toString());
    debugPrint(details.stack.toString());
  };
  RelayRepository();
  runApp(ChangeNotifierProvider(
      create: (_) => HomeTimelineModel(), child: const MyApp()));
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
              child: SafeArea(child: ScreenSwitcher()))),
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
    return Consumer<HomeTimelineModel>(
        builder: (context, model, _) => Scaffold(
              appBar: AppBarWithBackground(
                  appBar: AppBar(
                actions: [
                  IconButton(
                    onPressed: () => showDialog(
                        context: context,
                        builder: (_) => AlertDialog(
                              content: Text(
                                  "Licence: https://github.com/gpsnmeajp/nemesia"),
                            )),
                    icon: Icon(Icons.home),
                  )
                ],
                title: const Text(title),
                backgroundColor: Colors.transparent,
                flexibleSpace: InkWell(
                  onTap: () async {
                    if (model.homeTimelineScrollController.position.pixels <
                        10) {
                      Navigator.push(context, CommunicationDialogPage());
                      await model.renewHomeTimeline();

                      if (!context.mounted) return;
                      Navigator.pop(context);
                    }
                    model.homeTimelineScrollController.animateTo(0,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut);
                  },
                ),
              )),
              body: _screens[model.tabIndex],
              bottomNavigationBar: Container(
                  height: 70,
                  child: BottomNavigationBar(
                      currentIndex: model.tabIndex,
                      onTap: (int index) {
                        model.setTabPage(index);
                      },
                      type: BottomNavigationBarType.fixed,
                      items: const <BottomNavigationBarItem>[
                        BottomNavigationBarItem(
                            icon: Icon(Icons.home), label: "Home"),
                        BottomNavigationBarItem(
                            icon: Icon(Icons.notifications),
                            label: "Notification"),
                        BottomNavigationBarItem(
                            icon: Icon(Icons.person), label: "Me"),
                        BottomNavigationBarItem(
                            icon: Icon(Icons.build), label: "Tools"),
                        BottomNavigationBarItem(
                            icon: Icon(Icons.settings), label: "Settings"),
                      ])),
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  Navigator.push(context, SendDialogPage());
                },
                tooltip: 'Increment',
                child: const Icon(Icons.add),
              ),
            ));
  }
}
