import 'dart:convert';

import 'package:app/model/map_point.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RememberMapPointPrefs{
  // get Point info
  static Future<Point?> readPointData() async {
    Point? currentPointInfo;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? pointInfo = preferences.getString("currentPoint");

    if(pointInfo != null){
      Map<String, dynamic> pointDataMap = jsonDecode(pointInfo);
      currentPointInfo = Point.fromJson(pointDataMap);
    }
    return currentPointInfo;
  }
}