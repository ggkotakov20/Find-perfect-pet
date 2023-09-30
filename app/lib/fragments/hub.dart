import 'package:app/fragments/advert/your_adverts.dart';
import 'package:app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:app/colors.dart';
import 'package:get/get.dart';
import 'package:app/authentication/signin.dart';
import 'package:app/model/user_preferences.dart';

import 'package:app/fragments/profile/profile.dart';
import 'package:app/fragments/advert/add_advert.dart';
import 'package:app/functions/menu_button.dart';

import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

class Hub extends StatefulWidget {
  const Hub({super.key});

  @override
  State<Hub> createState() => _HubState();
}

class _HubState extends State<Hub> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
  child: Column(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      User(),
      SizedBox(height: 10),
      Adverts(),
      SizedBox(height: 10),
      LogOut(),
      SizedBox(height: 10),
    ],
  ),
);
  }
}

class User extends StatefulWidget {
  const User({super.key});

  @override
  State<User> createState() => _UserState();
}

class _UserState extends State<User> {
  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context);
    final double spacing = MediaQuery.of(context).size.width >= 400 ? 20.0 : 10.0;

    return Stack(
      children: [
        Padding(
          padding: EdgeInsets.only(top: 10, left: 25),
          child: Text(
            appLocalizations.general_user,
            style: TextStyle(
              color: Color.fromRGBO(134, 141, 154, 1),
              fontSize: 15,
            ),
          ),
        ),
        Center(
          child: Column(
            children: [
              // First row
              SizedBox(height: 40,),
              Wrap(
                runSpacing: 10,
                spacing: spacing, // Променяме разстоянието спрямо големината на дисплея
                children: [
                  // Profile
                  MenuButton(
                    icon: FontAwesomeIcons.user,
                    text: appLocalizations.general_profile,
                    gradientColors: CardBgBlue,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ProfilePage()),
                      );
                    },
                  ),
        
                  // Settings
                  MenuButton(
                    icon: FontAwesomeIcons.gear,
                    text: appLocalizations.general_settings,
                    gradientColors: CardBgPink,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ProfilePage()),
                      );
                    },
                  ),
        
                  // Favorite
                  MenuButton(
                    icon: FontAwesomeIcons.heart,
                    text: appLocalizations.general_favorite,
                    gradientColors: CardBgPink,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ProfilePage()),
                      );
                    },
                  ),
        
                  // Cart
                  MenuButton(
                    icon: FontAwesomeIcons.shoppingBag,
                    text: appLocalizations.general_cart,
                    gradientColors: CardBgBlue,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ProfilePage()),
                      );
                    },
                  ),
        
                  // Your orders
                  MenuButton(
                    icon: FontAwesomeIcons.shoppingCart,
                    text: 'Your orders',
                    gradientColors: CardBgPurple,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ProfilePage()),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}


class Adverts extends StatefulWidget {
  const Adverts({super.key});

  @override
  State<Adverts> createState() => _AdvertsState();
}

class _AdvertsState extends State<Adverts> {
  @override
  Widget build(BuildContext context) {
    final isWideScreen = MediaQuery.of(context).size.width >= 400;
    final AppLocalizations appLocalizations = AppLocalizations.of(context);

    return Stack(
      children: [
         Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.only(top: 10, left: 25),
            child: Text(
              appLocalizations.general_advert,
              style: TextStyle(
                color: Color.fromRGBO(134, 141, 154, 1),
                fontSize: 15,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Center(
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Column(
                children: [
                  SizedBox(height: 40,),
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: [
                      // Add advert
                      MenuButton(
                        icon: FontAwesomeIcons.plus,
                        text: appLocalizations.general_add,
                        gradientColors: CardBgYellow,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => AddAdvert()),
                          );
                        },
                      ),
            
                      // Your advert
                      MenuButton(
                        icon: FontAwesomeIcons.layerGroup,
                        text: appLocalizations.general_your_adverts,
                        gradientColors: CardBgYellow,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => YourAdvert()),
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}


class LogOut extends StatefulWidget {
  const LogOut({super.key});

  @override
  State<LogOut> createState() => _LogOutState();
}

class _LogOutState extends State<LogOut> {
  signOutUser() async {
    var resulResponse = await Get.dialog(AlertDialog(
      backgroundColor: Colors.white,
      title: Text(
        'Log out',
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
      content: Text('Are you sure\nyou wan to log out from app?'),
      actions: [
        TextButton(
          onPressed: () {
            Get.back();
          },
          child: Text('No', style: TextStyle(
            color: mainColor,
            fontWeight: FontWeight.bold
          ),),
        ),
        TextButton(
          onPressed: () {
            Get.back(result: 'Singout');
          },
          child: Text('Yes', style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w400
          ),),
        ),
      ],
    ));

    if(resulResponse == 'Singout'){
      //  Remove the user data from phone local storage
      RememberUserPrefs.removeUseData().then((value){
        Get.off(SignIn());
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context);
    
    return Stack(
      children: [
        Align(
          alignment: Alignment.centerLeft, // Adjust alignment as needed
          child: Padding(
            padding: const EdgeInsets.only(top: 10, left: 25),
            child: Text(
              appLocalizations.general_logout,
              style: TextStyle(
                color: Color.fromRGBO(134, 141, 154, 1),
                fontSize: 15,
              ),
            ),
          ),
        ),
        Center(
        child: Column(
          children: [
            SizedBox(height: 40,),
            Row(
              children: [
                //  Log out
                Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: MenuButton(
                      icon: FontAwesomeIcons.rightFromBracket,
                      text: appLocalizations.general_logout,
                      gradientColors: CardBgBlack,
                      onPressed: () {
                          signOutUser();
                        },
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
      ],
    );
  }
}