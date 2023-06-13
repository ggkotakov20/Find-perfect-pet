import 'package:flutter/material.dart';
import 'package:app/colors.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:app/classes/pet.dart';
import 'package:app/data/pet_data.dart';
import 'package:app/pages/home/pet_page.dart';

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
    return Stack(children: [
    Positioned(
      top: 100,
      bottom: 0,
      left: 30,
      right: 30,
      child: AnimalViewer(_language),
    ),
  ]);
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
        return AnimalListItem(language, cards,
            heroTag: cards.id
                .toString() // Assign a unique tag based on the card's ID
            );
      }).toList(),
    );
  }
}

class AnimalListItem extends StatelessWidget {
  final String language;
  final Pet animal;
  final String heroTag; // Add a heroTag property

  const AnimalListItem(this.language, this.animal,
      {Key? key, required this.heroTag})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    String animalPrice = animal.price.toString();
    return Container(
      margin: const EdgeInsets.only(
        top: 20,
        bottom: 0,
      ),
      child: Column(
        children: [
          // Image section
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PetPage(language, animal)),
              );
            },
            child: Container(
              width: 325,
              height: 150,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(animal.image),
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
                  height: 75,
                  width: 216,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(25.0),
                    ),
                    color: LGREY,
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
                          style: TextStyle(
                            fontSize: 26,
                            overflow: TextOverflow.ellipsis,
                            color: BLACK,
                          ),
                        ),
                        Text(
                          '$animalPrice \$',
                          style: TextStyle(
                            fontSize: 18,
                            color: DGREY,
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
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(25.0),
                  ),
                  color: LGREY,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        FontAwesomeIcons.bagShopping,
                        size: 20,
                        color: DGREEN,
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        FontAwesomeIcons.heart,
                        size: 20,
                        color: DGREEN,
                      ),
                    ),
                    SizedBox(width: 10),
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
