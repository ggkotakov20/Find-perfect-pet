import 'package:app/model/current_user.dart';
import 'package:flutter/material.dart';
import 'package:app/colors.dart';
import 'package:get/get.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:app/fragments/home/home.dart';
import 'package:app/fragments/map.dart';

import 'package:app/fragments/hub.dart';
import 'package:app/fragments/error.dart';

import 'package:app/l10n/app_localizations.dart';

int currentIndex = 1;

final screen = [
  MapPage(),
  HomePage(),
  Hub(),
  ErrorPage(),
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
                backgroundColor: NavigationBarBG,
                selectedItemColor: NavigationBarSel,
                unselectedItemColor: NavigationBarUnSel,
                selectedFontSize: 15,
                unselectedFontSize: 15,
                items: [
                  BottomNavigationBarItem(
                    label: appLocalizations.general_map,
                    icon: Icon(FontAwesomeIcons.mapLocationDot),
                  ),
                  BottomNavigationBarItem(
                    label: appLocalizations.general_home,
                    icon: Icon(FontAwesomeIcons.house),
                  ),
                  BottomNavigationBarItem(
                    label: appLocalizations.general_menu,
                    icon: Icon(FontAwesomeIcons.bars),
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