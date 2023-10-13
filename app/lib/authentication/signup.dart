import 'dart:convert';
import 'package:app/authentication/signin.dart';
import 'package:app/functions/input_box.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:fluttertoast/fluttertoast.dart';


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
          Fluttertoast.showToast(
            msg: "Email is already exist. Try another one.",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            textColor: Colors.white,
            fontSize: 16.0
          );
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
          Fluttertoast.showToast(
            msg: "Sign up Successfully",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            textColor: Colors.white,
            fontSize: 16.0
          );
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
          Fluttertoast.showToast(
            msg: "Error, Try again",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            textColor: Colors.white,
            fontSize: 16.0
          );
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
      backgroundColor: Colors.white,
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
                    Text('Register',style: TextStyle(
                        color: Colors.black,
                        fontSize: 30,
                        fontWeight: FontWeight.w500
                    ),
                    ),
                    SizedBox(height: 10,),
                    Container(
                      child: Column(
                        children: [
                          Form(
                            key: formKey,
                            child: Column(
                              children: [
                                //  Email
                                InputTextBox(FontAwesomeIcons.user, "First name", firstNameController, true, Color.fromRGBO(191, 191, 191, 1.0)),
                                InputTextBox(FontAwesomeIcons.user, "Last name", lastNameController, true, Color.fromRGBO(191, 191, 191, 1.0)),
                                InputTextBox(FontAwesomeIcons.phone, "Phone", phoneController, true, Color.fromRGBO(191, 191, 191, 1.0)),
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
                      child: InkWell(
                        onTap: (){
                          if(formKey.currentState!.validate()){
                            validateUserEmail();
                          }
                        },
                        borderRadius: BorderRadius.circular(30),
                        child: const Padding(
                          padding: EdgeInsets.symmetric(vertical: 15, horizontal: 60),
                          child: Text("Register", style: TextStyle(
                              color: Colors.white,
                              fontSize: 16
                          ),),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("I have an Account? "),
                        TextButton(
                          onPressed: () async {
                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SignIn(),
                              ),
                            );
                          },
                          child: Text("Log in", style: TextStyle(
                              color: mainColor
                          ),),
                        ),
                      ],
                    ),

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