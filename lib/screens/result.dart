import 'package:flutter/material.dart';
import "../data_templates/bmi_result.dart";

class Result extends StatelessWidget {
  Result(this.bmiResult);
  final BmiResult bmiResult;

  String _bmiHeight() {
    return bmiResult.height;
  }

  String _bmiWeight() {
    return bmiResult.weight;
  }

  String _bmiScore() {
    return bmiResult.bmi;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Result'),
        ),
        body: Center(
            child: new RichText(
          text: const TextSpan(children: [
            TextSpan(text: _bmiHeight(), style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red)),
            TextSpan(text: _bmiWeight(), style: TextStyle(fontStyle: FontStyle.italic, color: Colors.purple)),
            TextSpan(text: _bmiScore(), style: TextStyle(color: Colors.green))
          ]),
        )));
  }
}
