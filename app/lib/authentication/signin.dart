import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:app/colors.dart';
import 'package:get/get.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:app/model/user_preferences.dart';
import 'package:app/api/api_connection.dart';
import 'package:http/http.dart' as http;
import 'package:app/model/user.dart';
import 'package:app/authentication/signup.dart';
import 'package:app/fragments/dashboard_of_fragmens.dart';

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
          print('Sign in Successfully');

          User userInfo = User.fromJson(resBodyOfSignIn["userData"]);

          //  Save userInfo to local Storage using Shared Preferences
          await RememberUserPrefs.saveUserData(userInfo);

          Get.to(DashboardOfFragments());
        }
        else{
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
                  Text('Sign in',style: TextStyle(
                    color: GREEN,
                    fontSize: 30
                    ),
                  ),
                  Container(
                    child: Column(
                      children: [
                        Form(
                          key: formKey,
                          child: Column(
                            children: [
                              //  Email
          
                              SizedBox(height: 10,),
                              Padding(
                                padding: const EdgeInsets.only(left: 15, right: 15),
                                child: TextFormField(
                                  controller: emailController,
                                  validator: (val) => val == "" ? "Please write email" : null,
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(
                                      FontAwesomeIcons.envelope,
                                      color: GREEN,
                                      size: 19,
                                    ),
                                    hintText: "Email",
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30),
                                      borderSide:  BorderSide(
                                        color: GREY,
                                      ),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30),
                                      borderSide: BorderSide(
                                        color: GREY,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30),
                                      borderSide:  BorderSide(
                                        color: GREY,
                                      ),
                                    ),
                                    disabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30),
                                      borderSide:  BorderSide(
                                        color: GREY,
                                      ),
                                    ),
                                    contentPadding: const EdgeInsets.symmetric(horizontal: 14,vertical: 6,),
                                    fillColor: WHITE,
                                    filled: true
                                ),
                                ),
                              ),
          
                              // PASSWORD
          
                              SizedBox(height: 10,),
                              Padding(
                                padding: const EdgeInsets.only(left: 15, right: 15),
                                child: TextFormField(
                                  controller: passwordController,
                                  obscureText: true,
                                  validator: (val) => val == "" ? "Please write password" : null,
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(
                                      FontAwesomeIcons.key,
                                      color: GREEN,
                                      size: 19,
                                    ),
                                    hintText: "Password",
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30),
                                      borderSide:  BorderSide(
                                        color: GREY,
                                      ),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30),
                                      borderSide: BorderSide(
                                        color: GREY,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30),
                                      borderSide:  BorderSide(
                                        color: GREY,
                                      ),
                                    ),
                                    disabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30),
                                      borderSide:  BorderSide(
                                        color: GREY,
                                      ),
                                    ),
                                    contentPadding: const EdgeInsets.symmetric(horizontal: 14,vertical: 6,),
                                    fillColor: WHITE,
                                    filled: true
                                ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 10,),
                  
                  // Sing up btn
          
                  Material(
                    color: GREEN,
                    borderRadius: BorderRadius.circular(30),
                    child: InkWell(
                      onTap: (){
                        if(formKey.currentState!.validate()){
                          SignInUserNow();
                        }
                      },
                      borderRadius: BorderRadius.circular(30),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 28),
                        child: Text("Sing in", style: TextStyle(
                          color: Colors.white,
                          fontSize: 16
                        ),),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Don't have an Account? "),
                      TextButton(
                        onPressed: (){
                          Get.to(SignUp());
                        },
                        child: Text("Sign up Here", style: TextStyle(
                          color: GREEN
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
