import 'dart:convert';

import 'user_pet.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RememberUserPetPrefs{
  // get UserPet info
  static Future<User_Pet?> readUserPetData() async {
    User_Pet? currentUserPetInfo;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? userPetInfo = preferences.getString("currentUserPet");

    if(userPetInfo != null){
      Map<String, dynamic> pointDataMap = jsonDecode(userPetInfo);
      currentUserPetInfo = User_Pet.fromJson(pointDataMap);
    }
    return currentUserPetInfo;
  }
}