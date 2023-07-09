import 'package:app/model/current_user.dart';
import 'package:flutter/material.dart';
import 'package:app/colors.dart';
import 'package:get/get.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:app/pages/home/home.dart';
import 'package:app/pages/map/map.dart';
import 'package:app/pages/profile/profile.dart';
import 'package:app/pages/error.dart';

int currentIndex = 2;

final screen = [
  ErrorPage(),
  MapPage(),
  HomePage(),
  ProfilePage()
];

class DashboardOfFragments extends StatefulWidget {
  const DashboardOfFragments({super.key});

  @override
  State<DashboardOfFragments> createState() => _DashboardOfFragmentsState();
}

class _DashboardOfFragmentsState extends State<DashboardOfFragments> {
  CurrentUser _rememberCurrentUser = Get.put(CurrentUser());

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: CurrentUser(),
      initState: (currentState) {
        _rememberCurrentUser.getUserInfo();
      },
      builder: (controller){
        return Scaffold(
          backgroundColor: background,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            //  To remove shadowes
            elevation: 0.0,
            toolbarHeight: 80,
            title: const Center(
              child: Image(
                image: AssetImage('images/logo.png'),
                height: 65,
              ),
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
              backgroundColor: background,
              selectedItemColor: GREEN,
              unselectedItemColor: BLACK,
              selectedFontSize: 15,
              unselectedFontSize: 15,
              items: const [
                BottomNavigationBarItem(
                  label: 'Create',
                  icon: Icon(FontAwesomeIcons.plus),
                ),
                BottomNavigationBarItem(
                  label: 'Map',
                  icon: Icon(FontAwesomeIcons.mapLocationDot),
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
        );
      },
    );
  }
}