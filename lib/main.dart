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
        builder: (context, model, _) => ListView.builder(
            itemCount: model.getTimelineItemLength(),
            itemBuilder: (context, index) {
              return TimelineListItem(
                  key: key, data: model.getTimelineItem(index));
            }),
      ),
    );
  }
}

class TimelineListItem extends StatelessWidget {
  final TimelineListItemData data;
  const TimelineListItem({super.key, required this.data});

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
                      child: Text(data.date.toString()),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(data.headDetail),
                        Row(children: [
                          data.icon == ""
                              ? Icon(Icons.person, size: 50)
                              : Image.network(
                                  data.icon,
                                  width: 50,
                                  height: 50,
                                  filterQuality: FilterQuality.medium,
                                ),
                          Container(
                              padding: const EdgeInsets.fromLTRB(10, 0, 0, 0)),
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
                                  Container(
                                      padding: const EdgeInsets.fromLTRB(
                                          10, 0, 0, 0)),
                                  Expanded(
                                    child: Text(data.handle,
                                        overflow: TextOverflow.ellipsis),
                                  ),
                                ],
                              ),
                              Text(data.detail),
                            ],
                          ))
                        ]),
                        Container(
                            padding: const EdgeInsets.all(10),
                            child: Text(data.body)),
                        data.ogpImageUrl != null
                            ? Container(
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey)),
                                padding: const EdgeInsets.all(10),
                                child: Column(
                                  children: [
                                    Image.network(data.ogpImageUrl!),
                                    SizedBox(height: 5),
                                    Text(data.ogpText!)
                                  ],
                                ))
                            : Container(),
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
