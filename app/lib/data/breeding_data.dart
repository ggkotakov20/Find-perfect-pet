import 'package:app/classes/product.dart';

const _all = [
  ["0", "Pitbull", "400"],
  ["1", "Cane Corso", "200"],
];

const _description = [
  "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
  "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
];

List<Product> breeding = _all.asMap().entries.map((entry) {
  int index = entry.key;
  List<String> categoryLabels = entry.value;

  return Product(
    int.parse(categoryLabels[0]),
    'images/breeding/${categoryLabels[1].toLowerCase().replaceAll(' ', '_')}.jpg',
    '${categoryLabels[1]}',
    double.parse(categoryLabels[2]),
    '${_description[index]}'
  );
}).toList();