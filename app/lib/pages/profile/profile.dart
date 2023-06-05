import 'package:flutter/material.dart';
import 'package:app/colors.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
        ],
      ),
    );
  }
}

class UserInformation extends StatelessWidget {
  const UserInformation({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          children: [
            Icon(
              FontAwesomeIcons.circleUser,
              size: 120,
              color: BLACK,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Georgi Kotakov',
              style: TextStyle(
                  fontSize: 22, color: BLACK, fontWeight: FontWeight.w500),
            ),


            Text(
                  'Lacation - Burgas, Bulgaria',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),

                


            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Column(
                  children: [
                  Text(
                  'Pet: ',
                  style: TextStyle(fontSize: 16),
                ),
                Text(
                  'Location: ',
                  style: TextStyle(fontSize: 16),
                ),
                ],)
              ],
            )

          ],
        ),
      ),
    );
  }
}

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
