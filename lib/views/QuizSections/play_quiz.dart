import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quizmaker/models/question_model.dart';
import 'package:quizmaker/services/database.dart';
import 'package:quizmaker/views/QuizSections/addquestions.dart';
import 'package:quizmaker/views/QuizSections/answer_count_tile.dart';
import 'package:quizmaker/views/QuizSections/quiz_option_tile.dart';
import 'package:quizmaker/views/QuizSections/quizes_submit_result.dart';
import 'dart:async';

class PlayQuiz extends StatefulWidget {
  late String quizId, title;
  PlayQuiz({required this.quizId, this.title = ""});

  @override
  _PlayQuizState createState() => _PlayQuizState();
}

late int _total = 0;
late int _correct = 0;
late int _incorrect = 0;
late int _notAttempted = 0;

Stream? infoStream;

class _PlayQuizState extends State<PlayQuiz> {
  // ignore: unnecessary_new
  DatabaseServices databaseServices = new DatabaseServices();
  QuerySnapshot? questionsSnapshot;

  Future getNewData() async {
    setState(() {
      DatabaseServices().getQuizData(widget.quizId).then((val) {
        questionsSnapshot = val;
      });
    });
  }

  @override
  void initState() {
    databaseServices.getQuizData(widget.quizId).then((val) {
      questionsSnapshot = val;
      _total = questionsSnapshot!.docChanges.length;
      _correct = 0;
      _incorrect = 0;
      _notAttempted = questionsSnapshot!.docChanges.length;
      setState(() {});
    });
    if (infoStream == null) {
      infoStream = Stream<List<int>>.periodic(Duration(milliseconds: 100), (x) {
        return [_correct, _incorrect, _notAttempted];
      });
    }

    super.initState();
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

  @override
  void dispose() {
    infoStream = null;
    super.dispose();
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
          widget.title == "" ? "Questions" : widget.title,
          style: TextStyle(color: Colors.blue),
        ),
        actions: [
          Container(
            margin: EdgeInsets.only(right: 13),
            child: GestureDetector(
                onTap: () {
                  showDialog();
                },
                child: questionsSnapshot == null
                    ? Container()
                    : questionsSnapshot!.docChanges.length == 0
                        ? (Container())
                        : Icon(CupertinoIcons.add)),
          )
        ],
      ),
      body: RefreshIndicator(
        onRefresh: getNewData,
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                InfoHeader(
                  length: questionsSnapshot != null
                      ? questionsSnapshot!.docChanges.length
                      : 0,
                ),
                SizedBox(
                  height: 10,
                ),
                questionsSnapshot == null
                    ? Container(
                        margin: EdgeInsets.only(top: 300),
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      )
                    : questionsSnapshot!.docChanges.length == 0
                        ? Container(
                            margin: EdgeInsets.only(top: 320, left: 6),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("No Question Added Till !"),
                                SizedBox(
                                  height: 15,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => AddQuestions(
                                                quizId: widget.quizId)));
                                  },
                                  child: Container(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 26),
                                    height: 50,
                                    width:
                                        MediaQuery.of(context).size.width / 2,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      color: Colors.blue,
                                    ),
                                    child: Text(
                                      "Add Quiz",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 17),
                                    ),
                                  ),
                                ),
                              ],
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
        ),
      ),
      floatingActionButton: questionsSnapshot == null
          ? Container()
          : questionsSnapshot!.docChanges.length == 0
              ? (Container())
              : FloatingActionButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => QuizSubmitResult(
                                  correct: _correct,
                                  incorrect: _incorrect,
                                  total: _total,
                                  quizId: widget.quizId,
                                )));
                  },
                  tooltip: 'Submit Answer',
                  child: Icon(Icons.check),
                ),
    );
  }
}

// Info Header
class InfoHeader extends StatefulWidget {
  late int length;
  InfoHeader({required this.length});

  @override
  _InfoHeaderState createState() => _InfoHeaderState();
}

