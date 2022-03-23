import 'package:flutter/material.dart';
import "../data_templates/bmi_result.dart";

class Result extends StatelessWidget {
  Result(this.bmiResult);
  final BmiResult bmiResult;

  _bmiResultText() {
    print(bmiResult);
    print(bmiResult.toString());
    return "$bmiResult[0].height";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Result'),
        ),
        body: Center(child: new RichText(text: TextSpan(text: _bmiResultText()))));
  }
}
