import 'package:alquranbd_pro/theme.dart';
import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
// Importing Splited Files
import './FirstPage.dart' as firstPage;
import './SceondPage.dart' as sceondPage;
import './ThirdPage.dart' as thirdPage;

//Import the Drawer Menu Pages
import './about.dart';
import './contact.dart';
import 'config/theme.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    systemNavigationBarColor: Colors.blue, // navigation bar color
    statusBarColor: Colors.white, // status bar color
  ));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ThemeChanger>(
      builder: (_) => ThemeChanger(ThemeData.dark()),
      child: new MaterialAppWithTheme(),
    );
  }
}

class MaterialAppWithTheme extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeChanger>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: new Tabs(),
      theme: theme.getTheme(),
    );
  }
}

class Tabs extends StatefulWidget {
  @override
  TabsState createState() => new TabsState();
}

class TabsState extends State<Tabs> with SingleTickerProviderStateMixin {
  ScrollController _scrollViewController;
  TabController controller;

  @override
  void initState() {
    super.initState();
    _scrollViewController = new ScrollController();
    controller = new TabController(vsync: this, length: 3);
    controller.addListener(_handleTabSelection);
  }

  void _handleTabSelection() {
    setState(() {});
  }

  @override
  void dispose() {
    _scrollViewController = new ScrollController();
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: new Drawer(
        child: ListView(
          children: <Widget>[
            new UserAccountsDrawerHeader(
              accountName: new Text("Niamul Hasan"),
              accountEmail: new Text("example@testmail.com"),
              currentAccountPicture: new CircleAvatar(
                backgroundImage: new NetworkImage('https://i.pravatar.cc/300'),
              ),
            ),
            new ListTile(
              title: new Text('About'),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (BuildContext context) => new AboutPage()));
              },
            ),
            new Divider(),
            new ListTile(
              title: new Text('Contact'),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (BuildContext context) => new ContactPage()));
              },
            )
          ],
        ),
      ),
      body: new NestedScrollView(
        controller: _scrollViewController,
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            new SliverAppBar(
              elevation: 0,
              brightness: Brightness.light,
              backgroundColor: Colors.white,
              automaticallyImplyLeading: false,
              title: SizedBox(
                width: double.infinity,
                // height: double.infinity,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(6, 6, 6, 5),
                  child: Card(
                    elevation: 3.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Row(
                      children: <Widget>[
                        IconButton(
                          icon: Icon(Icons.sort, color: Colors.blueGrey[600]),
                          onPressed: () => Scaffold.of(context).openDrawer(),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              pinned: true,
              floating: true,
              forceElevated: innerBoxIsScrolled,
              bottom: new TabBar(
                controller: controller,
                indicatorColor: Colors.greenAccent[700],
                tabs: <Tab>[
                  new Tab(
                      icon: new Icon(Icons.beach_access,
                          color: controller.index == 0
                              ? ThemeColors.getDeepColor("green")
                              : ThemeColors.getLightColor("green"))),
                  new Tab(
                      icon: new Icon(Icons.local_activity,
                          color: controller.index == 1
                              ? ThemeColors.getDeepColor("green")
                              : ThemeColors.getLightColor("green"))),
                  new Tab(
                      icon: new Icon(
                    Icons.account_balance_wallet,
                    color: controller.index == 2
                        ? ThemeColors.getDeepColor("green")
                        : ThemeColors.getLightColor("green"),
                  )),
                ],
              ),
            )
          ];
        },
        body: TabBarView(
          controller: controller,
          children: <Widget>[
            new firstPage.First(),
            new sceondPage.Second(),
            new thirdPage.Third()
          ],
        ),
      ),
    );
  }
}
