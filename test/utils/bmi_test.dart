import 'package:flutter_test/flutter_test.dart';
import 'package:lab1_bmi/utils/bmi.dart';

void main() {
  test('getBmiCategory', () {
    // underweight
    BMI testBMI = new BMI();
    var actual = testBMI.getBmiCategory("17");
    var expected = 0;
    expect(actual, expected);

    // normal
    BMI testBMI = new BMI();
    var actual = testBMI.getBmiCategory("19");
    var expected = 1;
    expect(actual, expected);
  });
}
