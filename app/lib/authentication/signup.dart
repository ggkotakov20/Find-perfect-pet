import 'dart:convert';
import 'package:app/authentication/signin.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import 'package:app/api/api_connection.dart';
import 'package:app/colors.dart';
import 'package:http/http.dart' as http;
import 'package:app/model/user.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  var formKey = GlobalKey<FormState>();
  var firstNameController = TextEditingController();
  var lastNameController = TextEditingController();
  var phoneController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  validateUserEmail() async {
    try{
      var res = await http.post(
        Uri.parse(API.validateEmail),
        body: {
          'email': emailController.text.trim(),
        },
      );
      if(res.statusCode == 200){ // checks if it was successful to connect to the server
        var resBoyOfCalidateEmail = jsonDecode(res.body);
        if(resBoyOfCalidateEmail['emailFound']){
          // Fluttertoast.showToast(
          //   msg: "Email is already exist. Try another one.",
          //   toastLength: Toast.LENGTH_SHORT,
          //   gravity: ToastGravity.CENTER,
          //   timeInSecForIosWeb: 1,
          //   textColor: Colors.white,
          //   fontSize: 16.0
          // );
          print('Email is already exist. Try another one.');
        }
        else{
          registerAndSaveUserRecord();
        }
      }
    }
    catch(e){

    }
  }

  registerAndSaveUserRecord() async {
    User userModel = User(
      1,
      firstNameController.text.trim(),
      lastNameController.text.trim(),
      phoneController.text.trim(),
      emailController.text.trim(),
      passwordController.text.trim(),
    );

    try{
      var res = await http.post(
        Uri.parse(API.signUp),
        body: userModel.toJson(),
      );

      if(res.statusCode == 200){
        var resBodyOfSignUp = jsonDecode(res.body);
        if(resBodyOfSignUp['success'] == true){
          // Fluttertoast.showToast(
          //   msg: "Sign up Successfully",
          //   toastLength: Toast.LENGTH_SHORT,
          //   gravity: ToastGravity.CENTER,
          //   timeInSecForIosWeb: 1,
          //   textColor: Colors.white,
          //   fontSize: 16.0
          // );
          print('Sign up Successfully');
          setState(() {
            firstNameController.clear();
            lastNameController.clear();
            phoneController.clear();
            emailController.clear();
            passwordController.clear();
          });
        }
        else{
          // Fluttertoast.showToast(
          //   msg: "Error, Try again",
          //   toastLength: Toast.LENGTH_SHORT,
          //   gravity: ToastGravity.CENTER,
          //   timeInSecForIosWeb: 1,
          //   textColor: Colors.white,
          //   fontSize: 16.0
          // );
          print('Error, Try again');
        }
      }
    }
    catch(e){
      print(e.toString());
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
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 10,),
                    Text('Sign up',style: TextStyle(
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
                                //  FIRST NAME

                                SizedBox(height: 20,),
                                Padding(
                                  padding: const EdgeInsets.only(left: 15, right: 15),
                                  child: TextFormField(
                                    controller: firstNameController,
                                    validator: (val) => val == "" ? "Please write first name" : null,
                                    decoration: InputDecoration(
                                      prefixIcon: Icon(
                                        FontAwesomeIcons.user,
                                        color: GREEN,
                                        size: 19,
                                      ),
                                      hintText: "First name",
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

                                // LAST NAME

                                SizedBox(height: 10,),
                                Padding(
                                  padding: const EdgeInsets.only(left: 15, right: 15),
                                  child: TextFormField(
                                    controller: lastNameController,
                                    validator: (val) => val == "" ? "Please write last name" : null,
                                    decoration: InputDecoration(
                                      prefixIcon: Icon(
                                        FontAwesomeIcons.user,
                                        color: GREEN,
                                        size: 19,
                                      ),
                                      hintText: "Last name",
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
                              
                                //  PHONE

                                SizedBox(height: 10,),
                                Padding(
                                  padding: const EdgeInsets.only(left: 15, right: 15),
                                  child: TextFormField(
                                    controller: phoneController,
                                    validator: (val) => val == "" ? "Please write phone" : null,
                                    decoration: InputDecoration(
                                      prefixIcon: Icon(
                                        FontAwesomeIcons.phone,
                                        color: GREEN,
                                        size: 19,
                                      ),
                                      hintText: "Phone",
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
                            validateUserEmail();
                          }
                        },
                        borderRadius: BorderRadius.circular(30),
                        child: const Padding(
                          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 28),
                          child: Text("Sing up", style: TextStyle(
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
                            Get.to(SignIn());
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