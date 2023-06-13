import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:app/colors.dart';

import 'package:app/classes/pet.dart';
import 'package:app/data/pet_data.dart';

class PetPage extends StatelessWidget {
  final String language;
  final Pet animal;
  const PetPage(this.language,this.animal, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${animal.title[language]}'),
      ),
      body: Container(
        child: Column(
          children: [
            Text('Pet Details Page ${animal.id}'),
            // ...add more widgets for pet details
          ],
        ),
      ),
    );
  }
}