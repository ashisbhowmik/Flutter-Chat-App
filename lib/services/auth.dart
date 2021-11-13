import 'package:firebase_auth/firebase_auth.dart';

class AuthServices {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Future handleSignIn(String email, String password) async {
    try {
      UserCredential authResult = await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      final User user = authResult.user!;
      return user;
    } catch (e) {
      print("Error during Auth_SignIn 🥰🥰🥰🥰🥰 $e");
    }
  }

  Future handleSignUp(String email, String password) async {
    try {
      UserCredential authResult = await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      final User user = authResult.user!;
      return user;
    } catch (e) {
      print("Error happen during Auth_SignUp 🥰🥰🥰🥰🥰 $e");
    }
  }

  Future handleSignOut() async {
    try {
      return await firebaseAuth.signOut();
    } catch (e) {
      print("Error during Auth_SignOut 🥰🥰🥰🥰🥰 $e");
    }
  }
}
