import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quizmaker/helper/functions.dart';
import 'package:quizmaker/services/auth.dart';
import 'package:quizmaker/services/database.dart';
import 'package:quizmaker/views/QuizSections/create_quiz.dart';
import 'package:quizmaker/views/QuizSections/play_quiz.dart';
import 'package:quizmaker/views/AuthSections/signin.dart';
import 'package:quizmaker/widgets/widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/cupertino.dart';

class QuizHomePage extends StatefulWidget {
  const QuizHomePage({Key? key}) : super(key: key);

  @override
  _QuizHomePageState createState() => _QuizHomePageState();
}

class _QuizHomePageState extends State<QuizHomePage> {
  QuerySnapshot? quizSnapshot;
  Future refreshFunction() async {
    setState(() {
      DatabaseServices().getCategoryQuizesDetails().then((val) {
        quizSnapshot = val;
      });
    });
  }

  Widget QuizList() {
    return quizSnapshot != null
        ? Container(
            child: ListView.builder(
              padding: EdgeInsets.all(9),
              itemCount: quizSnapshot!.docChanges.length,
              itemBuilder: (context, index) {
                return QuizTile(
                  imgUrl: quizSnapshot!.docChanges[index].doc['imageUrl'],
                  title: quizSnapshot!.docChanges[index].doc['title'],
                  desc: quizSnapshot!.docChanges[index].doc['description'],
                  quizId: quizSnapshot!.docChanges[index].doc['quizId'],
                );
              },
            ),
          )
        : Container(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
  }

  @override
  void initState() {
    DatabaseServices().getCategoryQuizesDetails().then((val) {
      setState(() {
        quizSnapshot = val;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.39,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        iconTheme: IconThemeData(color: Colors.black),
        title: appBar(context),
        // leading: IconButton(
        //   onPressed: (){
        //     Navigator.of(context).pop();
        //   },
        //
        //   icon: Icon((Icons.arrow_back_ios)),iconSize: 24,),
        actions: [
          Container(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  GestureDetector(
                      onTap: () {
                        showDialog();
                      },
                      child: Icon(CupertinoIcons.rectangle_expand_vertical)),
                  SizedBox(
                    width: 3,
                  ),
                ],
              ),
            ),
          ),
          IconButton(
              onPressed: () {},
              iconSize: 49.0,
              icon: CircleAvatar(
                foregroundImage: NetworkImage(
                    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTjAu2MrCT5STGESDsl1cg5kF8MTyd2EE2Ot_u8vfmkSAoamwY8ohUxEIXhuURQG_OXDHQ&usqp=CAUhttps://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTjAu2MrCT5STGESDsl1cg5kF8MTyd2EE2Ot_u8vfmkSAoamwY8ohUxEIXhuURQG_OXDHQ&usqp=CAU"),
              ))
        ],
      ),
      body: RefreshIndicator(
        onRefresh: refreshFunction,
        child: Container(
          child: QuizList(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Create_Quiz()));
        },
        child: Icon(CupertinoIcons.arrow_down_doc_fill),
      ),
    );
  }

  void showDialog() {
    showCupertinoDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: Text("Logging You Out"),
          content: Text("Are you sure you want to LogOut From Your Account?"),
          actions: [
            CupertinoDialogAction(
                child: Text("Yes "),
                onPressed: () {
                  HelperFunctions.saveUserLoggedInDetatils(isLoggedIn: false);
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SignIn()));
                  setState(() {});
                }),
            CupertinoDialogAction(
                child: Text("Cancel"),
                onPressed: () {
                  Navigator.of(context).pop();
                }),
          ],
        );
      },
    );
  }
}

class QuizTile extends StatelessWidget {
  String DemoImage =
      "https://images.unsplash.com/photo-1635870970553-c9c5743ae092?ixid=MnwxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHwxMnx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=600&q=60";
  late String imgUrl, title, desc, quizId;
  QuizTile({
    required this.imgUrl,
    required this.title,
    required this.desc,
    required this.quizId,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => PlayQuiz(
                      quizId: quizId,
                      title: title,
                    )));
      },
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 4),
        child: Container(
          height: 150,
          child: Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: CachedNetworkImage(
                  imageUrl: imgUrl,
                  fit: BoxFit.cover,
                  width: MediaQuery.of(context).size.width,
                ),
              ),
              Container(
                height: 150,
                decoration: BoxDecoration(
                  color: Colors.black87.withOpacity(0.47),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      title,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Container(
                      margin: EdgeInsets.only(right: 15, left: 15, top: 1),
                      child: Text(
                        desc,
                        style:
                            GoogleFonts.lato(color: Colors.white, fontSize: 10),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
