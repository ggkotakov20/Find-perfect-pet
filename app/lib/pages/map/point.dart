import 'package:latlong2/latlong.dart';

class MapPoint {
  int id;
  int type;
  String name;
  String address;
  String image;
  double positionX;
  double positionY;

  MapPoint(this.id, this.type, this.name, this.address, this.image, this.positionX, this.positionY);
}