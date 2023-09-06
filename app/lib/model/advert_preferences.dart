import 'dart:convert';

import 'package:app/model/advert.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RememberAdvertPrefs{
  // get Advert info
  static Future<Advert?> readAdvertData() async {
    Advert? currentAdvertInfo;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? advertInfo = preferences.getString("currentAdvert");

    if(advertInfo != null){
      Map<String, dynamic> pointDataMap = jsonDecode(advertInfo);
      currentAdvertInfo = Advert.fromJson(pointDataMap);
    }
    return currentAdvertInfo;
  }
}