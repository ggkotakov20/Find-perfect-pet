import 'dart:convert';

import 'package:app/api/api_connection.dart';
import 'package:app/l10n/app_localizations.dart';
import 'package:app/model/current_user.dart';
import 'package:app/model/favorite.dart';
import 'package:flutter/material.dart';
import 'package:app/colors.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class AdvertCard extends StatefulWidget {
  final Map<String, dynamic> advert;
  final VoidCallback onTap;
  

  const AdvertCard({
    Key? key,
    required this.advert,
    required this.onTap,
  }) : super(key: key);

  @override
  State<AdvertCard> createState() => _AdvertCardState();
}

class _AdvertCardState extends State<AdvertCard> {
  
  final CurrentUser _currentUser = Get.put(CurrentUser());
  
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
    
    int id = int.parse(widget.advert['id']);
    String title = widget.advert['title'].toString();
    String price = widget.advert['price'].toString();
    String imageUrl = widget.advert['image'][0]['image'].toString();
    
    return Container(
      margin: const EdgeInsets.only(
        top: 20,
        bottom: 0,
      ),
      child: Column(
        children: [
          // Image section
          GestureDetector(
            onTap: widget.onTap,
            child: Container(
              width: 300,
              height: 150,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(imageUrl), // Use NetworkImage for online images
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25.0),
                  topRight: Radius.circular(25.0),
                ),
              ),
            ),
          ),

          // Information section
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Title and price
                Container(
                  width: 191,
                  height: 75,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(25.0),
                    ),
                    color: CardBG,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: 10,
                      left: 25,
                    ),
                    child: Column(
                      children: [
                        Text(
                          title,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 22,
                            overflow: TextOverflow.ellipsis,
                            color: BLACK,
                          ),
                        ),
                        Text(
                          '$price \$',
                          style: TextStyle(
                            fontSize: 17,
                            color: DGREY,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // Shopping and add to favorite buttons
                Container(
                  width: 109,
                  height: 75,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(25.0),
                    ),
                    color: CardBG,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                        onPressed: () {},
                        icon: Icon(
                          FontAwesomeIcons.shoppingBag,
                          size: 20,
                          color: mainColor,
                        ),
                      ),
                      SizedBox(width: 10),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

typedef void OnDeleteConfirmedCallback();

class YourAdvertCard extends StatefulWidget {
  final Map<String, dynamic> advert;
  final VoidCallback onTap;

  YourAdvertCard({
    required this.advert,
    required this.onTap,
  });

  @override
  _YourAdvertCardState createState() => _YourAdvertCardState();
}

class _YourAdvertCardState extends State<YourAdvertCard> {
  bool _isDeleted = false; // Track whether the item is deleted or not

  void deleteAdver(int advert_id) async {
    final AppLocalizations appLocalizations = AppLocalizations.of(context);

    final response = await http.post(
      Uri.parse(API.deleteAdvert),
      body: {
        'advert_id': '${advert_id}',
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonData = json.decode(response.body);

      if (jsonData.containsKey('success')) {
        setState(() {
          _isDeleted = true; // Mark the item as deleted
        });
        Fluttertoast.showToast(
          msg: appLocalizations.general_delete_adver_suucess,
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
    } else {
      throw Exception("Failed to load data: ${response.statusCode}");
    }
  }

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
                Navigator.of(context).pop();
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
                Navigator.of(context).pop('Delete');
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
    ).then((result) {
      if (result == 'Delete') {
        deleteAdver(id);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isDeleted) {
      // Return an empty container if the item is deleted
      return Container();
    }

    int id = int.parse(widget.advert['id']);
    String title = widget.advert['title'].toString();
    String price = widget.advert['price'].toString();
    String imageUrl = widget.advert['image'][0]['image'].toString();

    return Container(
      margin: const EdgeInsets.only(
        top: 20,
        bottom: 0,
      ),
      child: Column(
        children: [
          GestureDetector(
            onTap: widget.onTap,
            child: Container(
              width: 300,
              height: 150,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(imageUrl),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25.0),
                  topRight: Radius.circular(25.0),
                ),
              ),
            ),
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 191,
                  height: 75,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(25.0),
                    ),
                    color: CardBG,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: 10,
                      left: 25,
                    ),
                    child: Column(
                      children: [
                        Text(
                          title,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 22,
                            overflow: TextOverflow.ellipsis,
                            color: BLACK,
                          ),
                        ),
                        Text(
                          '$price \$',
                          style: TextStyle(
                            fontSize: 17,
                            color: DGREY,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  width: 109,
                  height: 75,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(25.0),
                    ),
                    color: CardBG,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: Icon(
                          FontAwesomeIcons.edit,
                          size: 20,
                          color: mainColor,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          _showDeleteConfirmationDialog(context, id);
                        },
                        icon: Icon(
                          FontAwesomeIcons.trash,
                          size: 20,
                          color: Color.fromRGBO(247, 75, 75, 1),
                        ),
                      ),
                      SizedBox(width: 10),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

