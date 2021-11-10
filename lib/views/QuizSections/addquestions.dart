import 'package:flutter/material.dart';
import 'package:quizmaker/services/database.dart';

class AddQuestions extends StatefulWidget {
  late String quizId;
  AddQuestions({required this.quizId});
  @override
  _AddQuestionsState createState() => _AddQuestionsState();
}

class _AddQuestionsState extends State<AddQuestions> {
  final _formKey = GlobalKey<FormState>();
  late String question, o1, o2, o3, o4;
  bool isLoading = false;

  uploadQuestionData() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });

      Map<String, String> questionData = {
        "question": question,
        "option1": o1,
        "option2": o2,
        "option3": o3,
        "option4": o4,
      };
      DatabaseServices databaseServices = new DatabaseServices();
      databaseServices
          .addQuestionsData(questionData, widget.quizId)
          .then((val) {
        setState(() {
          isLoading = false;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Add Your Questions",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        elevation: 0.39,
      ),
      body: isLoading
          ? Container(
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            )
          : Form(
              key: _formKey,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 26),
                child: Column(
                  children: [
                    TextFormField(
                      // ignore: prefer_const_constructors
                      validator: (val) {
                        if (val == null || val.isEmpty) {
                          return "Please fill this field Carefully";
                        } else {
                          return null;
                        }
                      },
                      // ignore: prefer_const_constructors
                      decoration: InputDecoration(
                        labelText: "Question",
                      ),
                      onChanged: (val) {
                        question = val;
                      },
                    ),
                    TextFormField(
                      // ignore: prefer_const_constructors
                      validator: (val) {
                        if (val == null || val.isEmpty) {
                          return "Please fill this field Carefully";
                        } else {
                          return null;
                        }
                      },
                      // ignore: prefer_const_constructors
                      decoration: InputDecoration(
                        labelText: "Option1 (Correct Answer)",
                      ),
                      onChanged: (val) {
                        o1 = val;
                      },
                    ),
                    TextFormField(
                      // ignore: prefer_const_constructors
                      validator: (val) {
                        if (val == null || val.isEmpty) {
                          return "Please fill this field Carefully";
                        } else {
                          return null;
                        }
                      },
                      // ignore: prefer_const_constructors
                      decoration: InputDecoration(
                        labelText: "Option 2",
                      ),
                      onChanged: (val) {
                        o2 = val;
                      },
                    ),
                    TextFormField(
                      // ignore: prefer_const_constructors
                      validator: (val) {
                        if (val == null || val.isEmpty) {
                          return "Please fill this field Carefully";
                        } else {
                          return null;
                        }
                      },
                      // ignore: prefer_const_constructors
                      decoration: InputDecoration(
                        labelText: "Option 3",
                      ),
                      onChanged: (val) {
                        o3 = val;
                      },
                    ),
                    TextFormField(
                      validator: (val) {
                        if (val == null || val.isEmpty) {
                          return "Please fill this field Carefully";
                        } else {
                          return null;
                        }
                      },
                      // ignore: prefer_const_constructors
                      decoration: InputDecoration(
                        labelText: "Option 4",
                      ),
                      onChanged: (val) {
                        o4 = val;
                      },
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Spacer(),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            uploadQuestionData();
                            Navigator.pop(context);
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 26),
                            height: 50,
                            width: 111,
                            // width: MediaQuery.of(context).size.width,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: Colors.blue,
                            ),
                            child: Text(
                              "Submit",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 13),
                            ),
                          ),
                        ),
                        Text("   "),
                        GestureDetector(
                          onTap: () {
                            uploadQuestionData();
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 26),
                            height: 50,
                            width: 181,
                            // width: MediaQuery.of(context).size.width,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: Colors.blue,
                            ),
                            child: Text(
                              "Add Question",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 13),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 27,
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
