import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:get/get.dart';

import 'l10n/app_localizations.dart';
import 'authentication/signin.dart';
import 'fragments/dashboard_of_fragmens.dart';
import 'model/user_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final PermissionStatus status = await Permission.location.request();

  if (status.isGranted) {
    runApp(MyApp());
  } else {
    runApp(MyApp());
  }
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: [
        const AppLocalizationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales, 
      home: FutureBuilder(
        future: RememberUserPrefs.readUserData(),
        builder: (context, dataSnapShot) {
          print('DataSnapshot: ${dataSnapShot.data}');
          
          if (dataSnapShot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (dataSnapShot.hasError) {
            return Text('Error: ${dataSnapShot.error}');
          } else if (dataSnapShot.data == null) {
            return SignIn();
          } else {
            return DashboardOfFragments();
          }
        },
      ),
    );
  }
}
