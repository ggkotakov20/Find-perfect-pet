import 'package:latlong2/latlong.dart';

class MapPoint {
  int id;
  String name;
  LatLng position;
  String address;
  String image;

  MapPoint(this.id, this.name, this.position, this.address, this.image);
}