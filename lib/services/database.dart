import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class DatabaseServices {
  Future addUserInfo(String email, userInfoMap) async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(email)
        .set(userInfoMap)
        .catchError((e) {
      print("addQuizData Error is ------------>>> ${e.toString()}");
    });
  }

  Future getUserInfo() async {
    return await FirebaseFirestore.instance
        .collection("users")
        .get()
        .catchError((e) {
      print("getUserInfo Error is ------------>>> ${e.toString()}");
    });
  }

  Future getUserByUsername(String username) async {
    return await FirebaseFirestore.instance
        .collection("users")
        .where("userName", isEqualTo: username)
        .get();
  }

  Future getUserByUserEmail(String userEmail) async {
    return await FirebaseFirestore.instance
        .collection("users")
        .where("email", isEqualTo: userEmail)
        .get();
  }

  Future createChatRoom(String roomId, roomMap) async {
    await FirebaseFirestore.instance
        .collection("ChatRoom")
        .doc(roomId)
        .set(roomMap)
        .catchError((e) {
      print("createChatRoom Error is ------------>>> ${e.toString()}");
    });
  }

  Future addChatInChatRoom(String roomId, chatMap) async {
    await FirebaseFirestore.instance
        .collection("ChatRoom")
        .doc(roomId)
        .collection("chats")
        .add(chatMap)
        .catchError((e) {
      print("addChatInChatRoom Error is ------------>>> ${e.toString()}");
    });
  }

  Future getChatFromChatRoom(String roomId) async {
    return await FirebaseFirestore.instance
        .collection("ChatRoom")
        .doc(roomId)
        .collection("chats")
        .orderBy("timeStamp", descending: false)
        .snapshots();
  }

  Future getChatRoom(String userName) async {
    return await FirebaseFirestore.instance
        .collection("ChatRoom")
        .where("users", arrayContains: userName)
        .get();
  }

  Future<void> addQuizData(quizData, String quizId) async {
    await FirebaseFirestore.instance
        .collection('Quizes')
        .doc(quizId)
        .set(quizData)
        .catchError((e) {
      print("addQuizData Error is ------------>>> ${e.toString()}");
    });
  }

  Future<void> addQuestionsData(questionData, String quizId) async {
    await FirebaseFirestore.instance
        .collection("Quizes")
        .doc(quizId)
        .collection("QNA")
        .add(questionData)
        .catchError((e) {
      print("addQuestionData Error is ------------>>> ${e.toString()}");
    });
  }

  getCategoryQuizesDetails() async {
    await Firebase.initializeApp()
        .whenComplete(() => print("Completed initialization ☺☺☺☺☺☺☺"));
    return await FirebaseFirestore.instance.collection("Quizes").get();
  }

  getQuizData(String quizId) async {
    return await FirebaseFirestore.instance
        .collection("Quizes")
        .doc(quizId)
        .collection("QNA")
        .get();
  }
}
