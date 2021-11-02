import 'package:flutter/material.dart';
import 'package:quizmaker/views/signin.dart';
import 'package:quizmaker/widgets/widget.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  late String name, email, password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        centerTitle: true,
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
                  labelText: "Name",
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
                  "Sign Up",
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
                    "Already have an account? ",
                    style: TextStyle(fontSize: 15.5),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => SignIn()));
                    },
                    child: Text(
                      "Sign In",
                      style: TextStyle(
                          fontSize: 15.5, decoration: TextDecoration.underline),
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
      ),
    );
  }
}
