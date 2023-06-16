import 'package:flutter/material.dart';
import 'package:app/colors.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
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
    );
  }
}