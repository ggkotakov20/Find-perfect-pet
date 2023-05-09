import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:app/colors.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:app/pages/home/animal.dart';
import 'package:app/data/animal_languages.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _language = 'us';

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
          Positioned(
            top: 35,
            bottom: 35,
            left: 30,
            right: 30,
            child: CategoryViewer(_language),
          ),],
    );
  }
}

class CategoryViewer extends StatelessWidget {
  final String language;
  CategoryViewer(this.language, {super.key});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    var widthPerCategory = 400;

    print('$width X $height');

      return ListView(
        children: categories.map((categories){
          return CategoryListItem(language, categories);
        }).toList(),
      );
    
  }
}

class CategoryListItem extends StatelessWidget {
  final String language;
  final Animal animal;

  const CategoryListItem(this.language, this.animal, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [ 
         Container(
           width: 200,
           height: 200,
           decoration: BoxDecoration(
             image: DecorationImage(image: AssetImage(animal.image)),
             ),
           child: Padding(
             padding: const EdgeInsets.fromLTRB(0, 125, 0, 0),
             child: Center(
               child: Text(
                 animal.title[language] != null
                 ? animal.title[language]!
                 : 'Not available',
               style: TextStyle(color: Colors.black, fontSize: 25, fontWeight: FontWeight.w400),
               ),
             ),
           ),
         )
      ],
    );
  }
}