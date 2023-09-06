import 'package:flutter/material.dart';
import 'package:app/colors.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PetCard extends StatelessWidget {
  final String title;
  final String price;
  final String img;
  final VoidCallback onTap;

  const PetCard({
    Key? key,
    required this.title,
    required this.price,
    required this.img,
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
                  image: AssetImage(img),
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
