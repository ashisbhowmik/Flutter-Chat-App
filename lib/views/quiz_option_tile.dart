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
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: Row(
          children: [
            Container(
              width: 25,
              height: 25,
              decoration: BoxDecoration(
                  color: widget.description == widget.optionSelected
                      ? widget.optionSelected == widget.correctAnswer
                          ? Colors.green.withOpacity(0.7)
                          : Colors.red.withOpacity(0.7)
                      : Colors.white,
                  border: Border.all(
                      color: widget.description == widget.optionSelected
                          ? widget.optionSelected == widget.correctAnswer
                              ? Colors.green.withOpacity(0.7)
                              : Colors.red.withOpacity(0.7)
                          : Colors.grey),
                  borderRadius: BorderRadius.circular(19)),
              child: Text(
                widget.option,
                style: TextStyle(
                    color: widget.description == widget.optionSelected
                        ? Colors.white
                        : Colors.grey),
              ),
              alignment: Alignment.center,
            ),
            SizedBox(width: 15),
            Container(
              child: Text(widget.description,
                  style: TextStyle(color: Colors.grey, fontSize: 15.7)),
            ),
          ],
        ),
      ),
    );
  }
}
