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
        builder: (context, dataSnapShot){
          return SignIn();
        }
      )
    );
  }
}
