import 'package:flutter/material.dart';
import 'package:app/data/point_data.dart';
import 'package:app/pages/map/point.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:intl/intl.dart';

import 'package:app/colors.dart';

import 'package:app/pages/map/map.dart';

final LatLng startLocation = LatLng(42.459154076868465, 27.41478978649106);

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Map(),
      Positioned(
        top: 10,
        bottom: 0,
        left: 0,
        right: 10,
        child: Align(
          alignment: Alignment.topRight,
          child: IconButton(
            icon: Icon(FontAwesomeIcons.circleInfo, color: GREEN),
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
                                  color: GREEN,
                                ),
                                Text('  - Veterinary Clinic'),
                              ],
                            ),
                            SizedBox(height: 16),
                            Row(
                              children: [
                                Icon(
                                  FontAwesomeIcons.basketShopping,
                                  color: GREEN,
                                ),
                                Text('  - Pet Shop'),
                              ],
                            ),
                            SizedBox(height: 16),
                            Row(
                              children: [
                                Icon(
                                  FontAwesomeIcons.paw,
                                  color: GREEN,
                                ),
                                Text('  - Park'),
                              ],
                            ),
                          ],
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text('OK', style: TextStyle(color: GREEN)),
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

class Map extends StatelessWidget {
  const Map({super.key});

