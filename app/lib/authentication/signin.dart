import 'dart:convert';
import 'package:app/functions/button.dart';
import 'package:flutter/material.dart';
import 'package:app/colors.dart';
import 'package:get/get.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:app/model/user_preferences.dart';
import 'package:app/api/api_connection.dart';
import 'package:http/http.dart' as http;
import 'package:app/model/user.dart';
import 'package:app/authentication/signup.dart';
import 'package:app/fragments/dashboard_of_fragmens.dart';
import 'package:app/functions/input_box.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  SignInUserNow() async{
    try{
      var res = await http.post(
      Uri.parse(API.signIn),
      body: {
        'email': emailController.text.trim(),
        'password': passwordController.text.trim()
      },
    );
    if(res.statusCode == 200){
        var resBodyOfSignIn = jsonDecode(res.body);
        if(resBodyOfSignIn['success'] == true){
          Fluttertoast.showToast(
            msg: "Sign in Successfully",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            textColor: Colors.white,
            fontSize: 16.0
          );
          print('Sign in Successfully');

          User userInfo = User.fromJson(resBodyOfSignIn["userData"]);

          //  Save userInfo to local Storage using Shared Preferences
          await RememberUserPrefs.saveUserData(userInfo);

          Get.to(DashboardOfFragments());
        }
        else{
          Fluttertoast.showToast(
            msg: "Please write correct password or email. Try again",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            textColor: Colors.white,
            fontSize: 16.0
          );
          print('Please write correct password or email, Try again');
        }
      }
    }
    catch(errorMsg){
      print('Error :: ' + errorMsg.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white ,
      body: LayoutBuilder(
        builder: (context, cons) {
          return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [

                  SizedBox(height: 10,),
                  Text('Log in',style: TextStyle(
                    color: Colors.black,
                    fontSize: 30,
                    fontWeight: FontWeight.w500
                    ),
                  ),
                  SizedBox(height: 20,),
                  Container(
                    child: Column(
                      children: [
                        Form(
                          key: formKey,
                          child: Column(
                            children: [
                              //  Email
                              InputTextBox(FontAwesomeIcons.envelope, "Email", emailController, true, Color.fromRGBO(191, 191, 191, 1.0)),
                              InputTextBox(FontAwesomeIcons.key, "Password", passwordController, true, Color.fromRGBO(191, 191, 191, 1.0)),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 30,),
                  Material(
                    color: mainColor,
                    borderRadius: BorderRadius.circular(30),
                    child: GestureDetector(
                      onTap: () {
                        if (formKey.currentState!.validate()) {
                          // Perform the login action (e.g., SignInUserNow()) here
                          SignInUserNow();

                          // Navigate to a new screen when the login is successful
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) {
                                // Replace `YourNewScreen()` with the widget for the new screen
                                return DashboardOfFragments();
                              },
                            ),
                          );
                        }
                      },
                      child: Ink(
                        decoration: BoxDecoration(
                          color: mainColor,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 70),
                          child: Text(
                            "Log in",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("I don't have an Account? "),
                      TextButton(
                        onPressed: () async {
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SignUp(),
                            ),
                          );
                        },
                        child: Text("Register", style: TextStyle(
                            color: mainColor
                        ),),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        );
        },
      ),
    );
  }
}
