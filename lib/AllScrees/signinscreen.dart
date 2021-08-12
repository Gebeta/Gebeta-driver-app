import 'package:app_drivers/AllScrees/loginscreen.dart';
import 'package:app_drivers/AllScrees/mainscreen.dart';
import 'package:app_drivers/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SigninScreen extends StatelessWidget {
  static const String idScreen = "register";

  TextEditingController nameTextEditingController = TextEditingController();
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController phoneTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(height: 35.0,),
              Image(
                image: AssetImage("images/logo_1.png"),
                width: 10000.0,
                height: 250.0,
                alignment: Alignment.center,
              ),
              SizedBox(height: 1.0,),
              Text(
                "Register as a Driver",
                style: TextStyle(fontSize: 40.0),
                textAlign: TextAlign.center,
              ),


              Padding(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  children:

                  [SizedBox(height: 1.0,),
                    TextField(
                      controller: nameTextEditingController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        labelText: "NAME",
                        labelStyle: TextStyle(
                          fontSize: 14.0,
                        ),
                        hintStyle: TextStyle(
                          color: Colors.deepOrange,
                          fontSize: 10.0,
                        ),
                      ),
                      style: TextStyle(fontSize: 16.0),
                    ),

                    SizedBox(height: 1.0,),
                    TextField(
                      controller: emailTextEditingController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: "EMAIL ADDRESS",
                        labelStyle: TextStyle(
                          fontSize: 14.0,
                        ),
                        hintStyle: TextStyle(
                          color: Colors.deepOrange,
                          fontSize: 10.0,
                        ),
                      ),
                      style: TextStyle(fontSize: 16.0),
                    ),
                    SizedBox(height: 1.0,),
                    TextField(
                      controller: phoneTextEditingController,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        labelText: "PHONE NUMBER",
                        labelStyle: TextStyle(
                          fontSize: 14.0,
                        ),
                        hintStyle: TextStyle(
                          color: Colors.deepOrange,
                          fontSize: 10.0,
                        ),
                      ),
                      style: TextStyle(fontSize: 16.0),
                    ),
                    SizedBox(height: 1.0,),
                    TextField(
                      controller: passwordTextEditingController,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: "PASSWORD",
                        labelStyle: TextStyle(
                          fontSize: 14.0,
                        ),
                        hintStyle: TextStyle(
                          color: Colors.deepOrange,
                          fontSize: 10.0,
                        ),
                      ),
                      style: TextStyle(fontSize: 16.0),
                    ),
                    SizedBox(height: 30.0,),
                    RaisedButton(
                      color: Colors.yellow,
                      textColor: Colors.white,
                      child: Container(
                        height: 50.0,
                        child: Center(
                          child: Text(
                            "create account ",
                            style: TextStyle(fontSize: 18.0),
                          ),
                        ),
                      ),
                      shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(24.0)
                      ),
                      onPressed: () {
                        if (nameTextEditingController.text.length < 4)
                        {
                         displayToastMessage( "name must have at least 3 characters. ", context);
                        }
                        else if(!emailTextEditingController.text.contains("@"))
                        {
                          displayToastMessage("Email address is not valid.", context);
                        }
                        else if(phoneTextEditingController.text.isEmpty)
                        {
                          displayToastMessage("phone number is nessacery.", context);
                        }
                        else if(passwordTextEditingController.text.length < 8)
                        {
                          displayToastMessage("password needs at least 8 characters.", context);
                        }
                        else
                          {
                            registerNewUser(context);
                          }

                      },
                    ),
                  ],
                ),
              ),

              FlatButton(
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(
                      context, LoginScreen.idScreen, (route) => false);
                },
                child: Text(
                  "already have an account? Login here.",
                ),
              )

            ],

          ),
        ),
      ),
    );
  }

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  void registerNewUser(BuildContext context) async
  {
    final User? firebaseUser = (await _firebaseAuth
    .createUserWithEmailAndPassword(
        email: emailTextEditingController.text,
        password: passwordTextEditingController.text
    ).catchError((errMsg){
      displayToastMessage("Error: " + errMsg.toString() ,context);
    })).user;

    if (firebaseUser != null)
    {
      usersRef.child(firebaseUser.uid);

      Map userDataMap = {
        "name": nameTextEditingController.text.trim(),
        "email": emailTextEditingController.text.trim(),
        "phone": phoneTextEditingController.text.trim(),
      };
      
      usersRef.child(firebaseUser.uid).set(userDataMap);
      displayToastMessage("account created", context);

      //Navigator.pushAndRemoveUntil(context,  MainScreen.idScreen, (route) => false);
    }
    else
    {
      displayToastMessage("account has not been created", context);
    }
  }
}
displayToastMessage (String message, BuildContext context)
  {
    Fluttertoast.showToast(msg: message);
  }
