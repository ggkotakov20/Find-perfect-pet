import 'package:app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:app/api/api_connection.dart';

import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';


import 'package:app/colors.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;


class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {

  Future getMapPointData() async {
  var url = Uri.parse(API.mapPoint); // Convert the URL string to Uri
  var response = await http.get(url);
  return json.decode(response.body);
}

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Map1(),
      Positioned(
        top: 10,
        bottom: 0,
        left: 0,
        right: 10,
        child: Align(
          alignment: Alignment.topRight,
          child: IconButton(
            icon: Icon(FontAwesomeIcons.circleInfo, color: NavigationBarSel),
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                        title: Text(
                          'Help',
                          style: TextStyle(color: BLACK),
                        ),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  FontAwesomeIcons.squareH,
                                  color: NavigationBarSel,
                                ),
                                Text('  - Veterinary Clinic'),
                              ],
                            ),
                            SizedBox(height: 16),
                            Row(
                              children: [
                                Icon(
                                  FontAwesomeIcons.basketShopping,
                                  color: NavigationBarSel,
                                ),
                                Text('  - Pet Shop'),
                              ],
                            ),
                            SizedBox(height: 16),
                            Row(
                              children: [
                                Icon(
                                  FontAwesomeIcons.paw,
                                  color: NavigationBarSel,
                                ),
                                Text('  - Park'),
                              ],
                            ),
                            SizedBox(height: 16),
                            Row(
                              children: [
                                Icon(
                                  FontAwesomeIcons.hotel,
                                  color: NavigationBarSel,
                                ),
                                Text('  - Hotel'),
                              ],
                            ),
                            SizedBox(height: 16),
                            Row(
                              children: [
                                Icon(
                                  FontAwesomeIcons.houseChimneyMedical,
                                  color: NavigationBarSel,
                                ),
                                Text('  - Shelter'),
                              ],
                            ),
                          ],
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text('OK', style: TextStyle(color: NavigationBarSel)),
                          ),
                        ],
                      ));
            },
          ),
        ),
      ),
    ]);
  }
}

class Map1 extends StatelessWidget {
  Map1({super.key});
    Future getMapPointData() async {
      var url = Uri.parse(API.mapPoint); // Convert the URL string to Uri
      var response = await http.get(url);
      return json.decode(response.body);
    }
  
    LatLng startLocation = LatLng(42.459154076868465, 27.41478978649106);

    Future<LatLng> _getCurrentLocation(BuildContext context, LatLng startLoc) async {
  try {
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    double latitude = position.latitude;
    double longitude = position.longitude;

    return LatLng(latitude, longitude);
  } catch (e) {
    print("Error getting location: $e");
    return startLoc; // Return the original value in case of an error
  }
}

Container _buildMapContainer(BuildContext context) {
  return Container(
    height: 100,
    child: FutureBuilder(
      future: getMapPointData(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          print(snapshot.error);
          return Center(child: Text("Error loading data."));
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData || snapshot.data == null) {
          return Center(child: Text("No data available."));
        }

        Map<String, dynamic> dataMap = snapshot.data;
        List<dynamic> dataPoints = dataMap['mapPoints'];

        return FutureBuilder(
          future: _getCurrentLocation(context, startLocation),
          builder: (context, locationSnapshot) {
            if (locationSnapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }

            LatLng updatedLocation = locationSnapshot.data ?? startLocation;

            return FlutterMap(
              options: MapOptions(
                center: updatedLocation,
                maxZoom: 16.0,
                minZoom: 2.0,
                zoom: 14.0,
                interactiveFlags: InteractiveFlag.pinchZoom | InteractiveFlag.drag,
              ),
              layers: [
                TileLayerOptions(
                  urlTemplate: "https://cartodb-basemaps-{s}.global.ssl.fastly.net/rastertiles/voyager/{z}/{x}/{y}.png",
                  subdomains: ['a', 'b', 'c'],
                ),
                MarkerLayerOptions(
                  markers: _buildMarkers(dataPoints),
                ),
              ],
            );
          },
        );
      },
    ),
  );
}


List<Marker> _buildMarkers(List<dynamic> data) {
  return data.map((point) {
    double latitude = double.tryParse(point['latitude'] ?? '0') ?? 0;
    double longitude = double.tryParse(point['longitude'] ?? '0') ?? 0;

    String type = point['building_type'];

    return Marker(
      width: 30.0,
      height: 30.0,
      point: LatLng(latitude, longitude),
      builder: (context) => GestureDetector(
        onTap: () {
          showModalBottomSheet(
            context: context,
            builder: (BuildContext context) {
              return SheetModal(point); // Pass the current point data
            },
          );
        },
        child: Icon(
          type == 'hospital'
              ? FontAwesomeIcons.squareH
              : type == 'shop'
                  ? FontAwesomeIcons.basketShopping
                  : type == 'park'
                      ? FontAwesomeIcons.paw
                      : type == 'hotel'
                          ? FontAwesomeIcons.hotel
                          : type == 'shelter'
                              ? FontAwesomeIcons.houseChimneyMedical
                              : Icons.location_pin,
          color: NavigationBarSel,
        ),
      ),
    );
  }).toList();
}




  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Positioned(
        top: 0,
        bottom: 0,
        left: 0,
        right: 0,
        child: _buildMapContainer(context),
      ),
    ]);
  }
}

