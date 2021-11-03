import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:quizmaker/services/database.dart';
import 'package:quizmaker/views/create_quiz.dart';
import 'package:quizmaker/widgets/widget.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

   QuerySnapshot? quizSnapshot;

  Widget QuizList(){
    return quizSnapshot != null ?   Container(
        child: ListView.builder(
          padding: EdgeInsets.all(9),
          itemCount: quizSnapshot!.docChanges.length,
          itemBuilder: (context,index){
            return QuizTile(
                imgUrl: quizSnapshot!.docChanges[index].doc['imageUrl'],
                title: quizSnapshot!.docChanges[index].doc['title'],
                desc: quizSnapshot!.docChanges[index].doc['description']);
          },
        ),
    ):Container(child:Center(child: CircularProgressIndicator(),),);
  }
  @override
  void initState() {
    DatabaseServices().getQuizData().then((val){
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
        elevation: 0.0,
        centerTitle: true,
        title: appBar(context),
      ),
      body: Container(
        child:QuizList(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Create_Quiz()));
        },
        child: Icon(Icons.insert_drive_file),
      ),
    );
  }
}


class QuizTile extends StatelessWidget {
  String DemoImage  = "https://images.unsplash.com/photo-1635870970553-c9c5743ae092?ixid=MnwxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHwxMnx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=600&q=60";
  late String imgUrl, title, desc;
  QuizTile({
    required this.imgUrl,
    required this.title,
    required this.desc,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //         builder: (context) => DetailedBlogPage(
        //             imgUrl: imgUrl,
        //             title: title,
        //             desc: desc,
        //             authorName: authorName)));
      },
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 4),
        child: Container(
          height: 175,
          child: Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(11),
                child: CachedNetworkImage(
                  imageUrl:imgUrl,
                  fit: BoxFit.cover,
                  width: MediaQuery.of(context).size.width,
                ),
              ),
              Container(
                height: 175,
                decoration: BoxDecoration(
                  color: Colors.black87.withOpacity(0.37),
                  borderRadius: BorderRadius.circular(11),
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
                        fontSize: 24,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Container(
                      margin: EdgeInsets.only(right: 15, left: 15,top: 5),
                      child: Text(
                        desc,
                        style: TextStyle(color: Colors.white, fontSize: 14),
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
