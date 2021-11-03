import 'package:flutter/material.dart';
import 'package:quizmaker/services/database.dart';
import 'package:random_string/random_string.dart';
import 'addquestions.dart';

class Create_Quiz extends StatefulWidget {
  const Create_Quiz({Key? key}) : super(key: key);

  @override
  _Create_QuizState createState() => _Create_QuizState();
}

class _Create_QuizState extends State<Create_Quiz> {
  final _formKey = GlobalKey<FormState>();
  late String imgUrl, title, description, quizId;
  bool isLoading = false;

  addQuizData() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });

      quizId = randomAlpha(15);
      Map<String, String> quizData = {
        "quizId": quizId,
        "imageUrl": imgUrl,
        "title": title,
        "description": description,
      };
      DatabaseServices databaseServices = new DatabaseServices();

      await databaseServices.addQuizData(quizData, quizId).then((val) {
        setState(() {
          isLoading = false;
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => AddQuestions(quizId:quizId)));
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: Text(
          "Create Your Quiz",
          style: TextStyle(color: Colors.blue),
        ),
      ),
      body: isLoading
          ? Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            )
          : Form(
              key: _formKey,
              child: Container(
                // color: Colors.blue,
                padding: EdgeInsets.symmetric(horizontal: 26),
                child: Column(
                  children: [
                    SizedBox(
                      height: 19,
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
                        labelText: "ImageUrl(Optional)",
                      ),
                      onChanged: (val) {
                        imgUrl = val;
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
                        labelText: "Title",
                      ),
                      onChanged: (val) {
                        title = val;
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
                        labelText: "description",
                      ),
                      onChanged: (val) {
                        description = val;
                      },
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Spacer(),
                    GestureDetector(
                      onTap: () {
                        addQuizData();
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 26),
                        height: 50,
                        width: MediaQuery.of(context).size.width,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.blue,
                        ),
                        child: Text(
                          "Create Quiz",
                          style: TextStyle(color: Colors.white, fontSize: 17),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      height: 24,
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
