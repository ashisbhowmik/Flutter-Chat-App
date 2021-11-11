import 'package:shared_preferences/shared_preferences.dart';

class HelperFunctions {
  static late String userLoggedInKey = "USERLOGGEDINKEY";
  static late String userNameKey = "UESENAMEKEY";
  static late String userEmailKey = "USEREMAILKEY";


  // setting data

  static saveUserLoggedInDetatils({required bool isLoggedIn}) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setBool(userLoggedInKey, isLoggedIn);
  }
  static saveUserNameDetatils({required String userName}) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString(userNameKey, userName);
  }
  static saveUserEmailDetatils({required String userEmail}) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString(userEmailKey, userEmail);
  }

  //getting data

  static getUserLoggedInDetails() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getBool(userLoggedInKey);
  }
  static getUserNameDetatils() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString(userNameKey);
  }
  static getUserEmailDetatils() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString(userEmailKey);
  }


}
