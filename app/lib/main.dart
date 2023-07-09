import 'package:app/fragments/dashboard_of_fragmens.dart';
import 'package:app/model/user_preferences.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:app/authentication/signin.dart';

void main(){
  WidgetsFlutterBinding.ensureInitialized();
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: FutureBuilder(
        future: RememberUserPrefs.readUserData(),
        builder: (context, dataSnapShot){
          if(dataSnapShot.data == null){
            return SignIn();
          }
          else {
            return DashboardOfFragments();
          }
        }
      )
    );
  }
}
