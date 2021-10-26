import 'package:flutter/material.dart';

Widget appBar(BuildContext context) {
  return RichText(
    text: TextSpan(
      style: DefaultTextStyle.of(context).style,
      children: const <TextSpan>[
        TextSpan(
            text: 'Quiz',
            style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                decoration: TextDecoration.none)),
        TextSpan(
            text: 'Maker',
            style: TextStyle(
                color: Colors.blue,
                decoration: TextDecoration.none,
                fontWeight: FontWeight.bold,
                fontSize: 20)),
      ],
    ),
  );
}