  Container _buildMapContainer(BuildContext context) {
    return Container(
      height: 100,
      child: FlutterMap(
        options: MapOptions(
          center: startLocation, // Specify the initial map center coordinates
          maxZoom: 16.0,
          minZoom: 2.0,
          zoom: 15.0,
          interactiveFlags: InteractiveFlag.pinchZoom | InteractiveFlag.drag,
        ),
        layers: [
          TileLayerOptions(
              urlTemplate:
                  "https://cartodb-basemaps-{s}.global.ssl.fastly.net/rastertiles/voyager/{z}/{x}/{y}.png",
              subdomains: [
                'a',
                'b',
                'c'
              ],
              additionalOptions: {
                'variant': 'precipitation_new',
              }),
          MarkerLayerOptions(
            markers: points.map((points) {
              return Marker(
                point: LatLng(points.positionX, points.positionY),
                builder: (ctx) => GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (BuildContext context) {
                        return SheetModal(points); // Pass the workTime object
                      },
                    );
                  },
                  child: Icon(
                    points.type == 1
                        ? FontAwesomeIcons.squareH
                        : points.type == 2
                            ? FontAwesomeIcons.basketShopping
                            : points.type == 3
                                ? FontAwesomeIcons.paw
                                : Icons.location_pin,
                    color: GREEN,
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
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
  final MapPoint point;

  const SheetModal(this.point);
  @override
  Widget build(BuildContext context) {
    String pointAddress = point.image;

    int TimeNowH = TimeOfDay.now().hour;
    int TimeNowM = TimeOfDay.now().minute;
    int DateNow = DateTime.now().weekday;
    DateNow = 2;

    int workTimeStdH;
    int workTimeStdM;
    int workTimeEtdH;
    int workTimeEtdM;

    if (DateNow >= 1 && DateNow <= 5) {
      workTimeStdH = point.workTime.weekdayStartH;
      workTimeStdM = point.workTime.weekdayStartM;
      workTimeEtdH = point.workTime.weekdayEndH;
      workTimeEtdM = point.workTime.weekdayEndM;
    } else if (DateNow == 6) {
      workTimeStdH = point.workTime.saturdayStartH;
      workTimeStdM = point.workTime.saturdayStartM;
      workTimeEtdH = point.workTime.saturdayEndH;
      workTimeEtdM = point.workTime.saturdayEndM;
    } else {
      workTimeStdH = point.workTime.sundayStartH;
      workTimeStdM = point.workTime.sundayStartM;
      workTimeEtdH = point.workTime.sundayEndH;
      workTimeEtdM = point.workTime.sundayEndM;
    }

    bool open = false;
    bool showAllWorkTime = false;

    if ((TimeNowH > workTimeStdH && TimeNowH < workTimeEtdH) ||
        (TimeNowH == workTimeStdH && TimeNowM > workTimeStdM) ||
        (TimeNowH == workTimeEtdH && TimeNowM < workTimeEtdM)) {
      open = true;
    } else if (point.workTime.weekday2StartH > 0 &&
        (DateNow >= 1 && DateNow <= 5)) {
      int workTime2StdH = point.workTime.weekday2StartH;
      int workTime2StdM = point.workTime.weekday2StartM;
      int workTime2EtdH = point.workTime.weekday2EndH;
      int workTime2EtdM = point.workTime.weekday2EndM;
      if ((TimeNowH > workTime2StdH && TimeNowH < workTime2EtdH) ||
          (TimeNowH == workTime2StdH && TimeNowM > workTime2StdM) ||
          (TimeNowH == workTime2EtdH && TimeNowM < workTime2EtdM)) {
        open = true;
      }
    }

    return Container(
      color: LGREY,
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
                    image: AssetImage(point.image),
                  ),
                ),
              ),

              //  Point name

              Center(
                child: Text(
                  point.name,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w500,
                    color: BLACK,
                  ),
                ),
              ),

              //  Point address

              Row(
                children: [
                  SizedBox(width: 20),
                  Container(
                    decoration: BoxDecoration(
                      color: WHITE,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Icon(
                        Icons.location_pin,
                        color: BLACK,
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Text(
                    point.address,
                    style: TextStyle(fontSize: 14, color: DGREY),
                  ),
                ],
              ),

              //  Point work time

              Row(
                children: [
                  SizedBox(width: 20),
                  Container(
                    decoration: BoxDecoration(
                      color: WHITE,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: Icon(
                        FontAwesomeIcons.solidClock,
                        color: BLACK,
                        size: 20,
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Container(
                    decoration: BoxDecoration(
                      color: open == true || workTimeStdH == 24 ? GREEN : BROWN,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 5, bottom: 5, left: 7, right: 7),
                      child: Text(
                        open == true || workTimeStdH == 24 ? 'Open' : 'Close',
                        style: TextStyle(
                          fontSize: 14,
                          color: open == true || workTimeStdH == 24
                              ? DGREEN
                              : ORGANGE,
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
                                title: Text('Help'),
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    //  Monday
                                    Row(
                                      children: [
                                        SizedBox(width: 20),
                                        Text(
                                          'Mondey - ',
                                          style: TextStyle(color: DGREY),
                                        ),
                                        SizedBox(width: 10),
                                        Text(
                                          point.workTime.weekdayStartH == 24
                                              ? 'All day'
                                              : point.workTime.weekdayStartH < 0
                                                  ? "Doesn't working"
                                                  : point.workTime.weekdayStartM ==
                                                              0 &&
                                                          point.workTime
                                                                  .weekdayEndM ==
                                                              0
                                                      ? '${point.workTime.weekdayStartH}:00 - ${point.workTime.weekdayEndH}:00'
                                                      : point.workTime
                                                                  .weekdayStartM ==
                                                              0
                                                          ? '${point.workTime.weekdayStartH}:00 - ${point.workTime.weekdayEndH}:${point.workTime.weekdayEndM}'
                                                          : point.workTime
                                                                      .weekdayEndM ==
                                                                  0
                                                              ? '${point.workTime.weekdayStartH}:${point.workTime.weekdayStartM} - ${point.workTime.weekdayEndH}:00'
                                                              : '${point.workTime.weekdayStartH}:${point.workTime.weekdayStartM} - ${point.workTime.weekdayEndH}:${point.workTime.weekdayEndM}',
                                          style: TextStyle(color: DGREY),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 5),
                                    //  Tuesday
                                    Row(
                                      children: [
                                        SizedBox(width: 20),
                                        Text(
                                          'Tuesday - ',
                                          style: TextStyle(color: DGREY),
                                        ),
                                        SizedBox(width: 10),
                                        Text(
                                          point.workTime.weekdayStartH == 24
                                              ? 'All day'
                                              : point.workTime.weekdayStartH < 0
                                                  ? "Doesn't working"
                                                  : point.workTime.weekdayStartM ==
                                                              0 &&
                                                          point.workTime
                                                                  .weekdayEndM ==
                                                              0
                                                      ? '${point.workTime.weekdayStartH}:00 - ${point.workTime.weekdayEndH}:00'
                                                      : point.workTime
                                                                  .weekdayStartM ==
                                                              0
                                                          ? '${point.workTime.weekdayStartH}:00 - ${point.workTime.weekdayEndH}:${point.workTime.weekdayEndM}'
                                                          : point.workTime
                                                                      .weekdayEndM ==
                                                                  0
                                                              ? '${point.workTime.weekdayStartH}:${point.workTime.weekdayStartM} - ${point.workTime.weekdayEndH}:00'
                                                              : '${point.workTime.weekdayStartH}:${point.workTime.weekdayStartM} - ${point.workTime.weekdayEndH}:${point.workTime.weekdayEndM}',
                                          style: TextStyle(color: DGREY),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 5),
                                    //  Wednesday
                                    Row(
                                      children: [
                                        SizedBox(width: 20),
                                        Text(
                                          'Wednesday',
                                          style: TextStyle(color: DGREY),
                                        ),
                                        SizedBox(width: 10),
                                        Text(
                                          point.workTime.weekdayStartH == 24
                                              ? 'All day'
                                              : point.workTime.weekdayStartH < 0
                                                  ? "Doesn't working"
                                                  : point.workTime.weekdayStartM ==
                                                              0 &&
                                                          point.workTime
                                                                  .weekdayEndM ==
                                                              0
                                                      ? '${point.workTime.weekdayStartH}:00 - ${point.workTime.weekdayEndH}:00'
                                                      : point.workTime
                                                                  .weekdayStartM ==
                                                              0
                                                          ? '${point.workTime.weekdayStartH}:00 - ${point.workTime.weekdayEndH}:${point.workTime.weekdayEndM}'
                                                          : point.workTime
                                                                      .weekdayEndM ==
                                                                  0
                                                              ? '${point.workTime.weekdayStartH}:${point.workTime.weekdayStartM} - ${point.workTime.weekdayEndH}:00'
                                                              : '${point.workTime.weekdayStartH}:${point.workTime.weekdayStartM} - ${point.workTime.weekdayEndH}:${point.workTime.weekdayEndM}',
                                          style: TextStyle(color: DGREY),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 5),
                                    //  Thursday
                                    Row(
                                      children: [
                                        SizedBox(width: 20),
                                        Text(
                                          'Thursday',
                                          style: TextStyle(color: DGREY),
                                        ),
                                        SizedBox(width: 10),
                                        Text(
                                          point.workTime.weekdayStartH == 24
                                              ? 'All day'
                                              : point.workTime.weekdayStartH < 0
                                                  ? "Doesn't working"
                                                  : point.workTime.weekdayStartM ==
                                                              0 &&
                                                          point.workTime
                                                                  .weekdayEndM ==
                                                              0
                                                      ? '${point.workTime.weekdayStartH}:00 - ${point.workTime.weekdayEndH}:00'
                                                      : point.workTime
                                                                  .weekdayStartM ==
                                                              0
                                                          ? '${point.workTime.weekdayStartH}:00 - ${point.workTime.weekdayEndH}:${point.workTime.weekdayEndM}'
                                                          : point.workTime
                                                                      .weekdayEndM ==
                                                                  0
                                                              ? '${point.workTime.weekdayStartH}:${point.workTime.weekdayStartM} - ${point.workTime.weekdayEndH}:00'
                                                              : '${point.workTime.weekdayStartH}:${point.workTime.weekdayStartM} - ${point.workTime.weekdayEndH}:${point.workTime.weekdayEndM}',
                                          style: TextStyle(color: DGREY),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 5),
                                    //  Friday
                                    Row(
                                      children: [
                                        SizedBox(width: 20),
                                        Text(
                                          'Friday',
                                          style: TextStyle(color: DGREY),
                                        ),
                                        SizedBox(width: 10),
                                        Text(
                                          point.workTime.weekdayStartH == 24
                                              ? 'All day'
                                              : point.workTime.weekdayStartH < 0
                                                  ? "Doesn't working"
                                                  : point.workTime.weekdayStartM ==
                                                              0 &&
                                                          point.workTime
                                                                  .weekdayEndM ==
                                                              0
                                                      ? '${point.workTime.weekdayStartH}:00 - ${point.workTime.weekdayEndH}:00'
                                                      : point.workTime
                                                                  .weekdayStartM ==
                                                              0
                                                          ? '${point.workTime.weekdayStartH}:00 - ${point.workTime.weekdayEndH}:${point.workTime.weekdayEndM}'
                                                          : point.workTime
                                                                      .weekdayEndM ==
                                                                  0
                                                              ? '${point.workTime.weekdayStartH}:${point.workTime.weekdayStartM} - ${point.workTime.weekdayEndH}:00'
                                                              : '${point.workTime.weekdayStartH}:${point.workTime.weekdayStartM} - ${point.workTime.weekdayEndH}:${point.workTime.weekdayEndM}',
                                          style: TextStyle(color: DGREY),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 5),

                                    //  Saturday
                                    Row(
                                      children: [
                                        SizedBox(width: 20),
                                        Text(
                                          'Saturday',
                                          style: TextStyle(color: DGREY),
                                        ),
                                        SizedBox(width: 10),
                                        Text(
                                          point.workTime.saturdayStartH == 24
                                              ? 'All day'
                                              : point.workTime.saturdayStartH <
                                                      0
                                                  ? "Doesn't working"
                                                  : point.workTime.saturdayStartM ==
                                                              0 &&
                                                          point.workTime
                                                                  .saturdayEndM ==
                                                              0
                                                      ? '${point.workTime.saturdayStartH}:00 - ${point.workTime.saturdayEndH}:00'
                                                      : point.workTime
                                                                  .saturdayStartM ==
                                                              0
                                                          ? '${point.workTime.saturdayStartH}:00 - ${point.workTime.saturdayEndH}:${point.workTime.saturdayEndM}'
                                                          : point.workTime
                                                                      .saturdayEndM ==
                                                                  0
                                                              ? '${point.workTime.saturdayStartH}:${point.workTime.saturdayStartM} - ${point.workTime.saturdayEndH}:00'
                                                              : '${point.workTime.saturdayStartH}:${point.workTime.saturdayStartM} - ${point.workTime.saturdayEndH}:${point.workTime.saturdayEndM}',
                                          style: TextStyle(color: DGREY),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 5),
                                    //  Sunday
                                    Row(
                                      children: [
                                        SizedBox(width: 20),
                                        Text(
                                          'Sunday',
                                          style: TextStyle(color: DGREY),
                                        ),
                                        SizedBox(width: 10),
                                        Text(
                                          point.workTime.sundayStartH == 24
                                              ? 'All day'
                                              : point.workTime.sundayStartH < 0
                                                  ? "Doesn't working"
                                                  : point.workTime.sundayStartM ==
                                                              0 &&
                                                          point.workTime
                                                                  .sundayStartH ==
                                                              0
                                                      ? '${point.workTime.sundayStartH}:00 - ${point.workTime.sundayEndH}:00'
                                                      : point.workTime
                                                                  .sundayStartM ==
                                                              0
                                                          ? '${point.workTime.sundayStartH}:00 - ${point.workTime.sundayEndH}:${point.workTime.sundayEndM}'
                                                          : point.workTime
                                                                      .sundayEndM ==
                                                                  0
                                                              ? '${point.workTime.sundayStartH}:${point.workTime.sundayStartM} - ${point.workTime.sundayEndH}:00'
                                                              : '${point.workTime.sundayStartH}:${point.workTime.sundayStartM} - ${point.workTime.sundayEndH}:${point.workTime.sundayEndM}',
                                          style: TextStyle(color: DGREY),
                                        ),
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
                                        style: TextStyle(color: GREEN)),
                                  ),
                                ],
                              ));
                    },
                    child: Text(
                      workTimeStdH == 24
                          ? 'All day'
                          : workTimeStdM == 0 && workTimeEtdM == 0
                              ? '$workTimeStdH:00 - $workTimeEtdH:00'
                              : workTimeStdM == 0
                                  ? '$workTimeStdH:00 - $workTimeEtdH:$workTimeEtdM'
                                  : workTimeEtdM == 0
                                      ? '$workTimeStdH:$workTimeStdM - $workTimeEtdH:00'
                                      : '$workTimeStdH:$workTimeStdM - $workTimeEtdH:$workTimeEtdM',
                      style: TextStyle(color: DGREY),
                    ),
                  ),
                  SizedBox(width: 5),
                  Icon(
                    FontAwesomeIcons.chevronDown,
                    color: DGREY,
                    size: 15,
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
                  color: GREEN,
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Icon(
                    FontAwesomeIcons.xmark,
                    color: DGREEN,
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
