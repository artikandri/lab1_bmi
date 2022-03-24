import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

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
        itemCount: images.length,
        shrinkWrap: true,
        padding: EdgeInsets.all(5),
        scrollDirection: Axis.vertical,
        separatorBuilder: (BuildContext context, int index) => const Divider(),
        itemBuilder: (BuildContext context, int index) {
          return Card(
            child: ListTile(
              title: Text("BMI ${validEntries[index]['bmi]}"),
              subtitle: Text("Height: $validEntries[index]['height] - Weight: $validEntries[index]['weight']"),
            ),
          );
        },
      ),
    );
  }

  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _getValidEntries(context));
  }

  _getValidEntries(context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      validEntries = json.decode(prefs.getString('validEntries')).reversed.take(VALID_MEASUREMENTS_LIMIT).toList();
    });
  }
}
