import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quizmaker/helper/constants.dart';
import 'package:quizmaker/helper/functions.dart';
import 'package:quizmaker/views/ChatSections/TabBarPages/all_chats.dart';
import 'package:quizmaker/views/ChatSections/TabBarPages/search_page.dart';
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
    _tabController = TabController(length: 2, vsync: this, initialIndex: 0);
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
              text: "SEARCH",
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [AllChats(), SearchPage()],
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
