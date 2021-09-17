import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:latlng2';

class MainScreen extends StatefulWidget {
  static const String idScreen = "mainScreen";

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  Completer<GoogleMapController> _controllerGoogleMap = Completer();
  late GoogleMapController newGoogleMapController;
  GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  static final CameraPosition _addisAbaba = CameraPosition(
    target: LatLng(8.9806, 38.7578),
    zoom: 14.4746,
  );
  late Position currrentPosition;

  var geoLocator = Geolocator();
  void getCurrentUserLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    currrentPosition = position;
    LatLng latLngPos = LatLng(position.latitude, position.longitude);
    CameraPosition cameraPosition = new CameraPosition(
      target: latLngPos,
      zoom: 14,
    );
    newGoogleMapController
        .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
        print("your location" + latLngPos.latitude.toString());
  }

  Widget _buildSideDrawer(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text("Dirver Name"),
            accountEmail: Text("Driver Email"),
            currentAccountPicture: CircleAvatar(
                backgroundColor:
                    Theme.of(context).platform == TargetPlatform.iOS
                        ? Colors.blue
                        : Colors.white,
                child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(width: 2, color: Colors.white),
                        borderRadius: BorderRadius.circular(50.0)),
                    child: Image.asset("assets/images/profile.png"))),
          ),
          Column(
            children: [
              ListTile(
                leading: Icon(
                  Icons.history,
                ),
                title: Text("History"),
                onTap: () {
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (context) =>
                  //             ProfileScreen(widget.model, profile)));
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.info_sharp,
                ),
                title: Text("About Us"),
                onTap: () {
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (context) =>
                  //             ProfileScreen(widget.model, profile)));
                },
              )
            ],
          )
        ],
      ),
    );
  }


  @override
  void initState() {
    // messaging.configure()
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Main Screen"),
        leading: IconButton(
          onPressed: () {
            _globalKey.currentState!.openDrawer();
            print("clicked");
          },
          icon: SvgPicture.asset('assets/icons/menu.svg'),
        ),
      ),
      key: _globalKey,
      drawer: _buildSideDrawer(context),
      body: Stack(
        children: [
          GoogleMap(
            mapType: MapType.normal,
            // myLocationButtonEnabled: true,
            initialCameraPosition: _addisAbaba,
            onMapCreated: (GoogleMapController controller) {
              _controllerGoogleMap.complete(controller);
              newGoogleMapController = controller;

              getCurrentUserLocation();
            },
          ),
          Positioned(
            right: 8,
            top: 8,
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(60), color: Colors.white),
              child: IconButton(
                icon: Icon(Icons.my_location),
                onPressed: () {
                  getCurrentUserLocation();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
