import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:shared_preferences/shared_preferences.dart';
import "../data_templates/bmi_result.dart";
import '../utils/unit_converter.dart';
import '../components/home/validators.dart';
import 'result.dart';

enum UnitOptions { metric, imperial }

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  GlobalKey<FormState> _key = new GlobalKey();

  bool hasValidationError = false;
  bool isLoading = false;
  bool isMetric = true;

  String weight = "";
  String height = "";
  String bmi = "0.00";

  var validEntries = [];
  Color bmiTextColor = Colors.black;

  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();

  UnitOptions _option = UnitOptions.metric;

  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          _clearData();
          return Future.value(true);
        },
        child: new Form(
          key: _key,
          autovalidate: hasValidationError,
          child: BmiForm(),
        ));
  }

  Widget BmiForm() {
    return new Column(
      children: <Widget>[
        Column(
          children: <Widget>[
            ListTile(
              title: const Text('Metric'),
              leading: Radio<UnitOptions>(
                value: UnitOptions.metric,
                groupValue: _option,
                onChanged: (UnitOptions value) {
                  setState(() {
                    _option = UnitOptions.metric;
                    isMetric = _option == UnitOptions.metric;

                    _updateHeight();
                    _updateWeight();
                  });
                },
              ),
            ),
            ListTile(
              title: const Text('Imperial'),
              leading: Radio<UnitOptions>(
                value: UnitOptions.imperial,
                groupValue: _option,
                onChanged: (UnitOptions value) {
                  setState(() {
                    _option = UnitOptions.imperial;
                    isMetric = _option == UnitOptions.metric;

                    _updateHeight();
                    _updateWeight();
                  });
                },
              ),
            ),
          ],
        ),
        new TextFormField(
            decoration: new InputDecoration(hintText: 'Height (${isMetric ? "cm" : "ft"})'),
            controller: _heightController,
            keyboardType: TextInputType.numberWithOptions(decimal: !isMetric, signed: false),
            validator: validateHeight,
            onSaved: (String val) {
              setState(() {
                height = val;
              });
            }),
        new TextFormField(
            decoration: new InputDecoration(hintText: 'Weight (${isMetric ? "kg" : "lbs"})'),
            controller: _weightController,
            keyboardType: TextInputType.numberWithOptions(decimal: !isMetric, signed: false),
            validator: validateWeight,
            onSaved: (String val) {
              setState(() {
                weight = val;
              });
            }),
        new SizedBox(height: 15.0),
        new RaisedButton(
          onPressed: isLoading ? null : _validateForm,
          child: new Text('Count'),
        ),
        new SizedBox(height: 30.0),
        new RichText(
            text: TextSpan(children: [
          TextSpan(
              text: "${bmi}",
              style: TextStyle(
                fontSize: 50.0,
                fontWeight: FontWeight.bold,
                color: _getBmiTextColor(bmi),
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  if (!height.isEmpty && !weight.isEmpty && !hasValidationError) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => new Result(BmiResult(height, weight, bmi, isMetric)),
                      ),
                    ).then((value) {
                      _clearData();
                    });
                  }
                })
        ]))
      ],
    );
  }

  Color _getBmiTextColor(String bmi) {
    int bmiCategory = _getBmiCategory(bmi);
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

  String _getBmi() {
    String originalHeight = _heightController.text.replaceAll("[^\\d.]", "");
    String originalWeight = _weightController.text.replaceAll("[^\\d.]", "");

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

  int _getBmiCategory(String bmi) {
    // 0: Underweight, 1: Normal, 2: Overweight, 3: Obese, 4: Severely Obese, 5: Morbid Obese
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

  _updateHeight() {
    bool hasEnteredHeight = _heightController.text.length > 0;
    if (hasEnteredHeight) {
      double oldHeight = double.parse(_heightController.text);
      double newHeight = isMetric ? feetToCentimeter(oldHeight) : centimeterToFeet(oldHeight);

      _heightController.value = _heightController.value.copyWith(
        text: newHeight.toStringAsFixed(2),
        selection: TextSelection.collapsed(offset: newHeight.toStringAsFixed(2).length),
      );
    }
  }

  _updateWeight() {
    bool hasEnteredWeight = _weightController.text.length > 0;
    if (hasEnteredWeight) {
      double oldWeight = double.parse(_weightController.text);
      double newWeight = isMetric ? poundToKilogram(oldWeight) : kilogramToPound(oldWeight);

      _weightController.value = _weightController.value.copyWith(
        text: newWeight.toStringAsFixed(2),
        selection: TextSelection.collapsed(offset: newWeight.toStringAsFixed(2).length),
      );
    }
  }

  _addNewBmiEntry(String height, String weight, String bmi) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      validEntries.add({
        "height": height,
        "weight": weight,
        "bmi": bmi
      });
      prefs.setString('validEntries', json.encode(validEntries));
    });
  }

  _clearData() {
    setState(() {
      hasValidationError = false;
      isLoading = false;
      isMetric = true;

      weight = "";
      height = "";
      bmi = "";
    });
  }

  _validateForm() {
    isLoading = true;
    if (_key.currentState.validate()) {
      _key.currentState.save();

      setState(() {
        hasValidationError = false;
        isLoading = false;

        bmi = _getBmi();
      });

      _addNewBmiEntry(height, weight, bmi);

      _weightController.clear();
      _heightController.clear();
    } else {
      setState(() {
        hasValidationError = true;
        isLoading = false;
      });
    }
  }
}
