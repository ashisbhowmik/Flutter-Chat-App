import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quizmaker/views/ChatSections/TabBarPages/calls_pages.dart';
import 'package:quizmaker/views/ChatSections/TabBarPages/chats_page.dart';
import 'package:quizmaker/views/ChatSections/TabBarPages/status_page.dart';
import 'package:quizmaker/views/QuizSections/quiz_home_page.dart';

class ChatHomePage extends StatefulWidget {
  const ChatHomePage({Key? key}) : super(key: key);

  @override
  _ChatHomePageState createState() => _ChatHomePageState();
}

class _ChatHomePageState extends State<ChatHomePage>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;
  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this, initialIndex: 1);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black.withOpacity(0.9)),
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        title: Text(
          "StartChat",
          style: TextStyle(color: Colors.black.withOpacity(0.8)),
        ),
        bottom: TabBar(
          indicatorWeight: 2.9,
          labelStyle: TextStyle(fontSize: 15),
          labelColor: Colors.black,
          controller: _tabController,
          tabs: [
            Tab(
              text: "CHATS",
            ),
            Tab(
              text: "STATUS",
            ),
            Tab(
              text: "CALLS",
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [ChatsPage(), StatusPage(), CallsPage()],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => QuizHomePage()));
        },
        child: Icon(
          Icons.quiz,
          size: 30,
        ),
      ),
    );
  }
}
