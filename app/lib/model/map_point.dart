class Point {
  int id;
  String building_type;
  String name;
  String address;
  double latitude;
  double longitude;
  
  Point(this.id, this.building_type, this.name, this.address, this.latitude, this.longitude);

  factory Point.fromJson(Map<String, dynamic> json) => Point(
    int.parse(json['id']),
    json['building_type'],
    json['name'],
    json['address'],
    double.parse(json['latitude']),
    double.parse(json['longitude'])
  );

  Map<String, dynamic> toJson() => {
    'id': id.toString(),
    'building_type': building_type,
    'name': name,
    'address': address,
    'latitude': latitude.toString(),
    'longitude': longitude.toString(),
  };
}