import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class DatabaseServices {
  Future<void> addQuizData(quizData, String quizId) async {
    await FirebaseFirestore.instance
        .collection('Quizes')
        .doc(quizId)
        .set(quizData)
        .catchError((e) {
      print("Error is ------------>>> ${e.toString()}");
    });
  }
}
