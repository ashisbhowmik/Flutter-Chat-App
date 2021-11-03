import 'package:shared_preferences/shared_preferences.dart';

class HelperFunctions{

  static String userLoggedInKey = "USERLOGGEDINKEY";

  static saveUserLoggedInDetatils({required bool isLoggedIn})async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setBool(userLoggedInKey, isLoggedIn);
  }
  static getUserLoggedInDetails()async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getBool(userLoggedInKey);
  }
}