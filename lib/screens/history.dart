import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import "../utils/bmi.dart";
import "../styling.dart";

class History extends StatefulWidget {
  @override
  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  var validEntries = [];
  final bmiUtil = BMI();
  final VALID_MEASUREMENTS_LIMIT = 10;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('History'),
      ),
      body: ListView.separated(
        itemCount: validEntries.length,
        shrinkWrap: true,
        padding: EdgeInsets.all(appSpacing),
        scrollDirection: Axis.vertical,
        separatorBuilder: (BuildContext, index) {
          return Divider(height: 1);
        },
        itemBuilder: (BuildContext context, int index) {
          return Card(
              child: Padding(
            padding: EdgeInsets.all(appSpacing),
            child: ListTile(
                title: Text("BMI ${validEntries[index]['bmi']}", style: TextStyle(fontSize: appFontSize * 1.25, fontWeight: FontWeight.bold)),
                subtitle: RichText(
                  text: TextSpan(
                    text: "Height: ${_heightText(validEntries[index])} - Weight: ${_weightText(validEntries[index])}\n\n",
                    style: DefaultTextStyle.of(context).style,
                    children: [
                      TextSpan(text: '${_descriptionText(validEntries[index])}', style: TextStyle(fontSize: appFontSize * 1, fontWeight: FontWeight.bold)),
                    ],
                  ),
                )),
          ));
        },
      ),
    );
  }

  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _getValidEntries(context));
  }

  String _heightText(entry) {
    return "${entry['height']} ${entry['isMetric'] ? 'cm' : 'ft'}";
  }

  String _weightText(entry) {
    return "${entry['weight']} ${entry['isMetric'] ? 'kg' : 'lbs'}";
  }

  String _descriptionText(entry) {
    int bmiCategory = bmiUtil.getBmiCategory(entry['bmi']);
    return "${bmiUtil.getBmiDescriptionFromCategory(bmiCategory)}";
  }

  _getValidEntries(context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      validEntries = json.decode(prefs.getString('validEntries')).reversed.take(VALID_MEASUREMENTS_LIMIT).toList();
    });
  }
}
