import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:app/authentication/signin.dart';
import 'package:app/fragments/dashboard_of_fragmens.dart';
import 'package:app/model/user_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Request location permissions
  final PermissionStatus status = await Permission.location.request();

  if (status.isGranted) {
    runApp(MyApp());
  } else {
    // Handle the case when the user denies location permissions
    // You can display a message or guide the user to enable permissions.
    runApp(MyApp()); // You may choose to run the app even if permissions are denied
  }
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: FutureBuilder(
        future: RememberUserPrefs.readUserData(),
        builder: (context, dataSnapShot) {
          if (dataSnapShot.data == null) {
            return SignIn();
          } else {
            return DashboardOfFragments();
          }
        },
      ),
    );
  }
}
