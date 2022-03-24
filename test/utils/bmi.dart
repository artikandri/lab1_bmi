import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:lab1_bmi/utils/bmi.dart';
import 'package:lab1_bmi/styling.dart';

void main() {
  test('Metric, Zero Values, BMICategory Test', () {
    var expected = 0;
    BMI testBMI = new BMI(false, 0, 0);
    var actual = testBMI.BMICategory;
    expect(actual, expected);
  });