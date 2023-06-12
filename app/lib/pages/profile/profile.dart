import 'package:app/main.dart';
import 'package:flutter/material.dart';
import 'package:app/colors.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:app/main.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          UserInformation(),
          SizedBox(height: 30),
          Center(
            child: Options(),
          )
        ],
      ),
    );
  }
}

class UserInformation extends StatefulWidget {
  const UserInformation({super.key});

  @override
  State<UserInformation> createState() => _UserInformationState();
}

class _UserInformationState extends State<UserInformation> {
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
              'Georgi Kotakov',
              style: TextStyle(
                  fontSize: 22, color: BLACK, fontWeight: FontWeight.w500),
            ),
            Text(
              'ggkotakov20@codingburgas.bg',
              style: TextStyle(fontSize: 16, color: GREY),
            ),
            SizedBox(height: 10),
            TextButton(
              onPressed: changeScreenValue,
              style: TextButton.styleFrom(
                backgroundColor: GREEN,
                fixedSize: Size(200, 45),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: Text(
                'Edit Profile',
                style: TextStyle(color: DGREEN, fontWeight: FontWeight.w500),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class Options extends StatelessWidget {
  const Options({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 30, left: 30),
      child: Container(
        margin: EdgeInsets.all(10.0),
        child: Column(
          children: [
            //  Settings
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: GREEN,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Icon(
                        FontAwesomeIcons.gear,
                        color: DGREEN,
                        size: 20,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 20),
                    child: Text(
                      'Settings',
                      style: TextStyle(
                        color: BLACK,
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Icon(
                        FontAwesomeIcons.chevronRight,
                        color: GREY,
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Logout
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: BROWN,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Icon(
                        FontAwesomeIcons.arrowRightFromBracket,
                        color: ORGANGE,
                        size: 20,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 20),
                    child: Text(
                      'Logout',
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
