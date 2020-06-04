//import 'dart:async';
//import 'package:google_maps_webservice/places.dart';
//import 'package:flutter_google_places/flutter_google_places.dart';
//import 'package:flutter/material.dart';
//import 'package:google_maps_flutter/google_maps_flutter.dart';
//import 'package:location/location.dart' as LocationManager;
//import 'place_detail.dart';
//
//const kGoogleApiKey = "AIzaSyBAHYEYWa74mOjwWSBAl0JPc_zCW7Mnpbk";
//GoogleMapsPlaces _places = GoogleMapsPlaces(apiKey: kGoogleApiKey);
//
//
//class Home extends StatefulWidget {
//  @override
//  State<StatefulWidget> createState() {
//    return HomeState();
//  }
//}
//
//class HomeState extends State<Home> {
//  final homeScaffoldKey = GlobalKey<ScaffoldState>();
//  GoogleMapController mapController;
//  List<PlacesSearchResult> places = [];
//  bool isLoading = false;
//  String errorMessage;
//
//  @override
//  Widget build(BuildContext context) {
//    Widget expandedChild;
//    if (isLoading) {
//      expandedChild = Center(child: CircularProgressIndicator(value: null));
//    } else if (errorMessage != null) {
//      expandedChild = Center(
//        child: Text(errorMessage),
//      );
//    } else {
//      expandedChild = buildPlacesList();
//    }
//
//    return Scaffold(
//        key: homeScaffoldKey,
//        appBar: AppBar(
//          title: const Text("PlaceZ"),
//          actions: <Widget>[
//            isLoading
//                ? IconButton(
//              icon: Icon(Icons.timer),
//              onPressed: () {},
//            )
//                : IconButton(
//              icon: Icon(Icons.refresh),
//              onPressed: () {
//                refresh();
//              },
//            ),
//            IconButton(
//              icon: Icon(Icons.search),
//              onPressed: () {
//                _handlePressButton();
//              },
//            ),
//          ],
//        ),
//        body: Column(
//          children: <Widget>[
//            Container(
//              child: SizedBox(
//                  height: 200.0,
//                  child: GoogleMap(
//                      onMapCreated: _onMapCreated,
//                      options: GoogleMap(
//                          myLocationEnabled: true,
//                          cameraPosition:
//                          const CameraPosition(target: LatLng(13.3874029936, 99.9240560449))))),
//            ),
//            Expanded(child: expandedChild)
//          ],
//        ));
//  }
//
//  void refresh() async {
//    final center = await getUserLocation();
//
//    mapController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
//        target: center == null ? LatLng(0, 0) : center, zoom: 15.0)));
//    getNearbyPlaces(center);
//  }
//
//  void _onMapCreated(GoogleMapController controller) async {
//    mapController = controller;
//    refresh();
//  }
//
//  Future<LatLng> getUserLocation() async {
//    var currentLocation = <String, double>{};
//    final location = LocationManager.Location();
//    try {
//      currentLocation = (await location.getLocation()) as Map<String, double>;
//      final lat = currentLocation["latitude"];
//      final lng = currentLocation["longitude"];
//      final center = LatLng(lat, lng);
//      return center;
//    } on Exception {
//      currentLocation = null;
//      return null;
//    }
//  }
//
//  void getNearbyPlaces(LatLng center) async {
//    setState(() {
//      this.isLoading = true;
//      this.errorMessage = null;
//    });
//
//    final location = Location(center.latitude, center.longitude);
//    final result = await _places.searchNearbyWithRadius(location, 2500);
//    setState(() {
//      this.isLoading = false;
//      if (result.status == "OK") {
//        this.places = result.results;
//        result.results.forEach((f) {
//          final markerOptions = MarkerOptions(
//              position:
//              LatLng(f.geometry.location.lat, f.geometry.location.lng),
//              infoWindowText: InfoWindowText("${f.name}", "${f.types?.first}"));
//          mapController.addMarker(markerOptions);
//        });
//      } else {
//        this.errorMessage = result.errorMessage;
//      }
//    });
//  }
//
//  void onError(PlacesAutocompleteResponse response) {
//    homeScaffoldKey.currentState.showSnackBar(
//      SnackBar(content: Text(response.errorMessage)),
//    );
//  }
//
//  Future<void> _handlePressButton() async {
//    try {
//      final center = await getUserLocation();
//      Prediction p = await PlacesAutocomplete.show(
//          context: context,
//          strictbounds: center == null ? false : true,
//          apiKey: kGoogleApiKey,
//          onError: onError,
//          mode: Mode.fullscreen,
//          language: "en",
//          location: center == null
//              ? null
//              : Location(center.latitude, center.longitude),
//          radius: center == null ? null : 10000);
//
//      showDetailPlace(p.placeId);
//    } catch (e) {
//      return;
//    }
//  }
//
//  Future<Null> showDetailPlace(String placeId) async {
//    if (placeId != null) {
//      Navigator.push(
//        context,
//        MaterialPageRoute(builder: (context) => PlaceDetailWidget(placeId)),
//      );
//    }
//  }
//
//  ListView buildPlacesList() {
//    final placesWidget = places.map((f) {
//      List<Widget> list = [
//        Padding(
//          padding: EdgeInsets.only(bottom: 4.0),
//          child: Text(
//            f.name,
//            style: Theme.of(context).textTheme.subtitle,
//          ),
//        )
//      ];
//      if (f.formattedAddress != null) {
//        list.add(Padding(
//          padding: EdgeInsets.only(bottom: 2.0),
//          child: Text(
//            f.formattedAddress,
//            style: Theme.of(context).textTheme.subtitle,
//          ),
//        ));
//      }
//
//      if (f.vicinity != null) {
//        list.add(Padding(
//          padding: EdgeInsets.only(bottom: 2.0),
//          child: Text(
//            f.vicinity,
//            style: Theme.of(context).textTheme.body1,
//          ),
//        ));
//      }
//
//      if (f.types?.first != null) {
//        list.add(Padding(
//          padding: EdgeInsets.only(bottom: 2.0),
//          child: Text(
//            f.types.first,
//            style: Theme.of(context).textTheme.caption,
//          ),
//        ));
//      }
//
//      return Padding(
//        padding: EdgeInsets.only(top: 4.0, bottom: 4.0, left: 8.0, right: 8.0),
//        child: Card(
//          child: InkWell(
//            onTap: () {
//              showDetailPlace(f.placeId);
//            },
//            highlightColor: Colors.lightBlueAccent,
//            splashColor: Colors.red,
//            child: Padding(
//              padding: EdgeInsets.all(8.0),
//              child: Column(
//                mainAxisAlignment: MainAxisAlignment.start,
//                crossAxisAlignment: CrossAxisAlignment.start,
//                children: list,
//              ),
//            ),
//          ),
//        ),
//      );
//    }).toList();
//
//    return ListView(shrinkWrap: true, children: placesWidget);
//  }
//}
//import 'package:flutter/material.dart';
//import 'package:google_maps_flutter/google_maps_flutter.dart';
//import 'package:location/location.dart';
//
//class Gmap extends StatefulWidget {
//  @override
//  _GmapState createState() => _GmapState();
//}
//
//class _GmapState extends State<Gmap> {
//  GoogleMapController mapController;
//
//  LocationData _currentPosition;
//
//  var lng, lat, loading;
//  bool sitiosToggle = false;
//
//  var sitios = [];
//  Set<Marker> allMarkers = Set();
//
//  void _onMapCreated(GoogleMapController controller) {
//    mapController = controller;
//  }
//
//  Set<Circle> circles = Set.from([
//    Circle(
//        circleId: CircleId("myCircle"),
//        radius: 500,
//        fillColor: Color.fromRGBO(171, 39, 133, 0.1),
//        strokeColor: Color.fromRGBO(171, 39, 133, 0.5),
//        onTap: () {
//          print('circle pressed');
//        })
//  ]);
//
////  populateClients() {
////    sitios = [];
////
////    Firestore.instance.collection('retailers').getDocuments().then((docs) {
////      if (docs.documents.isNotEmpty) {
////        setState(() {
////          sitiosToggle = true;
////        });
////        for (int i = 0; i < docs.documents.length; ++i) {
////          initMarker(docs.documents[i].data);
////        }
////      }
////    });
////  }
//
//  initMarker(afro) {
//    allMarkers.add(Marker(
//      markerId: MarkerId('test01'),
//      draggable: false,
//      infoWindow: InfoWindow(title: 'ร้านอาหารลุงแดง', snippet: 'บางแสน 20'),
//      position: LatLng(13.387157,99.923293),
//    ));
//  }
//
//  Set<Marker> marker = Set.from([
//    Marker(
//      markerId: MarkerId("mymarker"),
//      alpha: 0.7,
//      draggable: true,
//      infoWindow: InfoWindow(title: "mymarker", snippet: "mymakrer"),
//    )
//  ]);
//
//  @override
//  initState() {
//    circles = Set.from([
//      Circle(
//          circleId: CircleId("myCircle"),
//          radius: 500,
//          center: _createCenter(),
//          fillColor: Color.fromRGBO(171, 39, 133, 0.1),
//          strokeColor: Color.fromRGBO(171, 39, 133, 0.5),
//          onTap: () {
//            print('circle pressed');
//          })
//    ]);
//
//    loading = true;
//    _getLocation();
//    super.initState();
//  }
//
//  _getLocation() async {
//    var location = new Location();
//    try {
//      _currentPosition = await location.getLocation();
//      setState(() {
//        lat = _currentPosition.latitude;
//        lng = _currentPosition.longitude;
//        loading = false;
//        print(_currentPosition);
//      }); //rebuild the widget after getting the current location of the user
//    } on Exception {
//      _currentPosition = null;
//    }
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return MaterialApp(
//      theme: ThemeData(
//        primaryTextTheme: TextTheme(
//          title: TextStyle(color: Colors.white),
//        ),
//      ),
//      home: Scaffold(
//        appBar: PreferredSize(
//          preferredSize: Size.fromHeight(100.0),
//          child: new AppBar(
//            leading: BackButton(
//                color: Colors.black,
//              onPressed: () => Navigator.of(context).pop(),
//            ),
//            centerTitle: true,
//            title: Text(
//              'YOUR NEAREST STORES',
//              textAlign: TextAlign.center,
//            ),
//          ),
//        ),
//        body: Stack(
//          children: <Widget>[
//            loading == false
//                ? GoogleMap(
//              // circles: circles,
//              mapType: MapType.normal,
//              circles: circles,
//              myLocationButtonEnabled: true,
//              myLocationEnabled: true,
//              onMapCreated: _onMapCreated,
//              zoomGesturesEnabled: true,
//              compassEnabled: true,
//              scrollGesturesEnabled: true,
//              rotateGesturesEnabled: true,
//              tiltGesturesEnabled: true,
//              initialCameraPosition: CameraPosition(
//                target: LatLng(lat, lng),
//                zoom: 15.0,
//              ),
//              markers: allMarkers,
//            )
//                : Center(
//              child: CircularProgressIndicator(),
//            ),
//            Positioned(
//                top: MediaQuery.of(context).size.height -
//                    (MediaQuery.of(context).size.height - 70.0),
//                right: 10.0,
//                child: FloatingActionButton(
//                  onPressed: () {
////                    populateClients();
//                  },
//                  mini: true,
//                  backgroundColor: Colors.red,
//                  child: Icon(Icons.refresh),
//                )),
//          ],
//        ),
//      ),
//    );
//  }
//
//  LatLng _createCenter() {
//    return _createLatLng(13.387157 , 99.923293);
//  }
//
//  LatLng _createLatLng(double lat, double lng) {
//    return LatLng(lat, lng);
//  }
//}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';

class Gmap extends StatefulWidget {
  @override
  _Gmap createState() => _Gmap();
}

class _Gmap extends State<Gmap> {
  Position _currentPosition;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Location"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if (_currentPosition != null)
              Text(
                  "LAT: ${_currentPosition.latitude}, LNG: ${_currentPosition.longitude}"),
            FlatButton(
              child: Text("My location"),
              onPressed: () {
                _getCurrentLocation();
              },
            ),
          ],
        ),
      ),
    );
  }

  _getCurrentLocation() {
    final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;
    geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
      setState(() {
        _currentPosition = position;
//        print(position);
      });
    }).catchError((e) {
      print(e);
    });
    print(_currentPosition);
  }
}
