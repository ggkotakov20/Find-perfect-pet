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

const _petDescription = [
  "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
  "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
  "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
  "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
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
    '${_petDescription[index]}'
  );
}).toList();