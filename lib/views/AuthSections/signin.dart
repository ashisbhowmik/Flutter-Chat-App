import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quizmaker/helper/functions.dart';
import 'package:quizmaker/services/auth.dart';
import 'package:quizmaker/services/database.dart';
import 'package:quizmaker/views/AuthSections/singup.dart';
import 'package:quizmaker/views/ChatSections/chat_home_page.dart';
import 'package:quizmaker/widgets/widget.dart';
import '../QuizSections/quiz_home_page.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _formKey = GlobalKey<FormState>();
  late String email, password;
  bool isLoading = false;
  bool errorDuringSignIn = false;

  signIn() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });
      await AuthServices().handleSignIn(email, password).then((val) async {
        if (val != null) {
          QuerySnapshot snapshot =
              await DatabaseServices().getUserByUserEmail(email);
          HelperFunctions.saveUserLoggedInDetatils(isLoggedIn: true);
          HelperFunctions.saveUserNameDetatils(
              userName: snapshot.docChanges[0].doc['userName']);
          HelperFunctions.saveUserEmailDetatils(
              userEmail: snapshot.docChanges[0].doc['email']);
          print("----------------> Completed");
          setState(() {
            isLoading = false;
          });
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => ChatHomePage()));
        } else {
          setState(() {
            errorDuringSignIn = true;
          });
          print("Error during SignIn 🥰🥰🥰🥰🥰");
        }
        setState(() {
          isLoading = false;
        });
      });
    }
  }

  Widget ErrorHandleDuringSignIn() {
    return Container(
      alignment: Alignment.center,
      child: Container(
          margin: EdgeInsets.only(left: 29, right: 29),
          decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.4),
            borderRadius: BorderRadius.circular(20),
          ),
          height: 120,
          alignment: Alignment.center,
          child: Column(children: [
            Container(
              margin: EdgeInsets.only(top: 22),
              child: Text(
                "Invalid Userrname or Password",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            InkWell(
              onTap: () {
                setState(() {
                  errorDuringSignIn = false;
                });
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(9),

                ),
                padding: EdgeInsets.only(top: 7,bottom: 7,left: 7,right: 7),
                child: Text(
                  "Try Again",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
          ])),
    );
  }

  @override
  void initState() {
    Firebase.initializeApp();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        centerTitle: true,
        elevation: 0,
        title: appBar2(context),
      ),
      body: errorDuringSignIn == false
          ? isLoading
              ? Container(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                )
              : Form(
                  key: _formKey,
                  child: Container(
                    // color: Colors.blue,
                    padding: EdgeInsets.symmetric(horizontal: 26),
                    child: Column(
                      children: [
                        Spacer(),
                        TextFormField(
                          // ignore: prefer_const_constructors
                          validator: (val) {
                            if (val == null || val.isEmpty) {
                              return "Please fill this field Carefully";
                            } else {
                              return null;
                            }
                          },
                          // ignore: prefer_const_constructors
                          decoration: InputDecoration(
                            labelText: "Email",
                          ),
                          onChanged: (val) {
                            email = val;
                          },
                        ),
                        TextFormField(
                          // ignore: prefer_const_constructors
                          validator: (val) {
                            if (val == null || val.isEmpty) {
                              return "Please fill this field Carefully";
                            } else {
                              return null;
                            }
                          },
                          // ignore: prefer_const_constructors
                          decoration: InputDecoration(
                            labelText: "Password",
                          ),
                          onChanged: (val) {
                            password = val;
                          },
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        GestureDetector(
                          onTap: () {
                            signIn();
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 26),
                            height: 45,
                            width: MediaQuery.of(context).size.width,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: Colors.blue,
                            ),
                            child: Text(
                              "Sign In",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 17),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Don't have an account? ",
                              style: TextStyle(fontSize: 15.5),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SignUpPage()));
                              },
                              child: Text(
                                "Sign Up",
                                style: TextStyle(
                                    fontSize: 15.5,
                                    decoration: TextDecoration.underline),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 80,
                        ),
                      ],
                    ),
                  ),
                )
          : Container(
              child: ErrorHandleDuringSignIn(),
            ),
    );
  }
}
