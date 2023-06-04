import 'package:app/data/point_data.dart';
import 'package:app/pages/map/point.dart';
import 'package:flutter/material.dart';

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
            icon: Icon(FontAwesomeIcons.circleInfo, color: firstColor),
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                        title: Text('Help'),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  FontAwesomeIcons.squareH,
                                  color: firstColor,
                                ),
                                Text('  - Veterinary Clinic'),
                              ],
                            ),
                            SizedBox(height: 16),
                            Row(
                              children: [
                                Icon(
                                  FontAwesomeIcons.basketShopping,
                                  color: firstColor,
                                ),
                                Text('  - Pet Shop'),
                              ],
                            ),
                            SizedBox(height: 16),
                            Row(
                              children: [
                                Icon(
                                  FontAwesomeIcons.paw,
                                  color: firstColor,
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
                            child: const Text('OK'),
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

//Icon(FontAwesomeIcons.circleInfo, color: firstColor,)
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
                    color: firstColor,
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

    int workTimeStdH;
    int workTimeStdM;
    int workTimeEtdH;
    int workTimeEtdM;

    if(DateNow >= 1 && DateNow <= 5){
      workTimeStdH = point.workTime.weekdayStartH;
      workTimeStdM = point.workTime.weekdayStartM;
      workTimeEtdH = point.workTime.weekdayEndH;
      workTimeEtdM = point.workTime.weekdayEndM;
    }
    else if(DateNow == 6){
      workTimeStdH = point.workTime.saturdayStartH;
      workTimeStdM = point.workTime.saturdayStartM;
      workTimeEtdH = point.workTime.saturdayEndH;
      workTimeEtdM = point.workTime.saturdayEndM;
    }
    else {
      workTimeStdH = point.workTime.sundayStartH;
      workTimeStdM = point.workTime.sundayStartM;
      workTimeEtdH = point.workTime.sundayEndH;
      workTimeEtdM = point.workTime.sundayEndM;
    }
    
    bool open = false;

    if((TimeNowH > workTimeStdH && TimeNowH < workTimeEtdH) || (TimeNowH == workTimeStdH && TimeNowM > workTimeStdM) || (TimeNowH == workTimeEtdH && TimeNowM < workTimeEtdM)){
      open = true;
    }
    else if(point.workTime.weekday2StartH > 0 && (DateNow >= 1 && DateNow <= 5)){
      int workTime2StdH = point.workTime.weekday2StartH;
      int workTime2StdM = point.workTime.weekday2StartM;
      int workTime2EtdH = point.workTime.weekday2EndH;
      int workTime2EtdM = point.workTime.weekday2EndM;
      if((TimeNowH > workTime2StdH && TimeNowH < workTime2EtdH) || (TimeNowH == workTime2StdH && TimeNowM > workTime2StdM) || (TimeNowH == workTime2EtdH && TimeNowM < workTime2EtdM)){
        open = true;
      }
    }


    return Container(
      child: SizedBox(
        height: 400,
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
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

                SizedBox(height: 5),

                Center(child: Text(point.name,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w500,
                ),
                ),),

                //  Point address

                SizedBox(height: 5),


                Row(
                  children: [
                    Icon(Icons.location_pin),
                    Text(point.address,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey
                    ),
                    ),
                  ],
                ),

                //  Point work time

                SizedBox(height: 5),


                Row(
                  children: [
                    Icon(FontAwesomeIcons.solidClock,),
                    Text( open == true ? 'Open' : 'Close',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey
                    ),
                    ),
                  ],
                ),

              ],
            ),
            Align(
              alignment: Alignment.topRight,
              child: IconButton(
                icon: Icon(FontAwesomeIcons.xmark,color: firstColor,),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        )
      ),
    );
  }
}
