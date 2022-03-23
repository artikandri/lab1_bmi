import 'package:flutter/material.dart';

class Authorship extends StatelessWidget {
  const Authorship({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Author'),
      ),
      body: Center(
          child: RichText(
        text: TextSpan(
          style: TextStyle(color: Colors.black, fontSize: 18.0),
          children: <TextSpan>[
            TextSpan(text: 'Lab 1 Task - Argi Candri - 268894')
          ],
        ),
      )),
    );
  }
}
