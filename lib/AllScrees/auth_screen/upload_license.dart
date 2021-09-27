import 'dart:io';

import 'package:app_drivers/AllScrees/auth_screen/cart_info_screen.dart';
import 'package:app_drivers/constants.dart';
import 'package:app_drivers/scoped-model/main_model.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:scoped_model/scoped_model.dart';

class UploadLicense extends StatefulWidget {
  final String id;
  UploadLicense(this.id);

  @override
  _UploadLicenseState createState() => _UploadLicenseState();
}

class _UploadLicenseState extends State<UploadLicense> {
  String imagePath = "";
  final picker = ImagePicker();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Upload"),
      ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 20, bottom: 20),
            alignment: Alignment.center,
            child: ClipRRect(
                // borderRadius: BorderRadius.circular(100.0),
                child: imagePath != ""
                    ? Image.file(
                        File(imagePath),
                        fit: BoxFit.cover,
                        height: 150.0,
                        width: MediaQuery.of(context).size.width * 0.8,
                      )
                    // :Text("please pick image")
                    : Text("")),
          ),
          Container(
            height: 30,
            width: 250,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [gsecondaryColor, gPrimaryColor],
                stops: [0, 1],
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(5),
              ),
            ),
            child: InkWell(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Upload driving License",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  Icon(
                    Icons.add_a_photo_outlined,
                    color: Colors.white,
                  )
                ],
              ),
              onTap: () {
                _openImagePicker(context);
              },
            ),
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                onPressed: () {
                  model.addProfilePicture(File(imagePath), widget.id);
                  Navigator.push(
        context, MaterialPageRoute(builder: (context) => CarInfoScreen(widget.id)));
                    } 
                );
          })
        ],
      ),
    );
  }

  void _openImagePicker(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            height: 170,
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                Text("Pick an Image"),
                SizedBox(height: 10.0),
                TextButton(
                  onPressed: () {
                    _getImage(context, ImageSource.camera);
                  },
                  child: Text("Use Camera"),
                ),
                SizedBox(height: 5.0),
                TextButton(
                  onPressed: () {
                    _getImage(context, ImageSource.gallery);
                  },
                  child: Text("Use Gallery"),
                ),
              ],
            ),
          );
        });
  }

  void _getImage(BuildContext context, ImageSource source) async {
    final pickedImage =
        (await picker.pickImage(source: source, maxWidth: 400.0));
    if (pickedImage != null) {
      Navigator.pop(context);
      setState(() {
        imagePath = pickedImage.path;
        print(imagePath);
      });
    }
  }
}
