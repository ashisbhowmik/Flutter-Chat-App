import 'package:flutter/material.dart';

Widget appBar(BuildContext context) {
  return RichText(
    text: TextSpan(
      style: DefaultTextStyle.of(context).style,
      children: const <TextSpan>[
        TextSpan(
            text: 'Quizo',
            style: TextStyle(
                color: Colors.blue,
                fontSize: 29,
                decoration: TextDecoration.none)),
        TextSpan(
            text: 'Graphy',
            style: TextStyle(
                color: Colors.black,
                decoration: TextDecoration.none,
                fontSize: 10)),
      ],
    ),
  );
}
