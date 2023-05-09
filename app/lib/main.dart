import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:app/colors.dart';

import 'package:app/pages/home/home.dart';
import 'package:app/pages/map/map.dart';

void main() {
  runApp(MyApp());
}

int currentIndex = 1;

class MyApp extends StatefulWidget {
  MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final screen = [
    MapPage(),
    HomePage(),
    HomePage(),
  ];
  @override
  Widget build(BuildContext context) {
    print('$currentIndex');
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          //  To remove shadowes
          elevation: 0.0,
          toolbarHeight: 80,
          title: const Center(
            child: Image(
              image: AssetImage('images/logo.png'),
              height: 65,
            ),
            // child: Text(
            //   currentIndex == 0 ? 'SETTINGS' : currentIndex == 1 ? 'CATEGORY' : 'PROFILE',
            //   style: TextStyle(color: 27),
            // ),
          ),
          backgroundColor: background,
        ),
        body: screen[currentIndex],
        bottomNavigationBar: SizedBox(
          height: 80,
          width: 10,
          child: Container(
            child: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              backgroundColor: Colors.white,
              selectedItemColor: firstColor,
              unselectedItemColor: darkColor,
              selectedFontSize: 15,
              unselectedFontSize: 15,
              items: const [
                
                BottomNavigationBarItem(
                  label: 'Map',
                  icon: Icon(FontAwesomeIcons.map),
                ),
                BottomNavigationBarItem(
                  label: 'Home',
                  icon: Icon(FontAwesomeIcons.house),
                ),
                BottomNavigationBarItem(
                  label: 'Profile',
                  icon: Icon(FontAwesomeIcons.user),
                ),
              ],
              currentIndex: currentIndex,
              onTap: (int index) {
                setState(() {
                  currentIndex = index;
                });
              },
            ),
          ),
        ),
      ),
    );
  }
}
