import 'package:flutter/material.dart';

Widget appBar(BuildContext context) {
  return RichText(
    text: TextSpan(
      style: DefaultTextStyle.of(context).style,
      children: const <TextSpan>[
        TextSpan(
            text: 'Quiz',
            style: TextStyle(
                color: Colors.blue,
                fontSize: 29,
                decoration: TextDecoration.none)),
        TextSpan(
            text: 'Maker',
            style: TextStyle(
                color: Colors.black,
                decoration: TextDecoration.none,
                fontSize: 10)),
      ],
    ),
  );
}

Widget appBar2(BuildContext context) {
  return Row(
    children: [
      Text("Quiz",
          style: TextStyle(
              color: Colors.blue,
              fontSize: 27,
              decoration: TextDecoration.none)),
      Text(
        "Maker",
        style: TextStyle(
            color: Colors.black, decoration: TextDecoration.none, fontSize: 9),
      ),
    ],
  );
}
