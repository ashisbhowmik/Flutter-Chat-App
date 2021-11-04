import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quizmaker/helper/functions.dart';
import 'package:quizmaker/models/question_model.dart';
import 'package:quizmaker/services/database.dart';
import 'package:quizmaker/views/addquestions.dart';
import 'package:quizmaker/views/quiz_option_tile.dart';
import 'package:quizmaker/views/quizes_submit_result.dart';
import 'package:quizmaker/widgets/widget.dart';

class PlayQuiz extends StatefulWidget {
  late String quizId, title;
  PlayQuiz({required this.quizId, required this.title});

  @override
  _PlayQuizState createState() => _PlayQuizState();
}

late int _total = 0;
late int _correct = 0;
late int _incorrect = 0;
late int _notAttempted = 0;

class _PlayQuizState extends State<PlayQuiz> {
  DatabaseServices databaseServices = new DatabaseServices();
  QuerySnapshot? questionsSnapshot;

  @override
  void initState() {
    print("QuizId is -------------------> ${widget.quizId}");
    databaseServices.getQuizData(widget.quizId).then((val) {
      questionsSnapshot = val;
      _total = questionsSnapshot!.docChanges.length;
      _correct = 0;
      _incorrect = 0;
      _notAttempted = questionsSnapshot!.docChanges.length;
      print(
          "Total Question in this category is ---------------------> $_total}");
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0.4,
        title: Text(
          widget.title,
          style: TextStyle(color: Colors.blue),
        ),
        actions: [
          Container(
            margin: EdgeInsets.only(right: 13),
            child: GestureDetector(
                onTap: () {
                  showDialog();
                },
                child: Icon(CupertinoIcons.add)),
          )
        ],
      ),
      body: Container(
        child: Column(
          children: [
            questionsSnapshot == null
                ? Container(
                    margin: EdgeInsets.only(top: 300),
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  )
                : ListView.builder(
                    physics: ClampingScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: questionsSnapshot!.docChanges.length,
                    itemBuilder: (context, index) {
                      return QuizPlayTile(
                        questionModel: getQuestionModelFromDataSnapshot(
                            questionsSnapshot!.docChanges[index]),
                        index: index,
                      );
                    },
                  )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => QuizSubmitResult(
                      correct: _correct,
                      incorrect: _incorrect,
                      total: _total)));
        },
        child: Icon(Icons.check),
      ),
    );
  }

  // OPEN DIALOG
  void showDialog() {
    showCupertinoDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: Text("Add More Quiz"),
          content:
              Text("Are you sure you want to add More Quiz in this Category?"),
          actions: [
            CupertinoDialogAction(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Cancel"),
            ),
            CupertinoDialogAction(
              onPressed: () {
                Navigator.pop(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            AddQuestions(quizId: widget.quizId)));
              },
              child: Text("Yes"),
            ),
          ],
        );
      },
    );
  }

  // Building QuestionModel from DataBase quiz's question's options and answer
  QuestionModel getQuestionModelFromDataSnapshot(
      DocumentChange questionSnapshot) {
    QuestionModel questionModel = new QuestionModel();

    List<String> _options = [
      questionSnapshot.doc['option1'],
      questionSnapshot.doc['option2'],
      questionSnapshot.doc['option3'],
      questionSnapshot.doc['option4'],
    ];
    _options.shuffle();

    questionModel.question = questionSnapshot.doc['question'];
    questionModel.option1 = _options[0];
    questionModel.option2 = _options[1];
    questionModel.option3 = _options[2];
    questionModel.option4 = _options[3];
    questionModel.correctOption = questionSnapshot.doc['option1'];
    questionModel.answered = false;
    return questionModel;
  }
}

// QUIZPLAYTILE
class QuizPlayTile extends StatefulWidget {
  late QuestionModel questionModel;
  late int index;

  QuizPlayTile({required this.questionModel, required this.index});

  @override
  _QuizPlayTileState createState() => _QuizPlayTileState();
}

class _QuizPlayTileState extends State<QuizPlayTile> {
  String optionSelected = "";
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(19),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text("Q${widget.index + 1}.", style: TextStyle(fontSize: 19)),
              SizedBox(
                width: 11,
              ),
              Text(
                "${widget.questionModel.question} ?",
                style: TextStyle(fontSize: 17),
              ),
            ],
          ),
          SizedBox(
            height: 12,
          ),
          GestureDetector(
            onTap: () {
              if (widget.questionModel.answered == false) {
                if (widget.questionModel.option1 ==
                    widget.questionModel.correctOption) {
                  optionSelected = widget.questionModel.option1;
                  widget.questionModel.answered = true;
                  _correct = _correct + 1;
                  _notAttempted = _notAttempted - 1;
                  print(
                      "correct answer is ------------> ${widget.questionModel.correctOption}");
                  setState(() {});
                } else {
                  optionSelected = widget.questionModel.option1;
                  widget.questionModel.answered = true;
                  _incorrect = _incorrect + 1;
                  setState(() {});
                }
              }
            },
            child: OptionTile(
              option: "A",
              description: widget.questionModel.option1,
              correctAnswer: widget.questionModel.correctOption,
              optionSelected: optionSelected,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          GestureDetector(
            onTap: () {
              if (widget.questionModel.answered == false) {
                if (widget.questionModel.option1 ==
                    widget.questionModel.correctOption) {
                  optionSelected = widget.questionModel.option2;
                  widget.questionModel.answered = true;
                  print(
                      "correct answer is ------------> ${widget.questionModel.correctOption}");
                  _correct = _correct + 1;
                  _notAttempted = _notAttempted - 1;
                  setState(() {});
                } else {
                  optionSelected = widget.questionModel.option2;
                  widget.questionModel.answered = true;
                  _incorrect = _incorrect + 1;
                  setState(() {});
                }
              }
            },
            child: OptionTile(
              option: "B",
              description: widget.questionModel.option2,
              correctAnswer: widget.questionModel.correctOption,
              optionSelected: optionSelected,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          GestureDetector(
            onTap: () {
              if (widget.questionModel.answered == false) {
                if (widget.questionModel.option1 ==
                    widget.questionModel.correctOption) {
                  optionSelected = widget.questionModel.option3;
                  widget.questionModel.answered = true;
                  print(
                      "correct answer is ------------> ${widget.questionModel.correctOption}");
                  _correct = _correct + 1;
                  _notAttempted = _notAttempted - 1;
                  setState(() {});
                } else {
                  optionSelected = widget.questionModel.option3;
                  widget.questionModel.answered = true;
                  _incorrect = _incorrect + 1;
                  setState(() {});
                }
              }
            },
            child: OptionTile(
              option: "C",
              description: widget.questionModel.option3,
              correctAnswer: widget.questionModel.correctOption,
              optionSelected: optionSelected,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          GestureDetector(
            onTap: () {
              if (widget.questionModel.answered == false) {
                if (widget.questionModel.option1 ==
                    widget.questionModel.correctOption) {
                  optionSelected = widget.questionModel.option4;
                  widget.questionModel.answered = true;
                  print(
                      "correct answer is ------------> ${widget.questionModel.correctOption}");
                  _correct = _correct + 1;
                  _notAttempted = _notAttempted - 1;
                  setState(() {});
                } else {
                  optionSelected = widget.questionModel.option4;
                  widget.questionModel.answered = true;
                  _incorrect = _incorrect + 1;
                  setState(() {});
                }
              }
            },
            child: OptionTile(
              option: "D",
              description: widget.questionModel.option4,
              correctAnswer: widget.questionModel.correctOption,
              optionSelected: optionSelected,
            ),
          ),
        ],
      ),
    );
  }
}
