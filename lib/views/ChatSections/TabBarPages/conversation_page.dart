import 'package:flutter/material.dart';
import 'package:quizmaker/views/ChatSections/TabBarPages/all_chats.dart';
import 'package:quizmaker/views/ChatSections/chat_home_page.dart';

class ConversationPage extends StatefulWidget {
  late String userName, userEmail;
  // ConversationPage({required this.userName, required this.userEmail});

  @override
  _ConversationPageState createState() => _ConversationPageState();
}

class _ConversationPageState extends State<ConversationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        leading: GestureDetector(
            onTap: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => ChatHomePage()));
            },
            child: Icon(Icons.arrow_back_ios, color: Colors.black)),
        title: Text(
          // "${widget.userName}",
          "arjun",
          style: TextStyle(color: Colors.black),
        ),
      ),
    );
  }
}
