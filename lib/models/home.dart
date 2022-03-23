import '../utils/unit_converter.dart';
import 'package:flutter/material.dart';

String getBmi(String originalHeight, String originalWeight, bool isMetric) {
  bool hasEnteredHeight = originalHeight.length > 0;
  bool hasEnteredWeight = originalWeight.length > 0;

  double score = 0;
  if (hasEnteredHeight && hasEnteredWeight) {
    double heightInMetricsMeter = isMetric ? double.parse(originalHeight) / 100 : feetToMeter(double.parse(originalHeight));
    double weightInMetricsKilo = isMetric ? double.parse(originalWeight) : poundToKilogram(double.parse(originalWeight));

    score = weightInMetricsKilo / (heightInMetricsMeter * heightInMetricsMeter);
  }

  return score.toStringAsFixed(2);
}

int getBmiCategory(String bmi) {
  double bmiInDouble = bmi.isEmpty ? 0 : double.parse(bmi.replaceAll("[^\\d.]", ""));
  int result = 0;
  if (bmiInDouble < 18.5)
    result = 0;
  else if (bmiInDouble >= 18.5 && bmiInDouble <= 24.9)
    result = 1;
  else if (bmiInDouble >= 25 && bmiInDouble <= 29.9)
    result = 2;
  else if (bmiInDouble >= 30 && bmiInDouble <= 34.9)
    result = 3;
  else if (bmiInDouble >= 35 && bmiInDouble <= 39.9)
    result = 4;
  else if (bmiInDouble >= 40) result = 5;

  return result;
}

String getBmiDescriptionFromCategory(int category) {
  // 0: Underweight, 1: Normal, 2: Overweight, 3: Obese, 4: Severely Obese, 5: Morbid Obese
  String description;
  switch (category) {
    case 0:
      description = "underweight";
      break;
    case 1:
      description = "normal";
      break;
    case 2:
      description = "overweight";
      break;
    case 3:
      description = "obese";
      break;
    case 4:
      description = "severely obese";
      break;
    case 5:
      description = "morbid obese";
      break;
    default:
      description = "normal";
      break;
  }

  return description;
}

Color getBmiTextColor(String bmi) {
  int bmiCategory = getBmiCategory(bmi);
  Color color = Colors.black;
  switch (bmiCategory) {
    case 0:
      color = Colors.yellow;
      break;
    case 1:
      color = Colors.green;
      break;
    case 2:
      color = Colors.deepOrange;
      break;
    case 3:
      color = Colors.red[50];
      break;
    case 4:
      color = Colors.red[300];
      break;
    case 5:
      color = Colors.grey;
      break;
  }
  return color;
}
