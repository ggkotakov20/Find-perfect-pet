import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:app/colors.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:app/api/api_connection.dart';
import 'package:http/http.dart' as http;
import 'package:app/model/current_user.dart';
import 'package:get/get.dart';
import 'package:app/model/user_pet.dart';

class EditPetPage extends StatelessWidget {

  final String image;
  final String name;
  final String species;
  final String sex;
  final String breed;
  final String birthdate;
  final String weight;
  final String food;

  EditPetPage({
    Key? key,
    required this.image,
    required this.name,
    required this.species,
    required this.sex,
    required this.breed,
    required this.birthdate,
    required this.weight,
    required this.food,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Background,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0.0,
        toolbarHeight: 80,
        leading: IconButton(
          icon: Icon(
            FontAwesomeIcons.chevronLeft,
            size: 18,
            color: TextColor,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Edit Profile',
          style: TextStyle(
            color: TextColor,
            fontWeight: FontWeight.w500,
            fontSize: 22
          ),
        ),
        backgroundColor: Background,
        
      ),
      body: EditPetPageBody(
        image: image,
        name: name,
        species: species,
        sex: sex,
        breed: breed,
        birthdate: birthdate,
        weight: weight,
        food: food
      ),
    );
  }
}

class EditPetPageBody extends StatelessWidget {
  final String image;
  final String name;
  final String species;
  final String sex;
  final String breed;
  final String birthdate;
  final String weight;
  final String food;

  EditPetPageBody({
    Key? key,
    required this.image,
    required this.name,
    required this.species,
    required this.sex,
    required this.breed,
    required this.birthdate,
    required this.weight,
    required this.food,
  }) : super(key: key);

  var formKey = GlobalKey<FormState>();
  var firstNameController = TextEditingController();
  var lastNameController = TextEditingController();
  var phoneController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  Container InputBox(IconData icon, String titile, String textInside){
    return Container(
      child: Padding(
        padding: const EdgeInsets.only(top: 15.0, left: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: Text(
                titile,
                style: TextStyle(
                  fontSize: 14
                ),
              ),
            ),
            TextFormField(
              controller: firstNameController,
              validator: (val) => val == "" ? "Please write first name" : null,
              decoration: InputDecoration(
                prefixIcon: Icon(
                  icon,
                  color: TextColor.withOpacity(0.75),
                  size: 19,
                ),
                hintText: textInside,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide:  BorderSide(
                    color: Colors.black.withOpacity(0.3),
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color: Colors.black.withOpacity(0.3),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide:  BorderSide(
                    color: Colors.black.withOpacity(0.3),
                  ),
                ),
                disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide:  BorderSide(
                    color: Colors.black.withOpacity(0.3),
                  ),
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 14,vertical: 6,),
                fillColor: CardBG,
                filled: true
              ),
            ),
          ],
        ),
      ),
    );
  }
  Container SelectBox(IconData icon, String titile, String textInside){
    return Container(
      child: Padding(
        padding: const EdgeInsets.only(top: 15.0, left: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: Text(
                titile,
                style: TextStyle(
                  fontSize: 14
                ),
              ),
            ),
            TextFormField(
              controller: firstNameController,
              validator: (val) => val == "" ? "Please write first name" : null,
              decoration: InputDecoration(
                prefixIcon: Icon(
                  icon,
                  color: TextColor.withOpacity(0.75),
                  size: 19,
                ),
                suffixIcon: Icon(
                  FontAwesomeIcons.bars,
                  color: TextColor.withOpacity(0.75),
                  size: 19,
                ),
                hintText: textInside,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide:  BorderSide(
                    color: Colors.black.withOpacity(0.3),
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color: Colors.black.withOpacity(0.3),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide:  BorderSide(
                    color: Colors.black.withOpacity(0.3),
                  ),
                ),
                disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide:  BorderSide(
                    color: Colors.black.withOpacity(0.3),
                  ),
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 14,vertical: 6,),
                fillColor: CardBG,
                filled: true
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  ),
                  child: Image.network(
                    image,
                    height: 175.0,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Container(
                  color: CardBG,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(height: 5),
                        InputBox(FontAwesomeIcons.paw, 'Name', name),
                        SelectBox(FontAwesomeIcons.codeBranch, 'Species', species),
                        SelectBox(FontAwesomeIcons.venusMars, 'Sex', sex),
                        InputBox(FontAwesomeIcons.dna, 'Breed', breed),
                        InputBox(FontAwesomeIcons.cake, 'Birthdate', birthdate),
                        InputBox(FontAwesomeIcons.weight, 'Weight', weight),
                        SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          width: double.infinity,
          height: 75,
          decoration: BoxDecoration(
            color: CardBG,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.4),
                spreadRadius: 2,
                blurRadius: 4,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.only(top: 12, bottom: 12, left: 20, right: 20),
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(mainColor),
                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                )),
              ),
              onPressed: () {
                // Add your save logic here
              },
              child: Text(
                'Save Changes',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}