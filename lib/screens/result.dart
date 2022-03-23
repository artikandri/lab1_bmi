import 'package:flutter/material.dart';
import "../data_templates/bmi_result.dart";

class Result extends StatelessWidget {
  Result(this.bmiResult);
  final BmiResult bmiResult;

  _bmiResultText() {
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Result'),
        ),
        body: Center(child: new RichText(
            text: const TextSpan(children: [
              TextSpan(
                  text: 'The dog ',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.red)),
              TextSpan(
                  text: 'is a domesticated carnivore ',
                  style: TextStyle(
                      fontStyle: FontStyle.italic, color: Colors.purple)),
              TextSpan(
                  text: 'of the family Canidae.',
                  style: TextStyle(color: Colors.green))
            ]),
          ));
  }
}
