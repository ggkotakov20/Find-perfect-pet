import 'package:app/authentication/signin.dart';
import 'package:app/model/current_user.dart';
import 'package:app/model/user_preferences.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:app/colors.dart';
import 'package:get/get.dart';
import 'package:app/functions/option_buttons.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {;
    return Stack(
      children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              UserInformation(),
              SizedBox(height: 30),
              Center(
                child: Options(),
              )
            ],
        ),
      ]
    );
  }
}

class UserInformation extends StatefulWidget {
  const UserInformation({super.key});

  @override
  State<UserInformation> createState() => _UserInformationState();
}

class _UserInformationState extends State<UserInformation> {
  final CurrentUser _currentUser = Get.put(CurrentUser());

  void changeScreenValue() {}

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(100.0), //add border radius
              child: Image.asset(
                "images/user_img.jpeg",
                height: 150.0,
                width: 150.0,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 10),
            Text(
              _currentUser.user.first_name + ' ' + _currentUser.user.last_name,
              style: TextStyle(
                  fontSize: 22, color: BLACK, fontWeight: FontWeight.w500),
            ),
            Text(
              _currentUser.user.email,
              style: TextStyle(fontSize: 16, color: GREY),
            )
          ],
        ),
      ),
    );
  }
}

class Options extends StatelessWidget {
  const Options({super.key});

  signOutUser() async {
    var resulResponse = await Get.dialog(AlertDialog(
      backgroundColor: Colors.white,
      title: Text(
        'Sign out',
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
      content: Text('Are you sure\nyou wan to sign out from app?'),
      actions: [
        TextButton(
          onPressed: () {
            Get.back();
          },
          child: Text('No', style: TextStyle(
            color: GREEN,
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
    return Padding(
      padding: const EdgeInsets.only(right: 30, left: 30),
      child: Container(
        margin: EdgeInsets.all(10.0),
        child: Column(
          children: [
            ProfileOptions(
              text: "Edit your profile information",
              icon: FontAwesomeIcons.user,
              onPressed: () {print("this btn was pressed");}
            ),

            ProfileOptions(
              text: "Pet information",
              icon: FontAwesomeIcons.paw,
              onPressed: () {print("this btn was pressed");}
            ),

            ProfileOptions(
              text: "Settings",
              icon: FontAwesomeIcons.gear,
              onPressed: () {print("this btn was pressed");}
            ),

            ProfileOptions(
              text: "About",
              icon: FontAwesomeIcons.circleInfo,
              onPressed: () {print("this btn was pressed");}
            ),

            ProfileOptions(
              text: "Log out",
              icon: FontAwesomeIcons.powerOff,
              onPressed: () { signOutUser(); }
            ),
          ],
        ),
      ),
    );
  }
}
