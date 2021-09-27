import 'dart:async';

import 'package:app_drivers/constants.dart';
import 'package:app_drivers/scoped-model/main_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_geofire/flutter_geofire.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:scoped_model/scoped_model.dart';

class HomeTabPage extends StatefulWidget {
  @override
  _HomeTabPageState createState() => _HomeTabPageState();
}

class _HomeTabPageState extends State<HomeTabPage> {
  Completer<GoogleMapController> _controllerGoogleMap = Completer();

  late GoogleMapController newGoogleMapController;

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

  @override
  Widget build(BuildContext context) {
    return Stack(
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
          top: 165,
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
        Container(
          height: 140.0,
          width: double.infinity,
          color: Colors.black54,
        ),
        Positioned(
            top: 60.0,
            left: 0.0,
            right: 0.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.0,
                    ),
                    child: ScopedModelDescendant(
                        builder: (context, Widget child, MainModel model) {
                      return ElevatedButton(
                        onPressed: () {
                          model.toggleActive(currrentPosition.latitude,currrentPosition.longitude, model.getDriver.id);
                        },
                        style: ElevatedButton.styleFrom(
                          primary: gsecondaryColor,
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(17.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Online Now"),
                              Icon(
                                Icons.phone_android,
                                color: Colors.white,
                                size: 26.0,
                              )
                            ],
                          ),
                        ),
                      );
                    })),
              ],
            ))
      ],
    );
  }

  // void MakeDriverOnline(){
  //   Geofire.initialize("availableDriver");
  //   Geofire.setLocation(id, latitude, longitude)
  // }
}
