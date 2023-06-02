import 'package:app/pages/map/point.dart';
import 'package:latlong2/latlong.dart';

const _pointsName = [
  'Ветеринарна клиника ArenaVet',
  'ВЕТЕРИНАРНА КАБИНЕТ "КОАЛА"',
  'Ветеринар',
  'Ветеринарна клиника Vet plus'
];

final List<LatLng> _pointPosition = [
  LatLng(42.463286562929824, 27.413205105891176),
  LatLng(42.45950136285772, 27.413188564786022),
  LatLng(42.46159690755076, 27.412793587965492),
  LatLng(42.45458751535946, 27.41747692604481)
];

const _pointAddress = [
  'ж.к. Меден рудник 361, 8011 Меден Рудник, Бургас',
  'ж.к. Меден рудник 244, 8011 Меден Рудник, Бургас',
  'ж.к. Меден рудник 355, 8011 Меден Рудник, Бургас',
  'ж.к. Меден рудник 516, 8011 Меден Рудник, Бургас',
]; 
const _pointIndex = [
  ['0'],
  ['1'],
  ['2'],
  ['3'],
];


List<MapPoint> points = _pointIndex.asMap().entries.map((entry) {
  int index = entry.key;
  List<String> categoryLabels = entry.value;

  return MapPoint(
    int.parse(categoryLabels[0]),
    '${_pointsName[index]}',
    _pointPosition[index],
    '${_pointAddress[index]}',
    'images/vet/${categoryLabels[0].toLowerCase().replaceAll(' ', '_')}.jpg',
  );
}).toList();