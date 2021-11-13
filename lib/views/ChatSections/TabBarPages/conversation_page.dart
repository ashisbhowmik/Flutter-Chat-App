import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quizmaker/helper/constants.dart';
import 'package:quizmaker/services/database.dart';
import 'package:quizmaker/views/ChatSections/chat_home_page.dart';

class ConversationPage extends StatefulWidget {
  late String userName, userEmail, chatRoomId;
  ConversationPage(
      {required this.userName, this.userEmail = "", required this.chatRoomId});

  @override
  _ConversationPageState createState() => _ConversationPageState();
}

class _ConversationPageState extends State<ConversationPage> {
  TextEditingController _message = new TextEditingController();
  Stream? chatQuerySnapshot;

  sendMessege() {
    if (_message.text.isNotEmpty) {
      Map<String, dynamic> chatMap = {
        "message": _message.text,
        "sendBy": Constants.myName,
        "timeStamp": DateTime.now().millisecondsSinceEpoch,
      };
      DatabaseServices().addChatInChatRoom(widget.chatRoomId, chatMap);
      setState(() {
        _message.clear();
      });
    } else {
      print("--------------------------> noting to send as the field is empty");
    }
  }

  Widget chatList() {
    return Container(
        child: Column(
      children: [
        StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("ChatRoom")
                .doc(widget.chatRoomId)
                .collection("chats")
                .orderBy("timeStamp", descending: false)
                .snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                    shrinkWrap: true,
                    physics: ClampingScrollPhysics(),
                    itemCount: snapshot.data!.docChanges.length,
                    itemBuilder: (context, index) {
                      return MessageTile(
                        message:
                            snapshot.data!.docChanges[index].doc['message'],
                        sendBy: snapshot.data!.docChanges[index].doc['sendBy'],
                      );
                    });
              } else {
                return Center(
                  child: LinearProgressIndicator(),
                );
              }
            })
      ],
    ));
  }

  @override
  void initState() {
    DatabaseServices().getChatFromChatRoom(widget.chatRoomId).then((val) {
      setState(() {
        chatQuerySnapshot = val;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.7,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.blue),
        leading: InkWell(
            onTap: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ChatHomePage()));
            },
            child: const Icon(Icons.arrow_back_ios, color: Colors.blue)),
        title: Text(
          "${widget.userName}",
          style: const TextStyle(color: Colors.black),
        ),
      ),
      body: Container(
        child: Stack(
          children: [
            SingleChildScrollView(
                child: Container(
                    margin: EdgeInsets.only(bottom: 169), child: chatList())),
            Container(
              alignment: Alignment.bottomCenter,
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 12,
                ),
                margin: EdgeInsets.symmetric(vertical: 12),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 19,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(36),
                      ),
                      width: MediaQuery.of(context).size.width / 1.28,
                      child: TextField(
                        textInputAction: TextInputAction.search,
                        controller: _message,
                        decoration: InputDecoration(
                          hintText: "Type to Send Messages...",
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    Container(
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(36),
                        ),
                        margin: EdgeInsets.only(left: 4),
                        child: IconButton(
                          icon: Icon(
                            Icons.send,
                            color: Colors.white,
                            size: 32,
                          ),
                          onPressed: () {
                            sendMessege();
                          },
                        )),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MessageTile extends StatefulWidget {
  late String message, sendBy;
  MessageTile({required this.message, required this.sendBy});

  @override
  _MessageTileState createState() => _MessageTileState();
}

class _MessageTileState extends State<MessageTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      alignment: widget.sendBy == Constants.myName
          ? Alignment.centerRight
          : Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 27,
          vertical: 12,
        ),
        margin: EdgeInsets.only(right: 22, left: 22, top: 8, bottom: 8),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: widget.sendBy == Constants.myName
                ? [const Color(0xff007EF4), const Color(0xff2A75BC)]
                : [
                    Colors.black.withOpacity(0.7),
                    Colors.black.withOpacity(0.7)
                  ],
          ),
          borderRadius: widget.sendBy == Constants.myName
              ? BorderRadius.only(
                  topLeft: Radius.circular(30),
                  bottomLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                )
              : BorderRadius.only(
                  topRight: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                  topLeft: Radius.circular(30),
                ),
        ),
        child: Text(
          "${widget.message}",
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
