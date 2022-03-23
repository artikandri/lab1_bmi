String validateIntegerAndDecimal(String value, String fieldName) {
  String pattern = r'^-?(?!.{12})\d+(?:\.\d+)?$';
  RegExp regExp = new RegExp(pattern);
  value = value.replaceAll("[^\\d.]", "");
  if (value.length == 0) {
    return "$fieldName is required";
  } else if (double.parse(value) <= 0) {
    return "$fieldName must be more than zero ";
  } else if (!regExp.hasMatch(value)) {
    return "$fieldName must be numbers";
  }
  return null;
}

String validateHeight(String value) {
  return validateIntegerAndDecimal(value, "height");
}

String validateWeight(String value) {
  return validateIntegerAndDecimal(value, "weight");
}
