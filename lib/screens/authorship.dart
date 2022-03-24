import 'package:flutter/material.dart';
import "../styling.dart";

class Authorship extends StatelessWidget {
  const Authorship({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color defaultBodyTextColor = Theme.of(context).textTheme.bodyText1.color;
    return Scaffold(
        appBar: AppBar(
          title: const Text('Author'),
        ),
        body: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center, children: [
          Center(
              child: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(children: [
              TextSpan(text: "Lab 1 Task\n", style: TextStyle(fontWeight: FontWeight.bold, fontSize: appFontSize * 2, color: defaultBodyTextColor)),
              TextSpan(text: "Argi Candri - 268894", style: TextStyle(fontSize: appFontSize * 1.5, color: defaultBodyTextColor)),
            ]),
          ))
        ]));
  }
}
