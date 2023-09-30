import 'dart:convert';

import 'user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RememberUserPrefs{
  // save User info
  static Future<void> saveUserData(User userInfo) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String userJsonData = jsonEncode(userInfo.toJson());
    await preferences.setString("currentUser", userJsonData);
  }

  // get User info
  static Future<User?> readUserData() async {
    User? currentUserInfo;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? userInfo = preferences.getString("currentUser");

    if(userInfo != null){
      Map<String, dynamic> userDataMap = jsonDecode(userInfo);
      currentUserInfo = User.fromJson(userDataMap);
    }
    return currentUserInfo;
  }

  //  delete user info
  static Future<void> removeUseData() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.remove('currentUser');
  }
}