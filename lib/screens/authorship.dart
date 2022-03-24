import 'package:flutter/material.dart';
import "../styling.dart";
import "../constants.dart";

class Authorship extends StatelessWidget {
  const Authorship({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color defaultBodyTextColor = Theme.of(context).textTheme.bodyText1.color;
    return Scaffold(
        appBar: AppBar(
          title: Text(Constants.authorship['appTitle']),
        ),
        body: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center, children: [
          Center(
              child: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(children: [
              TextSpan(text: Constants.authorship['title'], style: TextStyle(fontWeight: FontWeight.bold, fontSize: appFontSize * 2, color: defaultBodyTextColor)),
              TextSpan(text: Constants.authorship['author'], style: TextStyle(fontSize: appFontSize * 1.5, color: defaultBodyTextColor)),
            ]),
          ))
        ]));
  }
}
