import 'package:flutter/material.dart';
import 'screens/index.dart';

void main() => runApp(new MaterialApp(
      home: new Home(),
      routes: <String, WidgetBuilder>{
        "/home": (BuildContext context) => new Home(),
        "/history": (BuildContext context) => new History(),
      },
    ));
