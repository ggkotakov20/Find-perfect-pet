import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:app/colors.dart';
import 'package:get/get.dart';
import 'package:app/authentication/signin.dart';
import 'package:app/model/user_preferences.dart';

import 'package:app/fragments/profile/profile.dart';
import 'package:app/fragments/advert/add_advert.dart';


class Hub extends StatefulWidget {
  const Hub({super.key});

  @override
  State<Hub> createState() => _HubState();
}

class _HubState extends State<Hub> {
  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        User(),
        SizedBox(height: 10,),
        Adverts(),
        SizedBox(height: 10,),
        LogOut(),
      ],
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
    return Stack(children: [
      const Padding(
        padding: const EdgeInsets.only(top: 10,left: 30),
        child: Text('User', 
          style: TextStyle(
            color: Color.fromRGBO(134, 141, 154, 1),
            fontSize: 15
          ),
        ),
      ),
      Center(
        child: Column(
          children: [
            // First row
            SizedBox(height: 40,),
            Row(
              children: [
                //  Profile
                Stack(
                  children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 30, right: 15),
                    child: SizedBox(
                      height: 65,
                      width: 65,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => ProfilePage()),
                            );
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.transparent,
                          padding: EdgeInsets.zero,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                          ),
                          elevation: 0,
                        ),
                        child: Container(
                          width: 65,
                          height: 65,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(18.0),
                            gradient: LinearGradient(
                              colors: CardBgBlue, // Define your gradient colors
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                          ),
                          child: Icon(
                            FontAwesomeIcons.user,
                            size: 25,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 70, left: 41),
                    child: Text('Profile'),
                  )
                  ]
                ),
                
                //  Settings
                Stack(
                children: [
                Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  child: SizedBox(
                    height: 65,
                    width: 65,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => ProfilePage()),
                          );
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.transparent,
                        padding: EdgeInsets.zero,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                        ),
                        elevation: 0,
                      ),
                      child: Container(
                        width: 65,
                        height: 65,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(18.0),
                          gradient: LinearGradient(
                            colors: CardBgPink, // Define your gradient colors
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                        ),
                        child: Icon(
                          FontAwesomeIcons.gear,
                          size: 25,
                          color: Colors.white,
                        ),
                      ),
                    )

                  ),
                ),
                
                Padding(
                  padding: const EdgeInsets.only(top: 70, left: 22),
                  child: Text('Settings'),
                )
                ]
              ),
              
                //  Favorite
                Stack(
                  children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    child: SizedBox(
                      height: 65,
                      width: 65,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => ProfilePage()),
                            );
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.transparent,
                          padding: EdgeInsets.zero,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                          ),
                          elevation: 0,
                        ),
                        child: Container(
                          width: 65,
                          height: 65,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(18.0),
                            gradient: LinearGradient(
                              colors: CardBgPink, // Define your gradient colors
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                          ),
                          child: Icon(
                            FontAwesomeIcons.heart,
                            size: 25,
                            color: Colors.white,
                          ),
                        ),
                      )

                    ),
                  ),
                  
                  Padding(
                    padding: const EdgeInsets.only(top: 70, left: 22),
                    child: Text('Favorite'),
                  )
                  ]
                ),
              
                //  Cart
                Stack(
                  children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    child: SizedBox(
                      height: 65,
                      width: 65,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => ProfilePage()),
                            );
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.transparent,
                          padding: EdgeInsets.zero,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                          ),
                          elevation: 0,
                        ),
                        child: Container(
                          width: 65,
                          height: 65,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(18.0),
                            gradient: LinearGradient(
                              colors: CardBgBlue, // Define your gradient colors
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                          ),
                          child: Icon(
                            FontAwesomeIcons.shoppingCart,
                            size: 25,
                            color: Colors.white,
                          ),
                        ),
                      )

                    ),
                  ),
                  
                  Padding(
                    padding: const EdgeInsets.only(top: 70, left: 22),
                    child: Text('Favorite'),
                  )
                  ]
                ),
              ],
            ),
          ],
        ),
      ),
      
    ]);
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
    return Stack(
      children: [
        const Align(
          alignment: Alignment.centerLeft, // Adjust alignment as needed
          child: Padding(
            padding: const EdgeInsets.only(top: 10, left: 30),
            child: Text(
              'Adverts',
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
            // First row
            SizedBox(height: 40,),
            Row(
              children: [
                //  Add advert
                Stack(
                  children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 30, right: 15),
                    child: SizedBox(
                      height: 65,
                      width: 65,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => AddAdvert()),
                            );
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.transparent,
                          padding: EdgeInsets.zero,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                          ),
                          elevation: 0,
                        ),
                        child: Container(
                          width: 65,
                          height: 65,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(18.0),
                            gradient: LinearGradient(
                              colors: CardBgYellow, // Define your gradient colors
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                          ),
                          child: Icon(
                            FontAwesomeIcons.plus,
                            size: 25,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 70, left: 28),
                    child: Text('Add advert'),
                  )
                  ]
                ),
                
                //  Your addverts
                Stack(
                  children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 30, right: 15),
                    child: SizedBox(
                      height: 65,
                      width: 65,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => ProfilePage()),
                            );
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.transparent,
                          padding: EdgeInsets.zero,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                          ),
                          elevation: 0,
                        ),
                        child: Container(
                          width: 65,
                          height: 65,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(18.0),
                            gradient: LinearGradient(
                              colors: CardBgYellow, // Define your gradient colors
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                          ),
                          child: Icon(
                            FontAwesomeIcons.layerGroup,
                            size: 25,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 70, left: 28),
                    child: Text('Your adverts'),
                  )
                  ]
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
            color: NavigationBarSel,
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
    return Stack(
      children: [
        const Align(
          alignment: Alignment.centerLeft, // Adjust alignment as needed
          child: Padding(
            padding: const EdgeInsets.only(top: 10, left: 30),
            child: Text(
              'Log out',
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
            // First row
            SizedBox(height: 40,),
            Row(
              children: [
                //  Add advert
                Stack(
                  children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 30, right: 15),
                    child: SizedBox(
                      height: 65,
                      width: 65,
                      child: ElevatedButton(
                        onPressed: () {
                          signOutUser();
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.transparent,
                          padding: EdgeInsets.zero,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                          ),
                          elevation: 0,
                        ),
                        child: Container(
                          width: 65,
                          height: 65,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(18.0),
                            gradient: LinearGradient(
                              colors: CardBgBlack, // Define your gradient colors
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                          ),
                          child: Icon(
                            FontAwesomeIcons.rightFromBracket,
                            size: 25,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 70, left: 38),
                    child: Text('Log out'),
                  )
                  ]
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