import 'package:flutter/material.dart';
import "../data_templates/bmi_result.dart";
import "../utils/bmi.dart";
import "../styling.dart";

class Result extends StatelessWidget {
  Result(this.bmiResult);
  final BmiResult bmiResult;
  final BMI bmiUtil = BMI();

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
    return bmiUtil.getBmiTextColor(bmiResult.bmi);
  }

  String _bmiCategoryText() {
    int bmiCategory = bmiUtil.getBmiCategory(bmiResult.bmi);
    return bmiUtil.getBmiDescriptionFromCategory(bmiCategory);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Result'),
        ),
        body: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center, children: [
          Center(
              child: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(children: [
              TextSpan(text: "${_bmiScore()}\n", style: TextStyle(fontWeight: FontWeight.bold, fontSize: appFontSize * 4, color: _bmiTextColor())),
              TextSpan(text: "You are ${_bmiCategoryText()}\n\n", style: TextStyle(fontSize: appFontSize * 2, color: Theme.of(context).textTheme.bodyText1.color)),
              TextSpan(text: "Height: ${_bmiHeight()} and Weight: ${_bmiWeight()}\n", style: TextStyle(fontSize: appFontSize * 1.5, color: Theme.of(context).textTheme.bodyText1.color)),
            ]),
          ))
        ]));
  }
}
