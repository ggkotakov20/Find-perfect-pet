import 'package:app/l10n/app_localizations.dart';
import 'package:app/model/favorite.dart';
import 'package:flutter/material.dart';
import 'package:app/colors.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:app/model/advert.dart';

import 'package:app/model/current_user.dart';
import 'package:get/get.dart';

import 'package:http/http.dart' as http;
import 'package:app/api/api_connection.dart';
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';


class YourAdvertPage extends StatefulWidget {
  final Map<String, dynamic> advert;

  YourAdvertPage({
    Key? key,
    required this.advert,
  }) : super(key: key);

  @override
  _YourAdvertPageState createState() => _YourAdvertPageState();
}

class _YourAdvertPageState extends State<YourAdvertPage> {
  bool isEditing = false;

  final CurrentUser _currentUser = Get.put(CurrentUser());
  var formKey = GlobalKey<FormState>();
  TextEditingController titleController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    titleController.text = widget.advert['title'];
    priceController.text = widget.advert['price'];
    descriptionController.text = widget.advert['description'];
  }

  bool _isDeleted = false; // Track whether the item is deleted or not
  void _showDeleteConfirmationDialog(BuildContext context, int id) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context);
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Text(
            'Delete advert',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          content: Text(appLocalizations.general_warning_advert_delete),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text(
                appLocalizations.general_no,
                style: TextStyle(
                  color: mainColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                deleteAdver(id).then((success) {
                  if (success) {
                    Navigator.of(context).pop(); // Close the dialog
                    Navigator.of(context).pop(); // Go back
                  }
                });
              },
              child: Text(
                appLocalizations.general_yes,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
  Future<bool> deleteAdver(int advert_id) async {
  final AppLocalizations appLocalizations = AppLocalizations.of(context);
  try {
    final response = await http.post(
      Uri.parse(API.deleteAdvert),
      body: {
        'advert_id': '${advert_id}', // Replace with the actual user_id from your app
      },
    );

    if (response.statusCode == 200) {
      // Parse the JSON response
      final Map<String, dynamic> jsonData = json.decode(response.body);

      if (jsonData.containsKey('success')) {
        Fluttertoast.showToast(
          msg: appLocalizations.general_delete_adver_suucess,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          textColor: Colors.white,
          fontSize: 16.0,
        );
        return true;
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
    } else {
      throw Exception("Failed to load data: ${response.statusCode}");
    }
  } catch (e) {
    print("Error: $e");
  }
  return false; // Return false if the deletion was not successful
}


  editAdvert(int advertId, String title, String category, String type, String price, String description, String imageUrl) async {
    final AppLocalizations appLocalizations = AppLocalizations.of(context);
    Advert advertModel = Advert(
      advertId,
      _currentUser.user.id,
      title,
      category,
      type, // Use categoryNotifier.value
      price,
      description,
      imageUrl,
    );

    try {
      var res = await http.post(
        Uri.parse(API.editAdvert),
        body: advertModel.toJson(),
      );

      if (res.statusCode == 200) {
        var contentType = res.headers['content-type'];
        if (contentType != null && contentType.contains('application/json')) {
          var resBodyOfAddAdvert = jsonDecode(res.body);
          if (resBodyOfAddAdvert['success'] == true) {
            Fluttertoast.showToast(
              msg: appLocalizations.general_edit_adver_suucess,
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              textColor: Colors.white,
              fontSize: 16.0,
            );
            print('Edit advert Successfully');
            setState(() {
              titleController.clear();
              priceController.clear();
              descriptionController.clear();
              isEditing = false; // Disable editing mode after saving changes
            });
          } else {
            Fluttertoast.showToast(
              msg: appLocalizations.general_error,
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              textColor: Colors.white,
              fontSize: 16.0,
            );
            print('Error, Try again');
          }
        } else {
          // Handle the case where the response is not JSON
          print('Received non-JSON response: ${res.body}');
        }
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    String imageUrl = widget.advert['image'][0]['image'].toString();
    final AppLocalizations appLocalizations = AppLocalizations.of(context);

    return Scaffold(
      body: GestureDetector(
        onHorizontalDragEnd: (DragEndDetails details) {
          if (details.primaryVelocity! < 0) {
            // Swiped left, navigate back
            Navigator.pop(context);
          }
        },
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Container(
                    height: 250,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(imageUrl),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 10,
                    left: 10,
                    child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        FontAwesomeIcons.chevronLeft,
                        size: 20,
                        color: mainColor,
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0, top: 10),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            widget.advert['date_created'] != null
                                ? (_isToday(DateTime.parse(widget.advert['date_created']))
                                    ? '${appLocalizations.general_added} ${appLocalizations.general_today.toLowerCase()}'
                                    : "${appLocalizations.general_added} ${DateFormat('dd MMMM yyyy').format(DateTime.parse(widget.advert['date_created']))}")
                                : appLocalizations.general_no_data,
                          ),
                          Row(
                            children: [
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    isEditing = !isEditing;
                                  });
                                },
                                icon: Icon(
                                  FontAwesomeIcons.edit,
                                  size: 20,
                                  color: mainColor,
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  _showDeleteConfirmationDialog(context, int.parse(widget.advert['id']));
                                },
                                icon: Icon(
                                  FontAwesomeIcons.trash,
                                  size: 20,
                                  color: Color.fromRGBO(247, 75, 75, 1),
                                ),
                              ),
                              SizedBox(width: 10)
                            ],
                          ),
                        ],
                      ),
                      Visibility(
                        visible: !isEditing,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.advert['title'],
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 26,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                            SizedBox(height: 20),
                            Text(
                              '${widget.advert['price']} \$',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 24,
                                color: mainColor,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 20),
                              child: Text(
                                '${appLocalizations.general_description} :',
                                style: TextStyle(
                                  fontSize: 22,
                                ),
                              ),
                            ),
                            Text(
                              widget.advert['description'],
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Visibility(
                        visible: isEditing,
                        child: Column(
                          children: [
                            SizedBox(height: 15),
                            Text(appLocalizations.general_title),
                            SizedBox(height: 5),
                            Padding(
                              padding: const EdgeInsets.only(left: 7, right: 15),
                              child: TextFormField(
                                controller: titleController, // Use controller instead of initialValue
                                decoration: InputDecoration(
                                  hintText: appLocalizations.general_title,
                                  hintStyle: TextStyle(
                                    color: Colors.black,
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide: BorderSide(
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
                                    borderSide: BorderSide(
                                      color: CardBG,
                                    ),
                                  ),
                                  disabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide: BorderSide(
                                      color: CardBG,
                                    ),
                                  ),
                                  contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                                  fillColor: CardBG,
                                  filled: true,
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter a title';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            SizedBox(height: 15),
                            Text(appLocalizations.general_price),
                            SizedBox(height: 5),
                            Padding(
                              padding: const EdgeInsets.only(left: 7, right: 15),
                              child: TextFormField(
                                controller: priceController, // Use controller instead of initialValue
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  hintText: appLocalizations.general_price,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide: BorderSide(
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
                                    borderSide: BorderSide(
                                      color: CardBG,
                                    ),
                                  ),
                                  disabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide: BorderSide(
                                      color: CardBG,
                                    ),
                                  ),
                                  contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                                  fillColor: CardBG,
                                  filled: true,
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter a price';
                                  }
                                  // You can add more validation rules here if needed
                                  return null;
                                },
                              ),
                            ),
                            SizedBox(height: 15),
                            Text(appLocalizations.general_description),
                            SizedBox(height: 5),
                            Padding(
                              padding: const EdgeInsets.only(left: 7, right: 15),
                              child: TextFormField(
                                controller: descriptionController, // Use controller instead of initialValue
                                decoration: InputDecoration(
                                  hintText: appLocalizations.general_description,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide: BorderSide(
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
                                    borderSide: BorderSide(
                                      color: CardBG,
                                    ),
                                  ),
                                  disabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide: BorderSide(
                                      color: CardBG,
                                    ),
                                  ),
                                  contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                                  fillColor: CardBG,
                                  filled: true,
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter a description';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            SizedBox(height: 15),
                            Material(
                              color: mainColor,
                              borderRadius: BorderRadius.circular(30),
                              child: InkWell(
                                onTap: () {
                                  editAdvert(
                                    int.parse(widget.advert['id']),
                                    titleController.text,
                                    widget.advert['category'],
                                    widget.advert['type'],
                                    priceController.text,
                                    descriptionController.text,
                                    widget.advert['imageUrl'] ?? "https://developers.google.com/static/maps/documentation/maps-static/images/error-image-generic.png",
                                  );
                                },
                                borderRadius: BorderRadius.circular(30),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                    vertical: 10,
                                    horizontal: 28,
                                  ),
                                  child: Text(
                                    appLocalizations.general_save_changes,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool _isToday(DateTime dateTime) {
    final now = DateTime.now();
    return dateTime.year == now.year &&
        dateTime.month == now.month &&
        dateTime.day == now.day;
  }
}

class AdvertPage extends StatefulWidget {
  final Map<String, dynamic> advert;

  AdvertPage({
    Key? key,
    required this.advert,
  }) : super(key: key);

  @override
  _AdvertPageState createState() => _AdvertPageState();
}

class _AdvertPageState extends State<AdvertPage> {
  
  final CurrentUser _currentUser = Get.put(CurrentUser());
  var formKey = GlobalKey<FormState>();
  TextEditingController titleController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    titleController.text = widget.advert['title'];
    priceController.text = widget.advert['price'];
    descriptionController.text = widget.advert['description'];
  }

  editAdvert(int advertId, String title, String category, String type, String price, String description, String imageUrl) async {
    final AppLocalizations appLocalizations = AppLocalizations.of(context);
    Advert advertModel = Advert(
          advertId,
          _currentUser.user.id,
          title,
          category,
          type, // Use categoryNotifier.value
          price,
          description,
          imageUrl
        );

      try{
        var res = await http.post(
          Uri.parse(API.editAdvert),
          body: advertModel.toJson(),
        );

        if (res.statusCode == 200) {
        var contentType = res.headers['content-type'];
        if (contentType != null && contentType.contains('application/json')) {
          var resBodyOfAddAdvert = jsonDecode(res.body);
          if (resBodyOfAddAdvert['success'] == true) {
            Fluttertoast.showToast(
              msg: appLocalizations.general_edit_adver_suucess,
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              textColor: Colors.white,
              fontSize: 16.0
            );
            print('Edit advert Successfully');
            setState(() {
              titleController.clear();
              priceController.clear();
              descriptionController.clear();
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
        } else {
          // Handle the case where the response is not JSON
          print('Received non-JSON response: ${res.body}');
        }
      }
    } catch (e) {
      print('Error: $e');
    }
  }
  addFavorite(int advert_id) async {
    final AppLocalizations appLocalizations = AppLocalizations.of(context);
    
    Favorite advertModel = Favorite(
      _currentUser.user.id,
      advert_id,
      'add'
    );


    try{
      var res = await http.post(
        Uri.parse(API.addFavorite),
        body: advertModel.toJson(),
      );

      if(res.statusCode == 200){
        var resBodyOfAddAdvert = jsonDecode(res.body);
        if(resBodyOfAddAdvert['success'] == true){
          Fluttertoast.showToast(
            msg: appLocalizations.general_add_adver_favorite,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            textColor: Colors.white,
            fontSize: 16.0
          );
          print('Add advert to favorite');
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
  removeFavorite(int advert_id) async {
    final AppLocalizations appLocalizations = AppLocalizations.of(context);
    
    Favorite advertModel = Favorite(
      _currentUser.user.id,
      advert_id,
      'remove'
    );


    try{
      var res = await http.post(
        Uri.parse(API.addFavorite),
        body: advertModel.toJson(),
      );

      if(res.statusCode == 200){
        var resBodyOfAddAdvert = jsonDecode(res.body);
        if(resBodyOfAddAdvert['success'] == true){
          Fluttertoast.showToast(
            msg: appLocalizations.general_remove_adver_favorite,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            textColor: Colors.white,
            fontSize: 16.0
          );
          print('Remove advert to favorite');
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
    String imageUrl = widget.advert['image'][0]['image'].toString();
    final AppLocalizations appLocalizations = AppLocalizations.of(context);
    

    return Scaffold(
      body: GestureDetector(
        onHorizontalDragEnd: (DragEndDetails details) {
          if (details.primaryVelocity! < 0) {
            // Swiped left, navigate back
            Navigator.pop(context);
          }
        },
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Container(
                    height: 250,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(imageUrl),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 10,
                    left: 10,
                    child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        FontAwesomeIcons.chevronLeft,
                        size: 20,
                        color: mainColor,
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0, top: 10),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            widget.advert['date_created'] != null
                                ? (_isToday(
                                    DateTime.parse(widget.advert['date_created']))
                                    ? '${appLocalizations.general_added} ${appLocalizations.general_today.toLowerCase()}'
                                    : "${appLocalizations.general_added} ${DateFormat('dd MMMM yyyy').format(DateTime.parse(widget.advert['date_created']))}")
                                : appLocalizations.general_no_data),
                          Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: Row(
                              children: [
                                widget.advert['favorite'] == '1' ?
                                  IconButton(
                                    onPressed: () {
                                      removeFavorite(int.parse(widget.advert['id']));
                                    },
                                    icon: Icon(
                                      Icons.favorite,
                                      size: 24,
                                      color: Color.fromRGBO(247, 75, 75, 1),
                                    ),
                                  ) : IconButton(
                                    onPressed: () {
                                      addFavorite(int.parse(widget.advert['id']));
                                    },
                                    icon: Icon(
                                      FontAwesomeIcons.heart,
                                      size: 22,
                                      color: Color.fromRGBO(247, 75, 75, 1),
                                    ),
                                  ),
                                IconButton(
                                  onPressed: () {
                                    setState(() {
                                    });
                                  },
                                  icon: Icon(
                                    FontAwesomeIcons.shoppingBag,
                                    size: 22,
                                    color: mainColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.advert['title'],
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 26,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                            SizedBox(height: 20),
                            Text(
                              '${widget.advert['price']} \$',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 24,
                                color: mainColor,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 20),
                              child: Text(
                                '${appLocalizations.general_description} :',
                                style: TextStyle(
                                  fontSize: 22,
                                ),
                              ),
                            ),
                            Text(
                              widget.advert['description'],
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            )
                          ],
                        ),
                      ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool _isToday(DateTime dateTime) {
    final now = DateTime.now();
    return dateTime.year == now.year &&
        dateTime.month == now.month &&
        dateTime.day == now.day;
  }
}
