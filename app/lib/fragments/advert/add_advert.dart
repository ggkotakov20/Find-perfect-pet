import 'dart:convert';
import 'dart:ffi';
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
  ValueNotifier<String?> categoryNotifier = ValueNotifier<String?>(''); // Initialize with your default value


  String categoryChoose = 'buy';
  List categoryItem = [
    'buy', 'breeding', 'accessories', 'food' 
  ];

  addAndSaveAdvertRecord() async {
    Advert advertModel = Advert(
      1,
      _currentUser.user.id,
      titleController.text.trim(),
      categoryNotifier.value?.trim() ?? 'buy',
      priceController.text.trim(),
      descriptionController.text.trim(),
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
            msg: "Add advert Successfully",
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
                    Text('Add advert',style: TextStyle(
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
                                      hintText: "Title",
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
                                          hint: Text('Select category: '),
                                          isExpanded: true,
                                          underline: SizedBox(),
                                          dropdownColor: CardBG,
                                          value: categoryChoose,
                                          onChanged: (String? newValue) {
                                            setState(() {
                                              categoryChoose = newValue ?? 'buy'; // Use 'buy' or any default value if newValue is null
                                            });
                                          },
                                          items: const [
                                            DropdownMenuItem(
                                              value: 'buy',
                                              child: Text('buy'),
                                            ),
                                            DropdownMenuItem(
                                              value: 'breeding',
                                              child: Text('breeding'),
                                            ),
                                            DropdownMenuItem(
                                              value: 'accessories',
                                              child: Text('accessories'),
                                            ),
                                            DropdownMenuItem(
                                              value: 'food',
                                              child: Text('food'),
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
                                      hintText: "Price",
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
                                      hintText: "Description",
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
                        child: const Padding(
                          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 28),
                          child: Text("Add advert", style: TextStyle(
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