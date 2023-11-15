import 'dart:convert';

import 'package:app/fragments/pet/edit_pet_page.dart';
import 'package:app/fragments/pet/add_pet.dart';
import 'package:app/functions/input_box.dart';
import 'package:app/functions/refresh.dart';
import 'package:app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:app/colors.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:app/api/api_connection.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

import 'package:app/model/user_pet.dart';
import 'package:app/model/current_user.dart';


class Calender extends StatefulWidget {
  const Calender({Key? key}) : super(key: key);

  @override
  State<Calender> createState() => _CalenderState();
}

class _CalenderState extends State<Calender> {
  var formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController eventStartController = TextEditingController();
  TextEditingController eventEndController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final CurrentUser _currentUser = Get.put(CurrentUser());
    final AppLocalizations appLocalizations = AppLocalizations.of(context);

    return Stack(
      children: [
        Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Container(
                      color: CardBG,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            SizedBox(height: 5),
                            InputTextBox(
                              FontAwesomeIcons.paw,
                              "Title",
                              nameController,
                              true,
                              TextColor.withOpacity(0.75),
                            ),
                            TextFormField(
                              style: TextStyle(fontSize: 12.0),
                              controller: eventStartController,
                              keyboardType: TextInputType.datetime,
                              inputFormatters: [DateTimeInputFormatter()],
                              decoration: InputDecoration(
                                isDense: true,
                                fillColor: Colors.white,
                                hintText: 'Date of Birth',
                                filled: true,
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(width: 0.0),
                                ),
                                contentPadding: const EdgeInsets.only(
                                  left: 14.0,
                                  bottom: 10.0,
                                  top: 10.0,
                                ),
                              ),
                            ),
                            SizedBox(height: 20),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Container(
              width: double.infinity,
              height: 75,
              decoration: BoxDecoration(
                color: CardBG,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.4),
                    spreadRadius: 2,
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 12,
                  bottom: 12,
                  left: 20,
                  right: 20,
                ),
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(mainColor),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'Add new event',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}