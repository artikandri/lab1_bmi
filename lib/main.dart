import 'package:flutter/material.dart';
import 'screens/index.dart';

void main() {
  runApp(MaterialApp(
    home: new Home(),
    routes: <String, WidgetBuilder>{
      "/home": (BuildContext context) => new Home(),
      "/history": (BuildContext context) => new History(),
      "/result": (BuildContext context) => new Result(),
    },
  ));
}
