import 'package:firebase_auth/firebase_auth.dart';

class AuthServices{
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Future handleSignIn(String email, String password) async{
    UserCredential authResult = await firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
    final User user = authResult.user!;
    return user;
  }
  Future handleSignUp(String email, String password) async{
    UserCredential authResult = await firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
    final User user = authResult.user!;
    return user;
  }

  Future handleSignOut() async{
    return await firebaseAuth.signOut();
  }
}