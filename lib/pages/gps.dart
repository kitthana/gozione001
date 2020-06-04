import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class GPSlocation extends StatefulWidget {
  double lat;
  double long;
  String name;

  GPSlocation(double lat, double long, String name) {
    this.lat = lat;
    this.long = long;
    this.name = name;
  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MyGPSState(lat,long,name);
  }
}
class _MyGPSState extends State<GPSlocation> {

  double lat;
  double long;
  String name;

  _MyGPSState(double lat,double long,String name) {
    this.lat = lat;
    this.long = long;
    this.name = name;
  }

  List<Marker> allMarkers = [];

  GoogleMapController _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    allMarkers.add(Marker(
        markerId: MarkerId('myMarker'),
        draggable: true,
        onTap: () {
          _openOnGoogleMapApp(lat, long);
        },
        position: LatLng(lat, long),
        infoWindow:
            InfoWindow(title: name, snippet: "คลิกเพื่อนำทาง")));
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Maps'),
      ),
      body: Stack(children: [
        Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: GoogleMap(
            myLocationEnabled: true,
            initialCameraPosition: CameraPosition(
                target: LatLng(lat, long), zoom: 17.0),
            markers: Set.from(allMarkers),
            onMapCreated: mapCreated,
          ),
        ),
      ]),
    );
  }

  void mapCreated(controller) {
    setState(() {
      _controller = controller;
    });
  }

  _openOnGoogleMapApp(double latitude, double longitude) async {
    String googleUrl =
        'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
    if (await canLaunch(googleUrl)) {
      await launch(googleUrl);
    } else {
      // Could not open the map.
    }
  }
}
