class BmiResult {
  final String height;
  final String weight;
  final String bmi;
  final bool isMetric;

  String get getHeight {
    return height;
  }

  String get getWeight {
    return weight;
  }

  String get getBmi {
    return bmi;
  }

  bool get getIsMetric {
    return isMetric;
  }

  const BmiResult(this.height, this.weight, this.bmi, this.isMetric);
}
