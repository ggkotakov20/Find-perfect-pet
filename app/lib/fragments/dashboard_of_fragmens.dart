import 'package:flutter/material.dart';
import 'package:app/colors.dart';
import 'package:get/get.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DashboardOfFragments extends StatelessWidget {
  const DashboardOfFragments({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        //  To remove shadowes
        elevation: 0.0,
        toolbarHeight: 80,
        title: const Center(
          child: Image(
            image: AssetImage('images/logo.png'),
            height: 65,
          ),
        ),
        backgroundColor: background,
      ),
      
    );
  }
}