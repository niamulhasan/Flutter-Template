import 'package:alquranbd_pro/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class First extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ThemeChanger _themeChanger = Provider.of<ThemeChanger>(context);

    return new Container(
      child: new Center(
          // child: new Icon(Icons.beach_access, size: 150.0, color: Colors.blue)
          child: Column(children: <Widget>[
        FlatButton(
          child: Text('Dark'),
          onPressed: () => _themeChanger.setTheme(ThemeData.dark()),
        ),
        FlatButton(
          child: Text('Light'),
          onPressed: () => _themeChanger.setTheme(ThemeData.light()),
        )
      ])),
    );
  }
}
