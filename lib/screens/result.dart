import 'package:flutter/material.dart';
import "../data_templates/bmi_result.dart";

class Result extends StatefulWidget {
  const Result({Key key}) : super(key: key);

  @override
  _ResultState createState() => _ResultState();
}

class _ResultState extends State<Result> {
  _bmiResultText() {
    return "$bmiResult.height";
  }

  @override
  Widget build(BuildContext context) {
    final bmiResult = ModalRoute.of(context).settings.arguments as BmiResult;

    return Scaffold(
        appBar: AppBar(
          title: const Text('Result'),
        ),
        body: Center(child: new RichText(text: TextSpan(text: _bmiResultText()))));
  }
}
