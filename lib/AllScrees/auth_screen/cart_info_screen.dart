import 'dart:io';

import 'package:app_drivers/AllScrees/main_screen.dart';
import 'package:app_drivers/constants.dart';
import 'package:app_drivers/scoped-model/main_model.dart';
import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';
import 'package:scoped_model/scoped_model.dart';

class CarInfoScreen extends StatefulWidget {
  static const String idScreen = "carInfo";
  final String id;
  CarInfoScreen(this.id);
  @override
  _CarInfoScreenState createState() => _CarInfoScreenState();
}

class _CarInfoScreenState extends State<CarInfoScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();


  final Map<String, dynamic> _formData = {"car_model": null, "car_plate": null};

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(
                height: 35.0,
              ),
              Image(
                image: AssetImage("images/logo_1.png"),
                width: 10000.0,
                height: 200.0,
                alignment: Alignment.center,
              ),
              SizedBox(
                height: 1.0,
              ),
              Text(
                "Enter Details",
                style: TextStyle(fontSize: 40.0),
                textAlign: TextAlign.center,
              ),
              Padding(
                padding: EdgeInsets.all(20.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 1.0,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          labelText: "Vehicle Model",
                          labelStyle: TextStyle(
                            fontSize: 14.0,
                          ),
                        ),
                        validator: (value) {
                          if (value.toString().isEmpty) {
                            return 'This field can\'t be Empty';
                          }
                        },
                        onChanged: (String value) {
                          _formData['car_model'] = value;
                        },
                      ),
                      TextFormField(
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          labelText: "Plate Number",
                          labelStyle: TextStyle(
                            fontSize: 14.0,
                          ),
                        ),
                        validator: (value) {
                          if (value.toString().isEmpty) {
                            return 'This field can\'t be Empty';
                          }
                        },
                        onChanged: (String value) {
                          _formData['car_plate'] = value;
                        },
                      ),
                      
                      
                      SizedBox(
                        height: 60.0,
                      ),
                      ScopedModelDescendant<MainModel>(
                          builder: (context, Widget child, MainModel model) {
                        return RaisedButton(
                            color: gPrimaryColor,
                            textColor: Colors.white,
                            child: Container(
                              height: 50.0,
                              child: Center(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "NEXT",
                                      style: TextStyle(fontSize: 18.0),
                                    ),
                                    Icon(
                                      Icons.arrow_forward,
                                      color: Colors.white,
                                    )
                                  ],
                                ),
                              ),
                            ),
                            shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(24.0)),
                            onPressed: () => {
                                  _submmitForm(model.updateVehicle),
                                } //_submmitForm(model.signUp),
                            );
                      })
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  

  

  _submmitForm(updateVehicle) async {
    final Map<String, dynamic> response = await updateVehicle(
        widget.id,
        _formData['car_model'],
        _formData['car_plate']);
    print(response);
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => MainScreenT()));
  }
}
