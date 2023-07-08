import 'package:flutter/material.dart';
import 'package:app/colors.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:app/classes/product.dart';
import 'package:app/data/food_data.dart';
import 'package:app/pages/home/food_page.dart';


class FoodCardsPage extends StatefulWidget {
  const FoodCardsPage({super.key});

  @override
  State<FoodCardsPage> createState() => _FoodCardsPageState();
}

class _FoodCardsPageState extends State<FoodCardsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        centerTitle: true,
        foregroundColor: GREEN,
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
      body: Cards(),
    );
  }
}

class Cards extends StatefulWidget {
  const Cards({super.key});

  @override
  State<Cards> createState() => _CardsState();
}

class _CardsState extends State<Cards> {
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(15),
            child: TextField(
              style: TextStyle(fontSize: 18),
              cursorColor: GREEN,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search, color: GREEN),
                hintText: 'Search',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(color: Colors.red),
                ),
              ),
            ),
          )
        ],
      ),
      Positioned(
        top: 100,
        bottom: 0,
        left: 30,
        right: 30,
        child: FoodViewer(),
      ),
    ]);
  }
}

class FoodViewer extends StatelessWidget {
  FoodViewer({super.key});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    var widthPerCategory = 400;

    print('$width X $height');

    return ListView(
      children: food.map((Card) {
        return FoodListItem(Card,
            heroTag: Card.id
                .toString() // Assign a unique tag based on the card's ID
            );
      }).toList(),
    );
  }
}

class FoodListItem extends StatelessWidget {
  final Product food;
  final String heroTag; // Add a heroTag property

  const FoodListItem(this.food,
      {Key? key, required this.heroTag})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    String foodPrice = food.price.toString();
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
                MaterialPageRoute(builder: (context) => FoodPage(food)),
              );
            },
            child: Container(
              width: 325,
              height: 175,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(food.image),
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
                          food.title ,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 24,
                            overflow: TextOverflow.ellipsis,
                            color: BLACK,
                          ),
                        ),
                        Text(
                          '$foodPrice \$',
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
