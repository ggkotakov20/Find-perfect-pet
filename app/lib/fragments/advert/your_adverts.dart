import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:app/colors.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:app/model/current_user.dart';
import 'package:get/get.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:app/api/api_connection.dart';
import 'package:http/http.dart' as http;
import 'package:app/model/advert.dart';

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
    return const Placeholder();
  }
}