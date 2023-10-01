import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:app/colors.dart';

Container TextBox(IconData icon, String title, var controller) {
  return Container(
    child: Padding(
      padding: const EdgeInsets.only(top: 15.0, left: 20, right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 5),
            child: Text(
              title,
              style: TextStyle(
                fontSize: 14,
              ),
            ),
          ),
          TextFormField(
            controller: controller,
            decoration: InputDecoration(
              prefixIcon: Icon(
                icon,
                color: TextColor.withOpacity(0.75),
                size: 19,
              ),
              hintText: title,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                  color: Colors.black.withOpacity(0.3),
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                  color: Colors.black.withOpacity(0.3),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                  color: Colors.black.withOpacity(0.3),
                ),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                  color: Colors.black.withOpacity(0.3),
                ),
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 14,
                vertical: 6,
              ),
              fillColor: CardBG,
              filled: true,
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a value for $title';
              }
              return null;
            },
          ),
        ],
      ),
    ),
  );
}

Container NumberBox(IconData icon, String title, var controller) {
  return Container(
    child: Padding(
      padding: const EdgeInsets.only(top: 15.0, left: 20, right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 5),
            child: Text(
              title,
              style: TextStyle(
                fontSize: 14,
              ),
            ),
          ),
          TextFormField(
            keyboardType: TextInputType.number,
            controller: controller,
            decoration: InputDecoration(
              prefixIcon: Icon(
                icon,
                color: TextColor.withOpacity(0.75),
                size: 19,
              ),
              hintText: title,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                  color: Colors.black.withOpacity(0.3),
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                  color: Colors.black.withOpacity(0.3),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                  color: Colors.black.withOpacity(0.3),
                ),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                  color: Colors.black.withOpacity(0.3),
                ),
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 14,
                vertical: 6,
              ),
              fillColor: CardBG,
              filled: true,
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a value for $title';
              }
              return null;
            },
          ),
        ],
      ),
    ),
  );
}

Container SelectBox(IconData icon, String title, var controller, List<String> items) {
    // Ensure that the selectedAnimal matches one of the items or provide a default.
    String? selectedAnimal = items[0];

    return Container(
      child: Padding(
        padding: const EdgeInsets.only(top: 15.0, left: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 14,
                ),
              ),
            ),
            InputDecorator(
              decoration: InputDecoration(
                prefixIcon: Icon(
                  icon,
                  color: TextColor.withOpacity(0.75),
                  size: 19,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color: Colors.black.withOpacity(0.3),
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color: Colors.black.withOpacity(0.3),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color: Colors.black.withOpacity(0.3),
                  ),
                ),
                disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color: Colors.black.withOpacity(0.3),
                  ),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 14,
                ),
                fillColor: CardBG,
                filled: true,
              ),
              child: DropdownButtonFormField<String>(
                isExpanded: true,
                icon: Icon(
                  FontAwesomeIcons.bars,
                  size: 18,
                ),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Select an animal',
                ),
                value: selectedAnimal,
                items: items.map((item) {
                  return DropdownMenuItem<String>(
                    value: item,
                    child: Text(item),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  controller.text = newValue ?? '';
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
