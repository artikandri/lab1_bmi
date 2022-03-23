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
        padding: const EdgeInsets.all(8),
        itemCount: validEntries.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            height: 50,
            child: RichText(
              text: TextSpan(
                style: TextStyle(color: Colors.black, fontSize: 16.0),
                children: <TextSpan>[
                  TextSpan(text: '${validEntries[index]["height"]} - '),
                  TextSpan(text: '${validEntries[index]["weight"]} - '),
                  TextSpan(text: '${validEntries[index]["bmi"]}')
                ],
              ),
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) => const Divider(),
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
