import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:shared_preferences/shared_preferences.dart';
import "../data_templates/bmi_result.dart";
import '../utils/unit_converter.dart';
import '../components/home/validators.dart';
import '../models/home.dart';
import "../styling.dart";

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
  String bmi = "";

  BMI bmiUtil = BMI();

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
      child: Container(
        child: Align(
            alignment: Alignment.centerLeft,
            child: new Form(
              key: _key,
              autovalidate: hasValidationError,
              child: BmiForm(),
            )),
      ),
    );
  }

  Widget BmiForm() {
    return new Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        RichText(
          text: TextSpan(text: 'Measurement unit', style: (TextStyle(color: Theme.of(context).textTheme.bodyText1.color, fontSize: appFontSize))),
        ),
        SizedBox(height: appSpacing * 2),
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
        SizedBox(height: appSpacing * 2),
        RichText(
          text: TextSpan(text: 'Measurements', style: (TextStyle(color: Theme.of(context).textTheme.bodyText1.color, fontSize: appFontSize))),
        ),
        SizedBox(height: appSpacing * 2),
        TextFormField(
            decoration: new InputDecoration(labelText: 'Height (${isMetric ? "cm" : "ft"})', hintText: 'Enter your height'),
            controller: _heightController,
            keyboardType: TextInputType.numberWithOptions(decimal: !isMetric, signed: false),
            validator: validateHeight,
            onSaved: (String val) {
              setState(() {
                height = val;
              });
            }),
        SizedBox(height: appSpacing * 2),
        TextFormField(
            decoration: new InputDecoration(labelText: 'Weight (${isMetric ? "kg" : "lbs"})', hintText: 'Enter your weight'),
            controller: _weightController,
            keyboardType: TextInputType.numberWithOptions(decimal: !isMetric, signed: false),
            validator: validateWeight,
            onSaved: (String val) {
              setState(() {
                weight = val;
              });
            }),
        SizedBox(height: appSpacing * 2),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: isLoading ? Colors.grey : Colors.blue,
            minimumSize: Size.fromHeight(appSpacing * 6),
          ),
          onPressed: isLoading ? null : _validateForm,
          child: Text(
            'Count',
            style: TextStyle(fontSize: appFontSize * 1),
          ),
        ),
        SizedBox(height: appSpacing * 4),
        Center(
            child: RichText(
                softWrap: true,
                textAlign: TextAlign.justify,
                text: TextSpan(children: [
                  TextSpan(
                      text: "${bmi}",
                      style: TextStyle(
                        fontSize: appFontSize * 3,
                        fontWeight: FontWeight.bold,
                        color: bmiUtil.getBmiTextColor(bmi),
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
                ]))),
      ],
    );
  }

  _updateHeight() {
    bool hasEnteredHeight = _heightController.text.length > 0;
    if (hasEnteredHeight) {
      double oldHeight = double.parse(_heightController.text);
      double newHeight = isMetric ? feetToCentimeter(oldHeight) : centimeterToFeet(oldHeight);

      _heightController.value = _heightController.value.copyWith(
        text: isMetric ? newHeight.round().toString() : newHeight.toStringAsFixed(2),
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
        text: isMetric ? newWeight.round().toString() : newWeight.toStringAsFixed(2),
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
        "isMetric": isMetric,
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

      String originalHeight = _heightController.text.replaceAll("[^\\d.]", "");
      String originalWeight = _weightController.text.replaceAll("[^\\d.]", "");

      originalHeight = originalHeight.isEmpty ? "0" : originalHeight;
      originalWeight = originalWeight.isEmpty ? "0" : originalWeight;

      setState(() {
        hasValidationError = false;
        isLoading = false;

        bmi = bmiUtil.getBmi(originalHeight, originalWeight, isMetric);
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
