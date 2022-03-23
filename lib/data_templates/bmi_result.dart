class BmiResult {
  final String height;
  final String weight;
  final String bmi;

  String get getHeight {
    return height;
  }

  String get getWeight {
    return weight;
  }

  String get getBmi {
    return bmi;
  }

  const BmiResult(this.height, this.weight, this.bmi);
}
