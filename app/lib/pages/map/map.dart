import 'package:app/data/point_language.dart';
import 'package:app/pages/map/point.dart';
import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

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
    return Stack(
      children:[ 
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
                            Icon(FontAwesomeIcons.squareH, color: firstColor,),
                            Text('  - Veterinary Clinic'),
                          ],
                        ),
                        SizedBox(height: 16),
                        Row(
                          children: [
                            Icon(FontAwesomeIcons.basketShopping, color: firstColor,),
                            Text('  - Pet Shop'),
                          ],
                        ),
                        SizedBox(height: 16),
                        Row(
                          children: [
                            Icon(FontAwesomeIcons.paw, color: firstColor,),
                            Text('  - Park'),
                          ],
                        ),
                      ],
                    ),
                    actions: [TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('OK'),
                    ),],
                  )
                );
              },
            ),
          ),
        ),
        ]
    );
  }
}
//Icon(FontAwesomeIcons.circleInfo, color: firstColor,)
class Map extends StatelessWidget {
  const Map({super.key});

  Container _buildMapContainer() {
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
            urlTemplate: "https://cartodb-basemaps-{s}.global.ssl.fastly.net/rastertiles/voyager/{z}/{x}/{y}.png",
            subdomains: ['a', 'b', 'c'],
            additionalOptions: {
              'variant': 'precipitation_new',
            }
          ),
          MarkerLayerOptions(
            markers: points.map((points) {
              return Marker(
                point: LatLng(points.positionX,points.positionY),
                builder: (ctx) => Container(
                  child: Icon(
                    points.type == 1 ? FontAwesomeIcons.squareH : points.type == 2 ? FontAwesomeIcons.basketShopping : points.type == 3 ? FontAwesomeIcons.paw : Icons.location_pin,
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
    return Stack(
        children:[ 
          Positioned(
                top: 0,
                bottom: 0,
                left: 0,
                right: 0,
                child: _buildMapContainer(),
              ),
          ]
      );
  }
}
