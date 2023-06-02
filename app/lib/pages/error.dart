import 'package:flutter/material.dart';

class ErrorPage extends StatelessWidget {
  const ErrorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'This page is in process',
          style: TextStyle(
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}
