import 'package:flutter_test/flutter_test.dart';
import 'package:lab1_bmi/utils/bmi.dart';

void main() {
  test('getBmiCategory', () {
    BMI testBMI = new BMI();
    for (var i = 0; i <= 5; i++) {
      // underweight > obese: 16 21 26 31 36 41
      var actual = testBMI.getBmiCategory("${16 + i * 5}");
      var expected = i;
      expect(actual, expected);
    }
  });
}
