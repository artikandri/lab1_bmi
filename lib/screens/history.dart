import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import "../utils/bmi.dart";

class History extends StatefulWidget {
  @override
  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  var validEntries = [];
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
        padding: EdgeInsets.all(5),
        scrollDirection: Axis.vertical,
        separatorBuilder: (BuildContext, index) {
          return Divider(height: 1);
        },
        itemBuilder: (BuildContext context, int index) {
          return Card(
            child: ListTile(
                title: Text("BMI ${validEntries[index]['bmi']}"),
                subtitle: RichText(
                  text: TextSpan(
                    text: "Height: ${_heightText(validEntries[index])} - Weight: ${_weightText(validEntries[index])}",
                    style: DefaultTextStyle.of(context).style,
                    children: <TextSpan>[
                      TextSpan(text: '${_descriptionText(validEntries[index])}', style: TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  ),
                )),
          );
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
    int bmiCategory = getBmiCategory(entry['bmi']);
    return "${getBmiDescriptionFromCategory(bmiCategory)}";
  }

  _getValidEntries(context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      validEntries = json.decode(prefs.getString('validEntries')).reversed.take(VALID_MEASUREMENTS_LIMIT).toList();
    });
  }
}
