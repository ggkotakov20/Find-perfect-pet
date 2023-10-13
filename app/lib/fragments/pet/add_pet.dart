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

class AddPetPage extends StatelessWidget {// Callback to trigger a refresh

  AddPetPage({
    Key? key,
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
          appLocalizations.page_title_add_pet,
          style: TextStyle(
            color: TextColor,
            fontWeight: FontWeight.w500,
            fontSize: 22,
          ),
        ),
        backgroundColor: Background,
      ),
      body: AddPetPageBody(),
    );
  }
}

class AddPetPageBody extends StatefulWidget {
  const AddPetPageBody({super.key});

  @override
  State<AddPetPageBody> createState() => _AddPetPageBodyState();
}

class _AddPetPageBodyState extends State<AddPetPageBody> {
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
      1,
      _currentUser.user.id,
      nameController.text.trim(),
      speciesController.text.trim(),
      sexController.text.trim(),
      breedController.text.trim(),
      birthdateController.text.trim(),
      weightController.text.trim(),
      'null',
      "https://developers.google.com/static/maps/documentation/maps-static/images/error-image-generic.png",
    );

    try {
      var res = await http.post(
        Uri.parse(API.addUserPet),
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
                    "https://developers.google.com/static/maps/documentation/maps-static/images/error-image-generic.png",
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
                        InputTextBox(FontAwesomeIcons.paw, appLocalizations.pet_page_name, nameController, true, TextColor.withOpacity(0.75)),
                        SelectBox(FontAwesomeIcons.codeBranch, appLocalizations.pet_page_species, speciesController, speciesItems),
                        SelectBox(FontAwesomeIcons.venusMars, appLocalizations.pet_page_gender, sexController, sexItems),
                        InputTextBox(FontAwesomeIcons.dna, appLocalizations.pet_page_breed, breedController, true, TextColor.withOpacity(0.75)),
                        InputTextBox(FontAwesomeIcons.cake, appLocalizations.pet_page_birthdate, birthdateController, true, TextColor.withOpacity(0.75),),
                        InputTextBox(FontAwesomeIcons.weight, appLocalizations.pet_page_weight, weightController, true, TextColor.withOpacity(0.75),),
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
              onPressed: () {
                addAndSavePetRecord();
                Navigator.of(context).pop();
              },
              child: Text(
                'Add new pet',
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