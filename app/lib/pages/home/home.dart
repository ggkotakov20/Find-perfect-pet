import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:app/colors.dart';

import 'package:app/pages/home/pet_card.dart';

import 'package:app/classes/pet.dart';
import 'package:app/data/pet_data.dart';

String _language = 'us';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children:  [
        Padding(
          padding: const EdgeInsets.all(15),
          child: TextField(
            style: TextStyle(fontSize: 18),
            cursorColor: GREEN,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.search, color: GREEN,),
              hintText: 'Search',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(color: Colors.red)
              )
            ),
          ),
        ),
        AnimalCards()
    ]);
  }
}
