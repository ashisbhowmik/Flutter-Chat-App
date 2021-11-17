import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:quizmaker/helper/functions.dart';
import 'package:quizmaker/services/auth.dart';
import 'package:quizmaker/services/database.dart';
import 'package:quizmaker/views/AuthSections/signin.dart';
import 'package:quizmaker/views/ChatSections/chat_home_page.dart';
import 'package:quizmaker/widgets/widget.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  late String name, email, password;
  bool isLoading = false;
  bool errorDuringSignUp = false;

  signUp() async {
    if (_formKey.currentState!.validate()) {
      print("name is: $name, email is: $email, password is: $password");
      setState(() {
        isLoading = true;
      });
      await AuthServices().handleSignUp(email, password).then((val) {
        if (val == null) {
          setState(() {
            errorDuringSignUp = true;
          });
          print("Error during SignUp 🥰🥰🥰🥰🥰");
        } else {
          setState(() {
            isLoading = false;
          });
          Map<String, dynamic> userInfoMap = {
            "email": email,
            "userName": name,
          };
          HelperFunctions.saveUserLoggedInDetatils(isLoggedIn: true);
          HelperFunctions.saveUserNameDetatils(userName: name);
          HelperFunctions.saveUserEmailDetatils(userEmail: email);
          DatabaseServices().addUserInfo(email, userInfoMap);
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => ChatHomePage()));
        }
        setState(() {
          isLoading = false;
        });
      });
    }
  }

  Widget ErrorHandleDuringSignUp() {
    return Container(
      alignment: Alignment.center,
      child: Container(
          margin: EdgeInsets.only(left: 29, right: 29),
          decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.4),
            borderRadius: BorderRadius.circular(20),
          ),
          height: 130,
          alignment: Alignment.center,
          child: Column(children: [
            Container(
              margin: EdgeInsets.only(top: 22),
              child: Text(
                "Please try again with other email",
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
                  errorDuringSignUp = false;
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
        backgroundColor: Colors.white,
        elevation: 0.0,
        centerTitle: true,
        title: appBar3(context),
      ),
      body: errorDuringSignUp == false  ? isLoading
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
                        labelText: "Name",
                      ),
                      onChanged: (val) {
                        name = val;
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
                        signUp();
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
                          "Sign Up",
                          style: TextStyle(color: Colors.white, fontSize: 17),
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
                          "Already have an account? ",
                          style: TextStyle(fontSize: 15.5),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SignIn()));
                          },
                          child: Text(
                            "Sign In",
                            style: TextStyle(
                                fontSize: 15.5,
                                decoration: TextDecoration.underline),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 40,
                    ),
                  ],
                ),
              ),
            ) : Container(
            child: ErrorHandleDuringSignUp(),
      ),
    );
  }
}
