import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:app/colors.dart';

import 'package:app/pages/home/buy_card.dart';
import 'package:app/pages/home/food_card.dart';
import 'package:app/pages/home/access_card.dart';
import 'package:app/pages/home/breeding_card.dart';

String homePage = 'home';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Pets
            SizedBox(height: 5,),
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: SizedBox(
                height: 90,
                width: 410,
                child: ElevatedButton(
                  onPressed: () {
                    homePage = 'buy';
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => PetCardsPage()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    primary: CardBG,
                  ),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Container(
                          height: 55,
                          width: 55,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100.0),
                            color: Color.fromRGBO(231, 244, 255, 1),
                          ),
                          child: Icon(
                            FontAwesomeIcons.paw,
                            size: 25,
                            color: Color.fromRGBO(0, 134, 230, 1),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 25.0),
                        child: Text(
                          'Buy Pet',
                          style: TextStyle(
                            color: BLACK,
                            fontSize: 22,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            
            // Breeding
            SizedBox(height: 30,),
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: SizedBox(
                height: 90,
                width: 410,
                child: ElevatedButton(
                  onPressed: () {
                    homePage = 'breeding';
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => BreedingCardsPage()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    primary: CardBG,
                  ),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Container(
                          height: 55,
                          width: 55,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100.0),
                            color: Color.fromRGBO(254, 240, 245, 1),
                          ),
                          child: Icon(
                            FontAwesomeIcons.circlePlus,
                            size: 25,
                            color: Color.fromRGBO(244, 100, 165, 1),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 25.0),
                        child: Text(
                          'Breeding',
                          style: TextStyle(
                            color: BLACK,
                            fontSize: 22,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),

            //  Foods
            SizedBox(height: 30,),
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: SizedBox(
                height: 90,
                width: 410,
                child: ElevatedButton(
                  onPressed: () {
                    homePage = 'food';
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => FoodCardsPage()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    primary: CardBG,
                  ),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Container(
                          height: 55,
                          width: 55,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100.0),
                            color: Color.fromRGBO(239, 240, 253, 1),
                          ),
                          child: Icon(
                            FontAwesomeIcons.bowlFood,
                            size: 25,
                            color: Color.fromRGBO(98, 106, 208, 1),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 25.0),
                        child: Text(
                          'Foods',
                          style: TextStyle(
                            color: BLACK,
                            fontSize: 22,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            
            //  Accessories
            SizedBox(height: 30,),
            Padding(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: SizedBox(
                  height: 90,
                  width: 410,
                  child: ElevatedButton(
                    onPressed: () {
                    homePage = 'accessories';
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => AccessCardsPage()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      primary: CardBG,
                    ),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Container(
                            height: 55,
                            width: 55,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100.0),
                              color: Color.fromRGBO(242, 248, 233, 1),
                            ),
                            child: Icon(
                              FontAwesomeIcons.baseball,
                              size: 25,
                              color: Color.fromRGBO(123, 188, 40, 1),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 25.0),
                          child: Text(
                            'Accessories',
                            style: TextStyle(
                              color: BLACK,
                              fontSize: 22,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            
          ],
        ),
      ),
      
    ]);
  }
}
