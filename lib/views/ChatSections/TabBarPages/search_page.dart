import 'dart:isolate';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:quizmaker/helper/constants.dart';
import 'package:quizmaker/services/database.dart';
import 'package:quizmaker/views/ChatSections/TabBarPages/conversation_page.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late TextEditingController _searchTerm = new TextEditingController();
  DatabaseServices databaseServices = new DatabaseServices();
  QuerySnapshot? querySnapshot;
  QuerySnapshot? usersSnapshot;
  bool isLoading = false;

  initialSearch() {
    if (_searchTerm.text.isEmpty) {
      setState(() {
        isLoading = true;
      });
    }
    databaseServices.getUserByUsername(_searchTerm.text).then((val) async {
      querySnapshot = val;
      setState(() {
        isLoading = false;
        _searchTerm.clear();
      });
    });
  }

  findInitialUser() async {
    if (_searchTerm.text.isEmpty) {
      setState(() {
        isLoading = true;
      });
    }
    databaseServices.getUserInfo().then((val) {
      setState(() {
        usersSnapshot = val;
      });
    });
  }

  @override
  void initState() {
    findInitialUser();
    initialSearch();
    super.initState();
  }

  Widget SearchList() {
    return querySnapshot == null
        ? Container()
        : querySnapshot!.docChanges.length == 0
            ? Container(
                margin: EdgeInsets.only(bottom: 20),
                child: Center(
                  child: Text("No SearchQuery  !"),
                ),
              )
            : ListView.builder(
                shrinkWrap: true,
                itemCount: querySnapshot!.docChanges.length,
                itemBuilder: (context, index) {
                  return SearchTile(
                    userName: querySnapshot!.docChanges[index].doc["userName"],
                    userEmail: querySnapshot!.docChanges[index].doc["email"],
                  );
                });
  }

  Widget usersInDatabase() {
    return Container(
        child: Column(
      children: [
        usersSnapshot == null
            ? Container(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              )
            : ListView.builder(
                physics: ClampingScrollPhysics(),
                shrinkWrap: true,
                itemCount: usersSnapshot!.docChanges.length,
                itemBuilder: (context, index) {
                  return UsersList(
                    userName: usersSnapshot!.docChanges[index].doc['userName'],
                    userEmail: usersSnapshot!.docChanges[index].doc['email'],
                  );
                },
              )
      ],
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? Container(
              child: Center(
              child: CircularProgressIndicator(),
            ))
          : SingleChildScrollView(
              child: Container(
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 20,
                      ),
                      margin:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.4),
                        borderRadius: BorderRadius.circular(36),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              textInputAction: TextInputAction.search,
                              controller: _searchTerm,
                              decoration: InputDecoration(
                                hintText: "Search Username",
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                          GestureDetector(
                              onTap: () {
                                initialSearch();
                              },
                              child: Hero(tag: {}, child: Icon(Icons.search))),
                        ],
                      ),
                    ),
                    SearchList(),
                    // usersInDatabase(),
                  ],
                ),
              ),
            ),
    );
  }
}

class SearchTile extends StatefulWidget {
  late String userName, userEmail;
  SearchTile({required this.userName, required this.userEmail});

  @override
  _SearchTileState createState() => _SearchTileState();
}

class _SearchTileState extends State<SearchTile> {
  late String roomId;
  goToConversationPage(String username) async {
    roomId = "${Constants.myName}_$username";
    print("username is -------------------->>>> ${Constants.myName}");
    print("Room Id is -------------------->>>> ${roomId}");
    List<String> users = [Constants.myName, username];
    Map<String, dynamic> chatRoomMap = {
      "users": users,
      "chatRoomId": "${Constants.myName}_$username",
    };
    await DatabaseServices().createChatRoom(roomId, chatRoomMap);
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ConversationPage(
                  userName: widget.userName,
                  userEmail: widget.userEmail,
                  chatRoomId: roomId,
                )));
  }

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: {},
      child: widget.userName == Constants.myName
          ? Center(child: Text("This is You"))
          : Card(
              margin: EdgeInsets.only(left: 17, right: 17, bottom: 19),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 5),
                    padding: EdgeInsets.all(8),
                    child: Text(
                      "Search for  ${widget.userName}",
                      style: TextStyle(fontSize: 17),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 31, vertical: 10),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("${widget.userName}"),
                              Text("${widget.userEmail}"),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            goToConversationPage(widget.userName);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(27),
                            ),
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 7),
                            child: Text(
                              "Message",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}

class UsersList extends StatefulWidget {
  late String userName, userEmail;
  UsersList({required this.userName, required this.userEmail});

  @override
  _UsersListState createState() => _UsersListState();
}

class _UsersListState extends State<UsersList> {
  late String roomId;
  goToConversationPage(String username) async {
    roomId = "${Constants.myName}_$username";
    print("username is -------------------->>>> ${Constants.myName}");
    print("Room Id is -------------------->>>> ${roomId}");
    List<String> users = [Constants.myName, username];
    Map<String, dynamic> chatRoomMap = {
      "users": users,
      "chatRoomId": "${Constants.myName}_$username",
    };
    await DatabaseServices().createChatRoom(roomId, chatRoomMap);
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ConversationPage(
                  userName: widget.userName,
                  userEmail: widget.userEmail,
                  chatRoomId: roomId,
                )));
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(left: 17, right: 17, bottom: 12),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 31, vertical: 17),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("${widget.userName}"),
                  Text("${widget.userEmail}"),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                goToConversationPage(widget.userName);
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(27),
                ),
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                child: Text(
                  "Message",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
