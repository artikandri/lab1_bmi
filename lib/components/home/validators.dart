String validateIntegerAndDecimal(String value, String fieldName) {
  value = value.replaceAll("[^0-9.]", "");
  String pattern = r'^-?(?!.{12})\d+(?:\.\d+)?$';
  RegExp regExp = new RegExp(pattern);
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
