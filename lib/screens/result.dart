import 'package:flutter/material.dart';

class BmiResult {
  final String height;
  final String weight;
  final String bmi;

  const BmiResult(this.height, this.weight, this.bmi);
}

class Result extends StatefulWidget {
  const Result({Key key}) : super(key: key);

  @override
  _ResultState createState() => _ResultState();
}

class _ResultState extends State<Result> {
  @override
  Widget build(BuildContext context) {
    final bmiResult = ModalRoute.of(context).settings.arguments as BmiResult;

    return Scaffold(
        appBar: AppBar(
          title: const Text('Result'),
        ),
        body: Center(child: const Text("Result")));
  }
}
