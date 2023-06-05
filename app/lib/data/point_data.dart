import 'package:app/pages/map/point.dart';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:intl/intl.dart';

///   Types
/// 1 - Hospital
/// 2 - Shop
/// 3 - Park

const _points = [
  ['0', '1', 'Ветеринарна клиника ArenaVet', 'ж.к. Меден рудник 361, 8011 Меден Рудник, Бургас', '42.463286562929824', '27.413205105891176'],
  ['1', '1', 'ВЕТЕРИНАРНА КАБИНЕТ "КОАЛА"', 'ж.к. Меден рудник 244, 8011 Меден Рудник, Бургас', '42.45950136285772', '27.413188564786022'],
  ['2', '1', 'Ветеринар', 'ж.к. Меден рудник 355, 8011 Меден Рудник, Бургас', '42.46159690755076', '27.412793587965492'],
  ['3', '1', 'Ветеринарна клиника Vet plus', 'ж.к. Меден рудник 516, 8011 Меден Рудник, Бургас', '42.45458751535946', '27.41747692604481'],
  ['4', '2', 'Зоомагазин Пламена', 'Бургас кс, ж.к. Меден рудник 551, 8012 Бургас', '42.4503678621161', '27.417906107968225'],
  ['5', '2', 'Зоомагазин Шампион', 'ул. „Тракиец“ 34, 8009 Меден Рудник, Бургас', '42.45821278824417', '27.413416722212272'],
  ['6', '2', 'Зоомагазин Тренди-Еврозоовет', '8000, ж.к. Меден рудник 278, 8008 Бургас', '42.4566018217135', '27.41715028402025'],
  ['7', '2', 'Зоомагазин Сириус', 'бул. „Захари Стоянов" 62, 8009 Меден Рудник, Бургас', '42.4606848118274', '27.40809686930021'],
  ['8', '2', 'Зоомагазин "Кари"', 'ул. „Петрова нива“ 11, 8000 Меден Рудник, Бургас', '42.454066849117105', '27.41245223953871'],
  ['9', '3', 'Парк за разходка на кучета', 'ул. „Въстаническа“ 426, 8011 Меден Рудник', '42.46028655910682', '27.422187958609218']
];

//['0', '10', '00', '13', '00', '10', '00', '19', '00', '-1', '-1', '-1', '-1', '15', '00', '19', '00'],
const _pointsWorkTime = [
  ['0', '10', '00', '13', '00', '10', '00', '19', '00', '-1', '-1', '-1', '-1', '15', '00', '19', '00'],
  ['1', '09', '00', '19', '00', '09', '00', '13', '00', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1'],
  ['2', '10', '00', '18', '30', '10', '00', '18', '30', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1'],
  ['3', '09', '00', '13', '00', '09', '00', '13', '00', '-1', '-1', '-1', '-1', '15', '00', '18', '30'],
  ['4', '09', '00', '19', '00', '09', '00', '18', '00', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1'],
  ['5', '08', '00', '19', '00', '08', '30', '18', '00', '10', '00', '16', '00', '-1', '-1', '-1', '-1'],
  ['6', '09', '30', '19', '00', '09', '30', '14', '00', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1'],
  ['7', '08', '00', '19', '00', '08', '00', '17', '00', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1'],
  ['8', '09', '30', '18', '30', '10', '00', '16', '00', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1'],
  ['9', '24', '-1', '-1', '-1', '24', '-1', '-1', '-1', '24', '-1', '-1', '-1', '-1', '-1', '-1', '-1']
];

List<WorkTime> workTime = _pointsWorkTime.asMap().entries.map((entry) {
  List<String> categoryLabels = entry.value;

  return WorkTime(
    int.parse(categoryLabels[0]),
    int.parse(categoryLabels[1]),
    int.parse(categoryLabels[2]),
    int.parse(categoryLabels[3]),
    int.parse(categoryLabels[4]),
    int.parse(categoryLabels[5]),
    int.parse(categoryLabels[6]),
    int.parse(categoryLabels[7]),
    int.parse(categoryLabels[8]),
    int.parse(categoryLabels[9]),
    int.parse(categoryLabels[10]),
    int.parse(categoryLabels[11]),
    int.parse(categoryLabels[12]),
    int.parse(categoryLabels[13]),
    int.parse(categoryLabels[14]),
    int.parse(categoryLabels[15]),
    int.parse(categoryLabels[16]),
  );

}).toList();

List<MapPoint> points = _points.asMap().entries.map((entry) {
  int index = entry.key;
  List<String> categoryLabels = entry.value;

  return MapPoint(
    int.parse(categoryLabels[0]),
    int.parse(categoryLabels[1]),
    '${categoryLabels[2]}',
    '${categoryLabels[3]}',
    'images/points/${categoryLabels[0].toLowerCase().replaceAll(' ', '_')}.jpg',
    double.parse(categoryLabels[4]),
    double.parse(categoryLabels[5]),
    workTime[index]
  );
}).toList();
