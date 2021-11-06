import 'package:flutter/material.dart';

class AnswerCountTile extends StatefulWidget {
  late int count;
  late String category;
  AnswerCountTile({required this.count, required this.category});

  @override
  _AnswerCountTileState createState() => _AnswerCountTileState();
}

class _AnswerCountTileState extends State<AnswerCountTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: 9,
      ),
      margin: EdgeInsets.only(top: 10),
      child: Row(
        children: <Widget>[
          Container(
              width: 30,
              alignment: Alignment.center,
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(18),
                      bottomLeft: Radius.circular(18))),
              child: Text(
                "${widget.count}",
                style: TextStyle(color: Colors.white),
              )),
          Container(
              width: 69,
              alignment: Alignment.center,
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.6),
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(18),
                      bottomRight: Radius.circular(18))),
              child: Text(
                "${widget.category}",
                style: TextStyle(color: Colors.white, fontSize: 12),
              )),
        ],
      ),
    );
  }
}
