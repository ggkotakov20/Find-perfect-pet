import 'dart:convert';
import 'package:app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:app/colors.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:app/model/current_user.dart';
import 'package:get/get.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:app/api/api_connection.dart';
import 'package:http/http.dart' as http;
import 'package:app/model/advert.dart';
import 'package:app/functions/input_box.dart';

class AddAdvert extends StatefulWidget {
  const AddAdvert({super.key});

  @override
  State<AddAdvert> createState() => _AddAdvertState();
}

class _AddAdvertState extends State<AddAdvert> {
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
        title: Padding(
          padding: const EdgeInsets.only(left: 5),
          child: Text(
            'Add advert',
            style: TextStyle(
              color: TextColor,
              fontWeight: FontWeight.w500,
              fontSize: 24
            ),
          ),
        ),
        backgroundColor: Background,
      ),
      body: AddAdvertBody(),
    );
  }
}

class AddAdvertBody extends StatefulWidget {
  const AddAdvertBody({super.key});

  @override
  State<AddAdvertBody> createState() => _AddAdvertBodyState();
}

class _AddAdvertBodyState extends State<AddAdvertBody> {
  final CurrentUser _currentUser = Get.put(CurrentUser());
  
  var formKey = GlobalKey<FormState>();
  var titleController = TextEditingController();
  var priceController = TextEditingController();
  var descriptionController = TextEditingController();
  ValueNotifier<String?> categoryNotifier = ValueNotifier<String?>(null); 
  ValueNotifier<String?> typeNotifier = ValueNotifier<String?>(null);

  List<String> speciesItems = const [
    'Dog',
    'Cat',
    'Fish',
  ];
  List<String> categoryItems = const [
    'Buy',
    'Breeding',
    'Accessories',
    'Food',
  ];

  addAndSaveAdvertRecord() async {
    final AppLocalizations appLocalizations = AppLocalizations.of(context);
    
    Advert advertModel = Advert(
      1,
      _currentUser.user.id,
      titleController.text.trim(),
      categoryNotifier.value ?? 'null',
      typeNotifier.value ?? 'null', // Use categoryNotifier.value
      priceController.text.trim(),
      descriptionController.text.trim(),
      "https://developers.google.com/static/maps/documentation/maps-static/images/error-image-generic.png"
    );


    try{
      var res = await http.post(
        Uri.parse(API.addAdvert),
        body: advertModel.toJson(),
      );

      if(res.statusCode == 200){
        var resBodyOfAddAdvert = jsonDecode(res.body);
        if(resBodyOfAddAdvert['success'] == true){
          Fluttertoast.showToast(
            msg: appLocalizations.general_add_adver_suucess,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            textColor: Colors.white,
            fontSize: 16.0
          );
          print('Add advert Successfully');
          setState(() {
            titleController.clear();
            priceController.clear();
            descriptionController.clear();
            categoryNotifier.value = null;
            typeNotifier.value = null; 
          });
        }
        else{
          Fluttertoast.showToast(
            msg: appLocalizations.general_error,
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
    final AppLocalizations appLocalizations = AppLocalizations.of(context);
    
    return LayoutBuilder(
        builder: (context, cons) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
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
                              SizedBox(height: 20,),
                              InputTextBox(FontAwesomeIcons.pencil, 'Title', titleController, true, TextColor.withOpacity(0.75)),
                              SelectBox(FontAwesomeIcons.codeBranch, 'Type', titleController,speciesItems),
                              SelectBox(FontAwesomeIcons.paw, 'Category', titleController, categoryItems),
                              InputNumberBox(FontAwesomeIcons.moneyBill, 'Price', priceController),
                              InputTextBox(FontAwesomeIcons.paw, 'Description', descriptionController,true, TextColor.withOpacity(0.75),),
                              SizedBox(height: 10,),
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
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      'Add advert',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      );
  }
}