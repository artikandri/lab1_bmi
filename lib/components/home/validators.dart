String _validateHeight(String value) {
  String pattern = r'^-?(?!.{12})\d+(?:\.\d+)?$';
  RegExp regExp = new RegExp(pattern);

  value = value.replaceAll("[^\\d.]", "");

  if (value.length == 0) {
    return "height is required";
  } else if (double.parse(value) <= 0) {
    return "height must be more than zero ";
  } else if (!regExp.hasMatch(value)) {
    return "height must be digits";
  }
  return null;
}

String _validateWeight(String value) {
  String pattern = r'^-?(?!.{12})\d+(?:\.\d+)?$';
  RegExp regExp = new RegExp(pattern);
  value = value.replaceAll("[^\\d.]", "");
  if (value.length == 0) {
    return "weight is required";
  } else if (double.parse(value) <= 0) {
    return "weight must be more than zero ";
  } else if (!regExp.hasMatch(value)) {
    return "weight must be digits";
  }
  return null;
}
