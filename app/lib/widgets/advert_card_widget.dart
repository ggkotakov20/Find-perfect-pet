import 'package:app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:app/colors.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class AdvertCard extends StatelessWidget {
  final String title;
  final String price;
  final String imageUrl; // Change to a String for the image URL
  final VoidCallback onTap;

  const AdvertCard({
    Key? key,
    required this.title,
    required this.price,
    required this.imageUrl, // Update to accept image URL as a String
    required this.onTap,
  }) : super(key: key);

  
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        top: 20,
        bottom: 0,
      ),
      child: Column(
        children: [
          // Image section
          GestureDetector(
            onTap: onTap,
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
                      IconButton(
                        onPressed: () {},
                        icon: Icon(
                          FontAwesomeIcons.shoppingBag,
                          size: 20,
                          color: NavigationBarSel,
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(
                          FontAwesomeIcons.heart,
                          size: 20,
                          color: Color.fromRGBO(249, 108, 124, 1),
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

class YourAdvertCard extends StatelessWidget {
  final Map<String, dynamic> advert;
  final VoidCallback onTap;

  const YourAdvertCard({
    Key? key,
    required this.advert,
    required this.onTap,
  }) : super(key: key);

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
                color: NavigationBarSel,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop('Delete'); // Close the dialog with a result
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
      print(id); // Perform the deletion operation here
    }
  });
}

  
  @override
  Widget build(BuildContext context) {
    int id = int.parse(advert['id']);
    String title = advert['title'].toString();
    String price = advert['price'].toString();
    String imageUrl = advert['image'][0]['image'].toString();

    return Container(
      margin: const EdgeInsets.only(
        top: 20,
        bottom: 0,
      ),
      child: Column(
        children: [
          // Image section
          GestureDetector(
            onTap: onTap,
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
                      IconButton(
                        onPressed: () {},
                        icon: Icon(
                          FontAwesomeIcons.edit,
                          size: 20,
                          color: NavigationBarSel,
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
