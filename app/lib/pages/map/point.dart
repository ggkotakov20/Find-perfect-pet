import 'package:latlong2/latlong.dart';

class MapPoint {
  int id;
  int type;
  String name;
  String address;
  String image;
  double positionX;
  double positionY;
  WorkTime workTime;


  MapPoint(this.id, this.type, this.name, this.address, this.image, this.positionX, this.positionY, this.workTime);
}

class WorkTime {
  int id;
  int weekdayStartH;
  int weekdayStartM;
  int weekdayEndH;
  int weekdayEndM;

  int saturdayStartH;
  int saturdayStartM;
  int saturdayEndH;
  int saturdayEndM;

  int sundayStartH;
  int sundayStartM;
  int sundayEndH;
  int sundayEndM;
  
  int weekday2StartH;
  int weekday2StartM;
  int weekday2EndH;
  int weekday2EndM;

  WorkTime(this.id, this.weekdayStartH, this.weekdayStartM, this.weekdayEndH, this.weekdayEndM, this.saturdayStartH, this.saturdayStartM, this.saturdayEndH, this.saturdayEndM, this.sundayStartH, this.sundayStartM, this.sundayEndH, this.sundayEndM, this.weekday2StartH, this.weekday2StartM, this.weekday2EndH, this.weekday2EndM);
}