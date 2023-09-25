import 'package:app/model/current_user.dart';
import 'package:flutter/material.dart';
import 'package:app/colors.dart';
import 'package:get/get.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:app/fragments/home/home.dart';
import 'package:app/fragments/profile/profile.dart';
import 'package:app/fragments/map.dart';

import 'package:app/fragments/error.dart';

import 'package:app/l10n/app_localizations.dart';

int currentIndex = 2;

final screen = [
  MapPage(),
  ErrorPage(),
  HomePage(),
  ProfilePage(),
  ErrorPage()
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
    final AppLocalizations appLocalizations = AppLocalizations.of(context);

    final pageTitle = [
      appLocalizations.page_title_map,
      appLocalizations.page_title_pet,
      appLocalizations.page_title_home,
      appLocalizations.page_title_profile,
      appLocalizations.page_title_calendar,
    ];

    return GetBuilder(
      init: CurrentUser(),
      initState: (currentState) {
        _rememberCurrentUser.getUserInfo();
      },
      builder: (controller){
        return Scaffold(
          backgroundColor: Background,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            elevation: 0.0,
            toolbarHeight: 80,
            title: Padding(
              padding: const EdgeInsets.only(left: 5),
              child: Text(
                pageTitle[currentIndex],
                style: TextStyle(
                  color: TextColor,
                  fontWeight: FontWeight.w500,
                  fontSize: 24
                ),
              ),
            ),
            backgroundColor: Background,
            
          ),
          body: screen[currentIndex],
          bottomNavigationBar: SizedBox(
            height: 80,
            width: 10,
            child: Container(
              child: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                backgroundColor: NavigationBarBG,
                selectedItemColor: NavigationBarSel,
                unselectedItemColor: NavigationBarUnSel.withOpacity(0.6),
                showSelectedLabels: false,
                showUnselectedLabels: false,
                iconSize: 25,
                items: [
                  BottomNavigationBarItem(
                    label: '',
                    icon: Icon(FontAwesomeIcons.mapLocationDot),
                  ),
                  BottomNavigationBarItem(
                    label: '',
                    icon: Icon(FontAwesomeIcons.paw),
                  ),
                  BottomNavigationBarItem(
                    label: '',
                    icon: Icon(FontAwesomeIcons.house),
                  ),
                  BottomNavigationBarItem(
                    label: '',
                    icon: Icon(FontAwesomeIcons.user),
                  ),
                  BottomNavigationBarItem(
                    label: '',
                    icon: Icon(FontAwesomeIcons.calendar),
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