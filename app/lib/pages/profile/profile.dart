import 'package:flutter/material.dart';
import 'package:app/authentication/signin.dart';
import 'package:app/authentication/signup.dart';


int currentIndex = 0;

final screen = [
  SignIn(),
  SignUp()
];


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
          screen[currentIndex],
          SizedBox(height: 30),
        ],
      ),
    );
  }
}