class _InfoHeaderState extends State<InfoHeader> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: infoStream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Container(
              height: 47,
              child: ListView(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                children: [
                  AnswerCountTile(count: widget.length, category: "Total"),
                  AnswerCountTile(count: _correct, category: "Correct"),
                  AnswerCountTile(count: _incorrect, category: "Incorrect"),
                  AnswerCountTile(
                      count: _notAttempted, category: "NotAttended"),
                  SizedBox(width: 4),
                ],
              ),
            );
          } else {
            return Container();
          }
        });
  }
}

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
              Text("Q${widget.index + 1}.", style: TextStyle(fontSize: 18)),
              SizedBox(
                width: 11,
              ),
              Container(
                margin: EdgeInsets.only(top: 3),
                width: MediaQuery.of(context).size.width / 1.39,
                child: Text(
                  "${widget.questionModel.question} ?",
                  style: TextStyle(fontSize: 17),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 6,
          ),
          GestureDetector(
            onTap: () {
              if (!widget.questionModel.answered) {
                if (widget.questionModel.option1 ==
                    widget.questionModel.correctOption) {
                  optionSelected = widget.questionModel.option1;
                  widget.questionModel.answered = true;
                  print(
                      "correct Option is ${widget.questionModel.correctOption}");

                  _correct++;
                  _notAttempted--;
                  setState(() {});
                } else {
                  optionSelected = widget.questionModel.option1;
                  widget.questionModel.answered = true;
                  print(
                      "correct Option is ${widget.questionModel.correctOption}");

                  _incorrect++;
                  _notAttempted--;
                  setState(() {});
                }
              }
            },
            child: OptionTile(
              option: "A",
              description: "${widget.questionModel.option1}",
              correctAnswer: widget.questionModel.correctOption,
              optionSelected: optionSelected,
            ),
          ),
          SizedBox(
            height: 6,
          ),
          GestureDetector(
            onTap: () {
              if (!widget.questionModel.answered) {
                if (widget.questionModel.option2 ==
                    widget.questionModel.correctOption) {
                  optionSelected = widget.questionModel.option2;
                  widget.questionModel.answered = true;
                  _correct++;
                  _notAttempted--;
                  print(
                      "correct Option is ${widget.questionModel.correctOption}");

                  setState(() {});
                } else {
                  print(
                      "correct Option is ${widget.questionModel.correctOption}");
                  optionSelected = widget.questionModel.option2;
                  widget.questionModel.answered = true;
                  _incorrect++;
                  _notAttempted--;
                  setState(() {});
                }
              }
            },
            child: OptionTile(
              option: "B",
              description: "${widget.questionModel.option2}",
              correctAnswer: widget.questionModel.correctOption,
              optionSelected: optionSelected,
            ),
          ),
          SizedBox(
            height: 6,
          ),
          GestureDetector(
            onTap: () {
              if (!widget.questionModel.answered) {
                if (widget.questionModel.option3 ==
                    widget.questionModel.correctOption) {
                  optionSelected = widget.questionModel.option3;
                  widget.questionModel.answered = true;
                  print(
                      "correct Option is ${widget.questionModel.correctOption}");

                  _correct++;
                  _notAttempted--;
                  setState(() {});
                } else {
                  print(
                      "correct Option is ${widget.questionModel.correctOption}");

                  optionSelected = widget.questionModel.option3;
                  widget.questionModel.answered = true;
                  _incorrect = _incorrect + 1;
                  _notAttempted--;
                  setState(() {});
                }
              }
            },
            child: OptionTile(
              option: "C",
              description: "${widget.questionModel.option3}",
              correctAnswer: widget.questionModel.correctOption,
              optionSelected: optionSelected,
            ),
          ),
          SizedBox(
            height: 6,
          ),
          GestureDetector(
            onTap: () {
              if (!widget.questionModel.answered) {
                if (widget.questionModel.option4 ==
                    widget.questionModel.correctOption) {
                  optionSelected = widget.questionModel.option4;
                  widget.questionModel.answered = true;
                  print(
                      "correct Option is ${widget.questionModel.correctOption}");

                  _correct++;
                  _notAttempted--;
                  setState(() {});
                } else {
                  optionSelected = widget.questionModel.option4;
                  widget.questionModel.answered = true;
                  print(
                      "correct Option is ${widget.questionModel.correctOption}");

                  _incorrect++;
                  _notAttempted--;
                  setState(() {});
                }
              }
            },
            child: OptionTile(
              option: "D",
              description: "${widget.questionModel.option4}",
              correctAnswer: widget.questionModel.correctOption,
              optionSelected: optionSelected,
            ),
          ),
        ],
      ),
    );
  }
}
