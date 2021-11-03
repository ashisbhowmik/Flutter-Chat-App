import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class DatabaseServices {
  Future<void> addQuizData(quizData, String quizId) async {
    await FirebaseFirestore.instance
        .collection('Quizes')
        .doc(quizId)
        .set(quizData)
        .catchError((e) {
      print(" addQuizData Error is ------------>>> ${e.toString()}");
    });
  }
  Future <void>addQuestionData(questionData, String quizId)async{
    await FirebaseFirestore.instance.collection("Quizes").doc(quizId).collection("QNA").add(questionData).catchError((e){
      print("addQuestionData Error is ------------>>> ${e.toString()}");
    });
  }
}


