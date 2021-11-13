import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:quizmaker/helper/constants.dart';
import 'package:quizmaker/helper/functions.dart';
import 'package:quizmaker/services/database.dart';
import 'package:quizmaker/views/ChatSections/TabBarPages/conversation_page.dart';

class AllChats extends StatefulWidget {
  const AllChats({Key? key}) : super(key: key);

  @override
  _AllChatsState createState() => _AllChatsState();
}

class _AllChatsState extends State<AllChats> {
  QuerySnapshot? chatRoomSnapshot;

  @override
  void initState() {
    getUserInfo();
    DatabaseServices().getChatRoom(Constants.myName).then((value) {
      setState(() {
        chatRoomSnapshot = value;
      });
    });
    super.initState();
  }

  getUserInfo() async {
    Constants.myName = await HelperFunctions.getUserNameDetatils();
    Constants.myEmail = await HelperFunctions.getUserEmailDetatils();
  }

  Widget chatRoomList() {
    return chatRoomSnapshot != null
        ? chatRoomSnapshot!.docChanges.length == 0
            ? Container(
                child: Center(
                  child: Text("No Recent chat.."),
                ),
              )
            : Container(
                child: Column(
                  children: [
                    ListView.builder(
                        shrinkWrap: true,
                        physics: ClampingScrollPhysics(),
                        itemCount: chatRoomSnapshot!.docChanges.length,
                        itemBuilder: (context, index) {
                          return ChatRoomTile(
                            userName: chatRoomSnapshot!
                                .docChanges[index].doc['chatRoomId']
                                .replaceAll('_', '')
                                .replaceAll(Constants.myName, ''),
                            chatRoomId: chatRoomSnapshot!
                                .docChanges[index].doc['chatRoomId'],
                          );
                        }),
                  ],
                ),
              )
        : Container(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          width: MediaQuery.of(context).size.width, child: chatRoomList()),
    );
  }
}

class ChatRoomTile extends StatefulWidget {
  late String userName, chatRoomId;
  ChatRoomTile({required this.userName, required this.chatRoomId});

  @override
  State<ChatRoomTile> createState() => _ChatRoomTileState();
}

class _ChatRoomTileState extends State<ChatRoomTile> {
  String changeString(String str) {
    return str[0].toUpperCase() + str.substring(1);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ConversationPage(
                    userName: widget.userName, chatRoomId: widget.chatRoomId)));
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 12),
        padding: EdgeInsets.all(19),
        child: Row(
          children: [
            Container(
              height: 40,
              width: 40,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Colors.blue,
              ),
              child: Text(
                widget.userName.substring(0, 1).toUpperCase(),
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(
              width: 15,
            ),
            Container(
              child: Text(
                changeString(widget.userName),
                style: TextStyle(fontSize: 19),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
