import 'package:flutter/material.dart';
import 'package:quizmaker/views/home.dart';

class QuizSubmitResult extends StatefulWidget {
  late int correct, incorrect, total;
  QuizSubmitResult(
      {required this.correct, required this.incorrect, required this.total});

  @override
  _QuizSubmitResultState createState() => _QuizSubmitResultState();
}

class _QuizSubmitResultState extends State<QuizSubmitResult> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          height: MediaQuery.of(context).size.height,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "${widget.correct} / ${widget.total}",
                  style: TextStyle(fontSize: 40),
                ),
                SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "You Scored ${widget.correct} out of ${widget.total} ",
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 18),
                GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => Home()));
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 26),
                    height: 50,
                    width: MediaQuery.of(context).size.width / 2,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.green,
                    ),
                    child: Text(
                      "OK",
                      style: TextStyle(color: Colors.white, fontSize: 17),
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
