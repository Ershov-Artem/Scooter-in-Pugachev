import 'package:flutter/material.dart';

import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';

import '../widgets/customButton.dart';

class HomeForm extends StatefulWidget {
  @override
  _HomeFormState createState() => _HomeFormState();
}

class _HomeFormState extends State<HomeForm> {
  var zoom = 13.0;

  List<Marker> _markers = [];

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _buildMap(),
        Padding(
            padding: EdgeInsets.only(bottom: 20),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: CustomButton(
                height: 130,
                width: 130,
                onTap: () => Navigator.of(context).pushNamed('/QRScan'),
                icon: Icon(
                  Icons.qr_code,
                  size: 70,
                ),
                decoration: BoxDecoration(
                    color: Colors.blue,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 10,
                        blurRadius: 10,
                        offset: Offset(0, -2),
                      )
                    ]),
              ),
            ))
      ],
    );
  }

  Widget _buildMap() => FlutterMap(
        options: new MapOptions(
          center: new LatLng(52.016610402762396, 48.80186056209476),
          zoom: zoom,
        ),
        layers: [
          new TileLayerOptions(
              urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
              subdomains: ['a', 'b', 'c']),
          MarkerLayerOptions(
            markers: _markers,
          )
        ],
      );
}
