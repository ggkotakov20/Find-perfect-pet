import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:app/colors.dart';

import 'package:app/classes/product.dart';
import 'package:app/data/breeding_data.dart';

class PetPage extends StatelessWidget {
  final Product animal;

  const PetPage(this.animal, {Key? key}) : super(key: key);

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
      body: SingleChildScrollView(
        child: PetInformation(animal),
      ),
    );
  }
}

class PetInformation extends StatelessWidget {
  final Product animal;
  const PetInformation(this.animal, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 250,
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage(animal.image),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 15.0, top: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${animal.title}',
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w300,
                ),
              ),
              Text(
                '${animal.price} \$',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                  color: GREEN
                ),
              ),
              const Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Text(
                  'DESCRIPTION :',
                  style: TextStyle(
                    fontSize: 22,
                  ),
                ),
              ),
              Text(
                '${animal.description}',
                style: TextStyle(
                  fontSize: 16,
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}