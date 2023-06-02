import 'package:flutter/material.dart';
import 'package:app/colors.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:app/pages/home/pet.dart';
import 'package:app/data/pet_languages.dart';

import 'package:app/pages/home/home.dart';

String _language = 'us';
class AnimalCards extends StatefulWidget {
  const AnimalCards({super.key});

  @override
  State<AnimalCards> createState() => _AnimalCardsState();
}

class _AnimalCardsState extends State<AnimalCards> {
  @override
  Widget build(BuildContext context) {
    return Stack(
        children:[ Positioned(
              top: 100,
              bottom: 0,
              left: 30,
              right: 30,
              child: AnimalViewer(_language),
            ),
        ]
    );
  }
}

class AnimalViewer extends StatelessWidget {
  final String language;
  AnimalViewer(this.language, {super.key});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    var widthPerCategory = 400;

    print('$width X $height');

    return ListView(
      children: cards.map((cards) {
        return AnimalListItem(language, cards);
      }).toList(),
    );
  }
}

class AnimalListItem extends StatelessWidget {
  final String language;
  final Pet animal;

  const AnimalListItem(this.language, this.animal, {super.key});

  @override
  Widget build(BuildContext context) {
    String Animalprice = animal.price.toString();
    return Container(
      margin: const EdgeInsets.only(
        top: 20,
        bottom: 0,
      ),
      child: Column(
        children: [
          //  Image section
          Container(
            width: 325,
            height: 150,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(animal.image),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25.0),
                  topRight: Radius.circular(25.0)),
            ),
          ),

          // Information section
          Container(
            child: Row(
              children: [
                // Title and price
                Container(
                  margin: const EdgeInsets.only(left: 14),
                  height: 75,
                  width: 216,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(25.0),
                    ),
                    color: Colors.white,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: 10,
                      left: 25,
                    ),
                    child: Column(
                      children: [
                        Text(
                          animal.title[language] != null
                              ? animal.title[language]!
                              : 'Not available',
                          style: const TextStyle(
                            fontSize: 26,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Text(
                          '$Animalprice \$',
                          style: const TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // Shopping and add to favourite buttons
                Container(
                  height: 75,
                  width: 109,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(25.0),
                    ),
                    color: Colors.white,
                  ),
                  child: Row(
                    children: [
                      FloatingActionButton.small(
                        backgroundColor: firstColor,
                        onPressed: () {},
                        child: Icon(
                          FontAwesomeIcons.bagShopping,
                          size: 20,
                          color: Colors.white,
                        ),
                      ),
                      FloatingActionButton.small(
                        backgroundColor: firstColor,
                        onPressed: () {},
                        child: Icon(
                          FontAwesomeIcons.heart,
                          size: 20,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
