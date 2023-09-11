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

class AddAdvert extends StatefulWidget {
  const AddAdvert({super.key});

  @override
  State<AddAdvert> createState() => _AddAdvertState();
}

class _AddAdvertState extends State<AddAdvert> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        centerTitle: true,
        foregroundColor: NavigationBarSel,
        backgroundColor: background,
        elevation: 0.0,
        toolbarHeight: 80,
        leading: IconButton(
          icon: Icon(
            FontAwesomeIcons.chevronLeft,
            size: 18,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Image(
              image: AssetImage('images/logo.png'),
              height: 65,
            ),
          ],
        ),
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
  ValueNotifier<String?> typeNotifier = ValueNotifier<String?>(null); // Remove the default value

  addAndSaveAdvertRecord() async {
    final AppLocalizations appLocalizations = AppLocalizations.of(context);
    
    Advert advertModel = Advert(
      1,
      _currentUser.user.id,
      titleController.text.trim(),
      categoryNotifier.value ?? 'default_category',
      typeNotifier.value ?? 'default_type', // Use categoryNotifier.value
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
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 10,),
                    Text('${appLocalizations.general_add} ${appLocalizations.general_advert.toLowerCase()}',style: TextStyle(
                      color: NavigationBarSel,
                      fontSize: 30,
                      fontWeight: FontWeight.w500
                      ),
                    ),
                    Container(
                      child: Column(
                        children: [
                          Form(
                            key: formKey,
                            child: Column(
                              children: [
                                //  TITLE
                                SizedBox(height: 20,),
                                Padding(
                                  padding: const EdgeInsets.only(left: 15, right: 15),
                                  child: TextFormField(
                                    controller: titleController,
                                    validator: (val) => val == "" ? "Please write a title" : null,
                                    decoration: InputDecoration(
                                      hintText: appLocalizations.general_title,
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30),
                                        borderSide:  BorderSide(
                                          color: CardBG,
                                        ),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30),
                                        borderSide: BorderSide(
                                          color: CardBG,
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30),
                                        borderSide:  BorderSide(
                                          color: CardBG,
                                        ),
                                      ),
                                      disabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30),
                                        borderSide:  BorderSide(
                                          color: CardBG,
                                        ),
                                      ),
                                      contentPadding: const EdgeInsets.symmetric(horizontal: 14,vertical: 6,),
                                      fillColor: CardBG,
                                      filled: true
                                  ),
                                  ),
                                ),
                                
                                //  Type
                                SizedBox(height: 10,),
                                Padding(
                                  padding: const EdgeInsets.only(left: 15, right: 15),
                                  child: Container(
                                    padding: const EdgeInsets.only(left: 15, right: 15),
                                    decoration: BoxDecoration(
                                      border: Border.all(color: CardBG, width: 1),
                                      borderRadius: BorderRadius.circular(30),
                                      color: CardBG,
                                    ),
                                    child: ValueListenableBuilder<String?>(
                                      valueListenable: typeNotifier,
                                      builder: (context, selectedValue, child) {
                                        return DropdownButton<String>(
                                          hint: Text(appLocalizations.general_type),
                                          isExpanded: true,
                                          underline: SizedBox(),
                                          dropdownColor: CardBG,
                                          value: typeNotifier.value, // Use categoryNotifier.value as the selected value
                                          onChanged: (String? newValue) {
                                            typeNotifier.value = newValue; // Update the categoryNotifier value
                                          },
                                          items: const [
                                            DropdownMenuItem(
                                              value: 'dog',
                                              child: Text('Dog'),
                                            ),
                                            DropdownMenuItem(
                                              value: 'cat',
                                              child: Text('Cat'),
                                            ),
                                          ],
                                        );
                                      },
                                    ),
                                  ),
                                ),

                                //  Category
                                SizedBox(height: 10,),
                                Padding(
                                  padding: const EdgeInsets.only(left: 15, right: 15),
                                  child: Container(
                                    padding: const EdgeInsets.only(left: 15, right: 15),
                                    decoration: BoxDecoration(
                                      border: Border.all(color: CardBG, width: 1),
                                      borderRadius: BorderRadius.circular(30),
                                      color: CardBG,
                                    ),
                                    child: ValueListenableBuilder<String?>(
                                      valueListenable: categoryNotifier,
                                      builder: (context, selectedValue, child) {
                                        return DropdownButton<String>(
                                          hint: Text(appLocalizations.general_category),
                                          isExpanded: true,
                                          underline: SizedBox(),
                                          dropdownColor: CardBG,
                                          value: categoryNotifier.value, // Use categoryNotifier.value as the selected value
                                          onChanged: (String? newValue) {
                                            categoryNotifier.value = newValue; // Update the categoryNotifier value
                                          },
                                          items: const [
                                            DropdownMenuItem(
                                              value: 'buy',
                                              child: Text('Buy'),
                                            ),
                                            DropdownMenuItem(
                                              value: 'breeding',
                                              child: Text('Breeding'),
                                            ),
                                            DropdownMenuItem(
                                              value: 'accessories',
                                              child: Text('Accessories'),
                                            ),
                                            DropdownMenuItem(
                                              value: 'food',
                                              child: Text('Food'),
                                            ),
                                          ],
                                        );
                                      },
                                    ),
                                  ),
                                ),
                               
                                // Price
                                SizedBox(height: 10,),
                                Padding(
                                  padding: const EdgeInsets.only(left: 15, right: 15),
                                  child: TextFormField(
                                    controller: priceController,
                                    validator: (val) => val == "" ? "Please write a price" : null,
                                    keyboardType: TextInputType.number, // Add this line
                                    decoration: InputDecoration(
                                      hintText: appLocalizations.general_price,
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30),
                                        borderSide:  BorderSide(
                                          color: CardBG,
                                        ),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30),
                                        borderSide: BorderSide(
                                          color: CardBG,
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30),
                                        borderSide:  BorderSide(
                                          color: CardBG,
                                        ),
                                      ),
                                      disabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30),
                                        borderSide:  BorderSide(
                                          color: CardBG,
                                        ),
                                      ),
                                      contentPadding: const EdgeInsets.symmetric(horizontal: 14,vertical: 6,),
                                      fillColor: CardBG,
                                      filled: true
                                    ),
                                  ),
                                ),

                                // Description
                                SizedBox(height: 10,),
                                Padding(
                                  padding: const EdgeInsets.only(left: 15, right: 15),
                                  child: TextFormField(
                                    controller: descriptionController,
                                    validator: (val) => val == "" ? "Please write Description" : null,
                                    decoration: InputDecoration(
                                      hintText: appLocalizations.general_description,
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30),
                                        borderSide:  BorderSide(
                                          color: CardBG,
                                        ),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30),
                                        borderSide: BorderSide(
                                          color: CardBG,
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30),
                                        borderSide:  BorderSide(
                                          color: CardBG,
                                        ),
                                      ),
                                      disabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30),
                                        borderSide:  BorderSide(
                                          color: CardBG,
                                        ),
                                      ),
                                      contentPadding: const EdgeInsets.symmetric(horizontal: 14,vertical: 6,),
                                      fillColor: CardBG,
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
                    
                    // Add advert btn

                    Material(
                      color: NavigationBarSel,
                      borderRadius: BorderRadius.circular(30),
                      child: InkWell(
                        onTap: (){
                          if(formKey.currentState!.validate()){
                            addAndSaveAdvertRecord();
                          }
                        },
                        borderRadius: BorderRadius.circular(30),
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 28),
                          child: Text(appLocalizations.general_add_advert, style: TextStyle(
                            color: Colors.white,
                            fontSize: 16
                          ),),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      );
  }
}