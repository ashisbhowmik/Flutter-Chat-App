import 'package:flutter/material.dart';

Widget appBar(BuildContext context) {
  return RichText(
    text: TextSpan(
      style: DefaultTextStyle.of(context).style,
      children: const <TextSpan>[
        TextSpan(
            text: 'Start',
            style: TextStyle(
                color: Colors.blue,
                fontSize: 29,
                decoration: TextDecoration.none)),
        TextSpan(
            text: 'Chat',
            style: TextStyle(
                color: Colors.black,
                decoration: TextDecoration.none,
                fontSize: 10)),
      ],
    ),
  );
}
Widget appBar2(BuildContext context) {
  return RichText(
    text: TextSpan(
      style: DefaultTextStyle.of(context).style,
      children: const <TextSpan>[
        TextSpan(
            text: 'Sign',
            style: TextStyle(
                color: Colors.blue,
                fontSize: 29,
                decoration: TextDecoration.none)),
        TextSpan(
            text: 'In',
            style: TextStyle(
                color: Colors.black,
                decoration: TextDecoration.none,
                fontSize: 27)),
      ],
    ),
  );
}
Widget appBar3(BuildContext context) {
  return RichText(
    text: TextSpan(
      style: DefaultTextStyle.of(context).style,
      children: const <TextSpan>[
        TextSpan(
            text: 'Sign',
            style: TextStyle(
                color: Colors.blue,
                fontSize: 29,
                decoration: TextDecoration.none)),
        TextSpan(
            text: 'Up',
            style: TextStyle(
                color: Colors.black,
                decoration: TextDecoration.none,
                fontSize: 27)),
      ],
    ),
  );
}
