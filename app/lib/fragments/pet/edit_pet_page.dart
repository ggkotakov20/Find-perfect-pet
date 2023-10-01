import 'dart:convert';
import 'package:app/functions/input_box.dart';
import 'package:app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:app/colors.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:app/api/api_connection.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:app/model/user_pet.dart';
import 'package:app/model/current_user.dart';

class EditPetPage extends StatelessWidget {
  final String id;
  final String image;
  final String name;
  final String species;
  final String sex;
  final String breed;
  final String birthdate;
  final String weight;
  final String food;

  final String type;

  final VoidCallback onSave; // Callback to trigger a refresh

  EditPetPage({
    Key? key,
    required this.id,
    required this.image,
    required this.name,
    required this.species,
    required this.sex,
    required this.breed,
    required this.birthdate,
    required this.weight,
    required this.food,
    required this.type,
    required this.onSave, // Add this parameter
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context);

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
          appLocalizations.page_title_edit_pet,
          style: TextStyle(
            color: TextColor,
            fontWeight: FontWeight.w500,
            fontSize: 22,
          ),
        ),
        backgroundColor: Background,
      ),
      body: EditPetPageBody(
        id: id,
        image: image,
        name: name,
        species: species,
        sex: sex,
        breed: breed,
        birthdate: birthdate,
        weight: weight,
        food: food,
        type: type,
        onSave: onSave, // Pass the callback here
      ),
    );
  }
}

class EditPetPageBody extends StatefulWidget {
  final String id;
  final String image;
  final String name;
  final String species;
  final String sex;
  final String breed;
  final String birthdate;
  final String weight;
  final String food;

  final String type;

  final VoidCallback onSave; // Callback to trigger a refresh

  EditPetPageBody({
    Key? key,
    required this.id,
    required this.image,
    required this.name,
    required this.species,
    required this.sex,
    required this.breed,
    required this.birthdate,
    required this.weight,
    required this.food,
    required this.type,
    required this.onSave, // Add this parameter
  }) : super(key: key);

  @override
  State<EditPetPageBody> createState() => _EditPetPageBodyState();
}

class _EditPetPageBodyState extends State<EditPetPageBody> {
  final CurrentUser _currentUser = Get.put(CurrentUser());

  var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var speciesController = TextEditingController();
  var sexController = TextEditingController();
  var breedController = TextEditingController();
  var birthdateController = TextEditingController();
  var weightController = TextEditingController();
  var foodController = TextEditingController();

  List<String> speciesItems = const [
    'Dog',
    'Cat',
    'Fish',
  ];
  List<String> sexItems = const [
    'Male',
    'Female',
  ];
  List<String> foodItems = const [
    'Royal Canin',
    'Other',
  ];

  addAndSavePetRecord() async {
    final AppLocalizations appLocalizations = AppLocalizations.of(context);

    User_Pet petModel = User_Pet(
      int.parse(widget.id),
      _currentUser.user.id,
      nameController.text.trim(),
      speciesController.text.trim(),
      sexController.text.trim(),
      breedController.text.trim(),
      birthdateController.text.trim(),
      weightController.text.trim(),
      foodController.text.trim(),
      "https://developers.google.com/static/maps/documentation/maps-static/images/error-image-generic.png",
    );

    try {
      var res = await http.post(
        Uri.parse(API.editUserPet),
        body: petModel.toJson(),
      );

      if (res.statusCode == 200) {
        var resBodyOfEditPet = jsonDecode(res.body);
        if (resBodyOfEditPet['success'] == true) {
          Fluttertoast.showToast(
            msg: appLocalizations.general_edit_pet_suucess,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            textColor: Colors.white,
            fontSize: 16.0,
          );
        } else {
          Fluttertoast.showToast(
            msg: appLocalizations.general_error,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            textColor: Colors.white,
            fontSize: 16.0,
          );
        }
      }
    } catch (e) {
      print(e.toString());
    }
  }

  
  void initState() {
    super.initState();
    nameController.text = widget.name;
    speciesController.text = widget.species;
    sexController.text = widget.sex;
    breedController.text = widget.breed;
    birthdateController.text = widget.birthdate;
    weightController.text = widget.weight;
    foodController.text = widget.food;
  }

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context);

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
                    widget.image,
                    height: 175.0,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              widget.type == 'Basic' ?
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Container(
                  color: CardBG,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(height: 5),
                        TextBox(FontAwesomeIcons.paw, appLocalizations.pet_page_name, nameController),
                        SelectBox(FontAwesomeIcons.codeBranch, appLocalizations.pet_page_species, speciesController,speciesItems),
                        SelectBox(FontAwesomeIcons.venusMars, appLocalizations.pet_page_gender, sexController, sexItems),
                        TextBox(FontAwesomeIcons.dna, appLocalizations.pet_page_breed, breedController),
                        TextBox(FontAwesomeIcons.cake, appLocalizations.pet_page_birthdate, birthdateController),
                        TextBox(FontAwesomeIcons.weight, appLocalizations.pet_page_weight, weightController),
                        SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ): 
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Container(
                  color: CardBG,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(height: 5),
                        SelectBox(FontAwesomeIcons.bone, appLocalizations.pet_page_food, foodController, foodItems),
                        SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              )
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
              onPressed: () async {
                await addAndSavePetRecord();
                widget.onSave(); // Trigger the callback to refresh PetPage
                Navigator.of(context).pop();
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
