import 'package:app/pages/home/pet.dart';

///
/// This file provides the original category data
///

/// Original labels in german and bulgarian, english added as last value
const  _allPets = [
  ["1", "100", "Mops", "Мопс"],
  ["2", "20", "Chihuahua", "Чихуахуа"],
  ["3", "500", "Husky", "Хъски"],
  ["4", "300", "Labrador", 'Лабрадор']
];



///
/// Labels transformed into BuboCategories
///
/// This list can be used in the application for rendering the categories
///
List<Pet> cards = _allPets.map((categoryLabels) {
  return Pet(
      int.parse(categoryLabels[0]),
      double.parse(categoryLabels[1]),
      'images/pets/${categoryLabels[2].toLowerCase().replaceAll(' ', '_')}.jpg',
      {
        'us': categoryLabels[2],
        'bg': categoryLabels[3],
      },
      );
}).toList();