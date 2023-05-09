import 'package:app/pages/home/animal.dart';

///
/// This file provides the original category data
///

/// Original labels in german and bulgarian, english added as last value
const labels = [
  ["1", "100.50", "mops", "мопс"],
  ["2", "20", "chihuahua", "цихуахуа"],
  ["3", "500", "husky", "хъски"]
];

///
/// Labels transformed into BuboCategories
///
/// This list can be used in the application for rendering the categories
///
List<Animal> categories = labels.map((categoryLabels) {
  return Animal(
      int.parse(categoryLabels[0]),
      double.parse(categoryLabels[1]),
      'images/pets/${categoryLabels[2].toLowerCase().replaceAll(' ', '_')}.jpg',
      {
        'us': categoryLabels[2],
        'bg': categoryLabels[3],
      },
      );
}).toList();
