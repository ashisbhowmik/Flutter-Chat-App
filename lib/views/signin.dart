import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quizmaker/views/singup.dart';
import 'package:quizmaker/widgets/widget.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _formKey = GlobalKey<FormState>();
  late String email, password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        centerTitle: true,
        elevation: 0,
        title: appBar(context),
      ),
      body: Form(
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
                  email = val;
                },
              ),
              SizedBox(
                height: 30,
              ),
              Container(
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
                  style: TextStyle(color: Colors.white, fontSize: 17),
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
                    onTap:(){
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>SignUpPage()));
                    },
                    child: Text(
                      "Sign Up",
                      style: TextStyle(
                          fontSize: 15.5, decoration: TextDecoration.underline),
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
      ),
    );
  }
}
