import 'dart:convert';
import 'package:app/classes/product.dart';
import 'package:flutter/material.dart';
import 'package:app/colors.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:app/widgets/pet_card.dart';

import 'package:app/model/current_user.dart';
import 'package:get/get.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:app/api/api_connection.dart';
import 'package:http/http.dart' as http;
import 'package:app/model/advert.dart';



import 'package:app/data/pet_data.dart';



class YourAdvert extends StatefulWidget {
  const YourAdvert({super.key});

  @override
  State<YourAdvert> createState() => _YourAdvertState();
}

class _YourAdvertState extends State<YourAdvert> {
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
      body: YourAdvertBody(),
    );
  }
}

class YourAdvertBody extends StatefulWidget {
  const YourAdvertBody({super.key});

  @override
  State<YourAdvertBody> createState() => _YourAdvertBodyState();
}

class _YourAdvertBodyState extends State<YourAdvertBody> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
         Positioned(
        top: 100,
        bottom: 0,
        left: 30,
        right: 30,
        child: AdvertView(),
      ),
      ],
    );
  }
}

class AdvertView extends StatelessWidget {
  const AdvertView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: pet.map((Card) {
        return AdvertItemView(Card,
            heroTag: Card.id
                .toString() // Assign a unique tag based on the card's ID
            );
      }).toList(),
    );
  }
}

class AdvertItemView extends StatelessWidget {
  final Product animal;
  final String heroTag;

  const AdvertItemView(this.animal,
      {Key? key, required this.heroTag})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    String animalPrice = animal.price.toString();
    return PetCard(
      title: animal.title,
      price: animalPrice,
      img: animal.image,
      onTap: () {},
    );
  }
}