class SheetModal extends StatelessWidget {
  final Map<String, dynamic> point;

  const SheetModal(this.point);
  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context);

    String pointAddress = point['address'];
    
    bool isOpen = false;

    final DateTime now = DateTime.now();
    final int currentHours = now.hour;
    final int currentMinutes = now.minute;
    
    bool isTimeInRange(String start, String end) {
      List<String> startTimeComponents = start.toString().split(':');
      int? hourStart = int.tryParse(startTimeComponents[0]) ?? 0;
      int? minutesStart = int.tryParse(startTimeComponents[1]) ?? 0;

      List<String> endTimeComponents = end.toString().split(':');
      int? hourEnd = int.tryParse(endTimeComponents[0]) ?? 0;
      int? minutesEnd = int.tryParse(endTimeComponents[1]) ?? 0;

      if (hourStart != null && hourEnd != null && minutesStart != null && minutesEnd != null) {
        final isAfterStartTime =
            (currentHours > hourStart) || (currentHours == hourStart && currentMinutes >= minutesStart);
        final isBeforeEndTime =
            (currentHours < hourEnd) || (currentHours == hourEnd && currentMinutes <= minutesEnd);

        return isAfterStartTime && isBeforeEndTime;
      }
      return false;
    }

    int DateNow = now.weekday;

    if (DateNow == 6) {
      isOpen = isTimeInRange(point['worktime'][0]['saturday_start'], point['worktime'][0]['saturday_end']);
    } else if (DateNow == 7) {
      isOpen = isTimeInRange(point['worktime'][0]['sunday_start'], point['worktime'][0]['sunday_end']);
    } else {
      isOpen = isTimeInRange(point['worktime'][0]['weekday_start'], point['worktime'][0]['weekday_end']);
    }

    if (point['worktime'][0]['weekday2_start'] != null && point['worktime'][0]['weekday2_start'] != "0:00:00") {
      isOpen = isOpen ||
          isTimeInRange(point['worktime'][0]['weekday2_start'], point['worktime'][0]['weekday2_end']);
    }
    
    if(point['worktime'][0]['weekday_start'] == '01:00:00'){
      isOpen = true;
    }
    
    final Map<String, dynamic> worktime = point['worktime'][0];

    String getTimeString(String key) {
      final List<String> timeComponents = worktime[key].toString().split(':');
      final int? hour = int.tryParse(timeComponents[0]) ?? 0;
      final int? minutes = int.tryParse(timeComponents[1]) ?? 0;
      if(minutes == 0){
        return '$hour:00';
      } else {
        return '$hour:$minutes';
      }
    }

    String getTimeRange(String startKey, String endKey) {
      final String startTime = getTimeString(startKey);
      final String endTime = getTimeString(endKey);
      return '$startTime - $endTime';
    }
    Container showWorkTimeText() {

      String getTimeRanges() {
        if(worktime['weekday_start'] == '01:00:00'){
          return '${appLocalizations.general_all_day}';
        } else {
          if (DateNow >= 1 && DateNow <= 5) {
            if (worktime['weekday2_start'] != '00:00:00' && worktime['weekday2_start'] != null) {
              final String weekdayRange = getTimeRange('weekday_start', 'weekday_end');
              final String weekday2Range = getTimeRange('weekday2_start', 'weekday2_end');
              return '$weekdayRange  $weekday2Range';
            } else {
              return getTimeRange('weekday_start', 'weekday_end');
            }
          } else if (DateNow == 6) {
            if(worktime['saturday_start'] == '00:00:00' || worktime['sunday_start'] == '00:00:00'){
              return "${appLocalizations.general_not_working}";
            } else {
              return getTimeRange('saturday_start', 'saturday_end');
            }
          } else if (DateNow == 7) {
            if(worktime['saturday_start'] == '00:00:00' || worktime['sunday_start'] == '00:00:00'){
              return "${appLocalizations.general_not_working}";
            } else {
              return getTimeRange('sunday_start', 'sunday_end');
            }
          }
        }
        return '';
      }

      return Container(
        child: Text(
          getTimeRanges(),
          style: TextStyle(color: DGREY),
        ),
      );
    }


    return Container(
      color: CardBG,
      child: SizedBox(
          child: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Point image

              Container(
                width: MediaQuery.of(context).size.width,
                height: 250,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(point['image']),
                  ),
                ),
              ),

              //  Point name

              Padding(
                padding: const EdgeInsets.only(left: 22,right: 20),
                child: Center(
                  child: Text(
                    point['name'],
                    style: TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.w500,
                      color: BLACK,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),


              //  Point address

              Row(
                children: [
                  SizedBox(width: 20),
                  Container(
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(231, 244, 255, 1),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Icon(
                        Icons.location_pin,
                        color: Color.fromRGBO(0, 134, 230, 1),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      point['address'],
                      style: TextStyle(
                        fontSize: 14,
                        color: DGREY,
                      ),
                      maxLines: 1, // Add this line
                      overflow: TextOverflow.ellipsis, // Add this line
                    ),
                  ),
                ],
              ),


              //  Point work time

              Row(
                children: [
                  SizedBox(width: 20),
                  Container(
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(238, 239, 252, 1),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: Icon(
                        FontAwesomeIcons.solidClock,
                        color: Color.fromRGBO(110, 118, 215, 1),
                        size: 20,
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Container(
                    decoration: BoxDecoration(
                      color: isOpen == true 
                          ? Color.fromRGBO(242, 248, 233, 1)
                          : Color.fromRGBO(252, 235, 235, 1),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 5, bottom: 5, left: 7, right: 7),
                      child: Text(
                        isOpen == true ? '${appLocalizations.general_open}' : '${appLocalizations.general_close}',
                        style: TextStyle(
                          fontSize: 14,
                          color: isOpen == true
                              ? Color.fromRGBO(131, 197, 85, 1)
                              : Color.fromRGBO(242, 60, 60, 1),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  GestureDetector(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                                title: Text('${appLocalizations.general_work_time}'),
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    //  Monday
                                    Row(
                                      children: [
                                        SizedBox(width: 20),
                                        Text(
                                          '${appLocalizations.general_weekday} - ',
                                        ),
                                        SizedBox(width: 10),
                                        worktime['weekday_start'] == "01:00:00"
                                          ? Text('${appLocalizations.general_all_day}')
                                          : worktime['weekday2_start'] != "00:00:00"
                                            ? Column(
                                              children: [
                                                Text("${getTimeString('weekday_start')} - ${getTimeString('weekday_end')}"),
                                                Text("${getTimeString('weekday2_start')} - ${getTimeString('weekday2_end')}")                                            ],
                                            )
                                            : Text("${getTimeString('weekday_start')} - ${getTimeString('weekday_end')}"),
                                      ],
                                    ),
                                    SizedBox(height: 5),
                                    
                                    //  Saturday
                                    Row(
                                      children: [
                                        SizedBox(width: 20),
                                        Text(
                                          '${appLocalizations.general_saturday} - ',
                                        ),
                                        SizedBox(width: 10),
                                        worktime['saturday_start'] == "01:00:00"
                                        ? Text('${appLocalizations.general_all_day}')
                                        : worktime['saturday_start'] == "00:00:00"
                                          ? Text('${appLocalizations.general_not_working}')
                                          : Text("${getTimeString('saturday_start')} - ${getTimeString('saturday_end')}")
                                      ],
                                    ),
                                    SizedBox(height: 5),
                                    //  Sunday
                                    Row(
                                      children: [
                                        SizedBox(width: 20),
                                        Text(
                                          '${appLocalizations.general_sunday} - ',
                                        ),
                                        SizedBox(width: 10),
                                        worktime['sunday_start'] == "01:00:00"
                                        ? Text('${appLocalizations.general_all_day}')
                                        : worktime['sunday_start'] == "00:00:00"
                                          ? Text('${appLocalizations.general_not_working}')
                                          : Text("${getTimeString('sunday_start')} - ${getTimeString('sunday_end')}")
                                      ],
                                    ),
                                    SizedBox(height: 5),
                                  ],
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text('OK',
                                        style: TextStyle(color: NavigationBarSel)),
                                  ),
                                ],
                              ));
                    },
                    child: showWorkTimeText()
                  ),
                  SizedBox(width: 5),
                  Icon(
                    FontAwesomeIcons.chevronDown,
                    color: DGREY,
                    size: 12,
                  )
                ],
              ),

              SizedBox(
                height: 5,
              ),

              //  Point worktime each day
            ],
          ),
          Align(
            alignment: Alignment.topRight,
            child: TextButton(
              child: Container(
                decoration: BoxDecoration(
                  color: Color.fromRGBO(252, 235, 235, 1),
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Icon(
                    FontAwesomeIcons.xmark,
                    color: Color.fromRGBO(242, 60, 60, 1),
                  ),
                ),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ],
      )),
    );
  }
}
