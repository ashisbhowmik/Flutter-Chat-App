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
                        ? Colors.black
                        : Colors.grey),
              ),
              alignment: Alignment.center,
            ),
            // SizedBox(width: 8),
            Stack(
              children: [
                Container(
                  margin: EdgeInsets.only(left: 12),
                  decoration: BoxDecoration(
                    color: widget.description == widget.optionSelected
                        ? widget.optionSelected == widget.correctAnswer
                            ? Colors.green.withOpacity(0.7)
                            : Colors.red.withOpacity(0.7)
                        : Colors.white.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(19),
                  ),
                  width: MediaQuery.of(context).size.width / 1.4,
                  child: Text(""),
                ),
                Container(
                  padding: EdgeInsets.only(left: 12),
                  margin: EdgeInsets.only(left: 18),
                  width: MediaQuery.of(context).size.width / 1.4,
                  child: Text(widget.description,
                      style: TextStyle(
                          color: widget.description == widget.optionSelected
                              ? Colors.black
                              : Colors.grey,
                          fontSize: 15.7)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
