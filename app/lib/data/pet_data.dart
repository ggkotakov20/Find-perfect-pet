import 'package:app/classes/pet.dart';

const _allPets = [
  ["1", "Mops", "Мопс"],
  ["2", "Chihuahua", "Чихуахуа"],
  ["3", "Husky", "Хъски"],
  ["4", "Labrador", 'Лабрадор']
];

const _petPrices = [
  "100",
  "20",
  "500",
  "300"
];

List<Pet> cards = _allPets.asMap().entries.map((entry) {
  int index = entry.key;
  List<String> categoryLabels = entry.value;

  return Pet(
    int.parse(categoryLabels[0]),
    double.parse(_petPrices[index]),
    'images/pets/${categoryLabels[1].toLowerCase().replaceAll(' ', '_')}.jpg',
    {
      'us': categoryLabels[1],
      'bg': categoryLabels[2],
    },
  );
}).toList();