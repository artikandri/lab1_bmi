import 'package:flutter/material.dart';
import "../data_templates/bmi_result.dart";
import "../utils/bmi.dart";
import "../styling.dart";

class Result extends StatelessWidget {
  Result(this.bmiResult);
  final BmiResult bmiResult;

  String _bmiHeight() {
    String unit = bmiResult.isMetric ? "cm" : "ft";
    return "${bmiResult.height} ${unit}";
  }

  String _bmiWeight() {
    String unit = bmiResult.isMetric ? "kg" : "lbs";
    return "${bmiResult.weight} ${unit}";
  }

  String _bmiScore() {
    return bmiResult.bmi;
  }

  Color _bmiTextColor() {
    return getBmiTextColor(bmiResult.bmi);
  }

  String _bmiCategoryText() {
    int bmiCategory = getBmiCategory(bmiResult.bmi);
    return getBmiDescriptionFromCategory(bmiCategory);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Result'),
        ),
        body: Center(
            child: new RichText(
          text: TextSpan(children: [
            TextSpan(text: "${_bmiScore()}\n", style: TextStyle(fontWeight: FontWeight.bold, fontSize: appFontSize * 3, color: _bmiTextColor())),
            TextSpan(text: "You are ${_bmiCategoryText()}\n", style: TextStyle(fontSize: appFontSize * 2)),
            TextSpan(text: "Height: ${_bmiHeight()} and Weight: ${_bmiWeight()}\n"),
          ]),
        )));
  }
}
