import 'package:flutter/material.dart';
import 'screens/index.dart';
import "styling.dart";

void main() {
  runApp(MaterialApp(
    home: new MainPage(),
    routes: <String, WidgetBuilder>{
      "/MainPage": (BuildContext context) => new MainPage(),
      "/history": (BuildContext context) => new History(),
    },
  ));
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: new Scaffold(
        appBar: AppBar(
          title: Text("BMI Calculator"),
          actions: <Widget>[
            PopupMenuButton<int>(
                onSelected: (item) => _onClickPopupMenuButton(item, context),
                itemBuilder: (context) => [
                      PopupMenuItem<int>(value: 0, child: Text("Author")),
                      PopupMenuItem<int>(value: 1, child: Text("History")),
                    ])
          ],
        ),
        body: new SingleChildScrollView(
          child: new Container(
            margin: new EdgeInsets.all(appSpacing * 2),
            child: Home(),
          ),
        ),
      ),
    );
  }
}

_onClickPopupMenuButton(int item, BuildContext context) {
  switch (item) {
    case 0:
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const Authorship()),
      );
      break;
    case 1:
      Navigator.of(context).pushNamed("/history");
      break;
  }
}
