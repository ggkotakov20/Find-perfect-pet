import 'package:app/data/point_language.dart';
import 'package:app/pages/map/point.dart';
import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import 'package:app/colors.dart';

import 'package:app/pages/map/map.dart';
import 'package:app/data/point_language.dart';

final LatLng startLocation = LatLng(42.459154076868465, 27.41478978649106);

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  
  
  final LatLng arenaVet = LatLng(42.46328875843589, 27.413202759532183);

  Container _buildMapContainer() {
    return Container(
      child: FlutterMap(
        options: MapOptions(
          center: startLocation, // Specify the initial map center coordinates
          maxZoom: 16.0,
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
                point: points.position,
                builder: (ctx) => Container(
                  child: Icon(
                    Icons.location_pin,
                    color: Colors.green[400],
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
      children: [
        _buildMapContainer()
      ],
    );
  }
}
