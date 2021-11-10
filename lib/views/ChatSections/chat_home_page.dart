import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quizmaker/views/QuizSections/quiz_home_page.dart';

class ChatHomePage extends StatefulWidget {
  const ChatHomePage({Key? key}) : super(key: key);

  @override
  _ChatHomePageState createState() => _ChatHomePageState();
}

class _ChatHomePageState extends State<ChatHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black.withOpacity(0.6)),
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        title: Text(
          "StartChat",
          style: TextStyle(color: Colors.black.withOpacity(0.6)),
        ),
        actions: [
          Container(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  IconButton(onPressed: () {}, icon: Icon(Icons.search)),
                  IconButton(onPressed: () {}, icon: Icon(Icons.more_vert)),
                ],
              ),
            ),
          ),
        ],
      ),
      body: Container(
        color: Colors.black87.withOpacity(0.86),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => QuizHomePage()));
        },
        child: Icon(Icons.quiz,size: 30,),
      ),

    );
  }
}
