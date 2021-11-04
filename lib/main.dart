import 'package:flutter/material.dart';
import 'package:quizmaker/helper/functions.dart';
import 'package:quizmaker/views/home.dart';
import 'package:quizmaker/views/signin.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/services.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: Colors.white,
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isLoggedIn = false;

  checkLoggedInStatus() async {
    HelperFunctions.getUserLoggedInDetails().then((val) {
      setState(() {
        isLoggedIn = val;
      });
    });
  }

  @override
  void initState() {
    checkLoggedInStatus();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        // fontFamily: GoogleFonts.lato().fontFamily,
        fontFamily: GoogleFonts.montserrat().fontFamily,
      ),
      home: isLoggedIn ? Home() : SignIn(),
    );
  }
}
