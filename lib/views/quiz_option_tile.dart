import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OptionTile extends StatefulWidget {
  late String option, description, correctAnswer;
  late String optionSelected;

  OptionTile({
    required this.option,
    required this.description,
    required this.correctAnswer,
    required this.optionSelected,
  });

  @override
  _OptionTileState createState() => _OptionTileState();
}

class _OptionTileState extends State<OptionTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
                border: Border.all(
                    color: widget.description == widget.optionSelected
                        ? widget.optionSelected == widget.correctAnswer
                            ? Colors.green.withOpacity(0.7)
                            : Colors.red.withOpacity(0.7)
                        : Colors.grey)),
            child: Text(
              widget.option,
              style: TextStyle(
                  color: widget.description == widget.optionSelected
                      ? Colors.white
                      : Colors.grey),
            ),
          ),
          SizedBox(width: 10),
          Container(
            child: Text(widget.description,
                style: TextStyle(color: Colors.grey, fontSize: 18.0)),
          ),
        ],
      ),
    );
  }
}
