import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'model.dart';
import 'common_design.dart';

const title = 'Nemesia for nostr';

// エントリーポイント
void main() {
  runApp(ChangeNotifierProvider(create: (_) => Model(), child: const MyApp()));
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
  static final _screens = [
    const HomeTimelinePage(),
    const NotificationsPage(),
    const MyProfilePage(),
    const ToolsPage(),
    const SettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<Model>(
        builder: (context, model, _) => Scaffold(
              appBar: AppBarWithBackground(
                  appBar: AppBar(
                title: const Text(title),
                backgroundColor: Colors.transparent,
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
              ), // This trailing comma makes auto-formatting nicer for build methods.
            ));
  }
}

class HomeTimelinePage extends StatelessWidget {
  const HomeTimelinePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Consumer<Model>(
        builder: (context, model, _) =>
            ListView.builder(itemBuilder: (context, index) {
          return TimelineListItem(key: key, i: index);
        }),
      ),
    );
  }
}

class TimelineListItem extends StatelessWidget {
  final int i;
  const TimelineListItem({super.key, required this.i});

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
        constraints: const BoxConstraints(minHeight: 100),
        child: Card(
            margin: EdgeInsets.all(10),
            child: Container(
                padding: const EdgeInsets.all(10),
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.topRight,
                      child: Text("1d"),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.warning, size: 16),
                            Text("補足情報"),
                          ],
                        ),
                        Row(children: [
                          Icon(Icons.person, size: 50),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text("ユーザー名"),
                                  Text("@user1"),
                                ],
                              ),
                              Text("補足情報"),
                            ],
                          )
                        ]),
                        Container(
                            padding: const EdgeInsets.all(10),
                            child: Text(
                                "Twitterの動乱に巻き込まれ、移住先に選ばれつつある Threads が5日で1億人を突破した今日このごろ、皆様いかがお過ごしでしょうか。\n\nAlt Twitterとしての各種サービスに注目が集まりつつありますが、それらに関しての解説記事も乱立しており、一方で、その正確性や内容には必ずしも正確ではないものもあります。\n\nプロトコルとアプリとサービスの区別がついていなかったり、相互接続できないものが接続できると宣伝されていたり、その逆もあります。\n\n本記事では、特にネットワークに基づいて、各種SNSを分類して説明します。\nこれは、ユーザーが一番重視するであろう 「どこに参加すると誰とつながるのか」 を決めるのは、「あなたはどのネットワークに参加するか」 で決まるためです。")),
                        Container(
                            padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
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
                                ])),
                      ],
                    )
                  ],
                ))));
  }
}

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
        child: Text(
      'Notifications',
    ));
  }
}

class MyProfilePage extends StatelessWidget {
  const MyProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
        child: Text(
      'MyProfile',
    ));
  }
}

class ToolsPage extends StatelessWidget {
  const ToolsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
        child: Text(
      'Tools',
    ));
  }
}

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
