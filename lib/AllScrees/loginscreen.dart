import 'package:app_drivers/AllScrees/mainscreen.dart';
import 'package:app_drivers/AllScrees/signinscreen.dart';
import 'package:app_drivers/scoped-model/main_model.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:scoped_model/scoped_model.dart';

class LoginScreen extends StatefulWidget {
  static const String idScreen = "login";

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final Map<String, dynamic> _formData = {
    "password": null,
    "email": null,
  };

  bool hidePwd = true;

  Widget seePwd() {
    return hidePwd == true
        ? Icon(Icons.visibility_off_outlined, color: Colors.deepOrange)
        : Icon(Icons.visibility);
  }

  void togglePwdVisibility() {
    setState(() {
      hidePwd = !hidePwd;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
                height: 250.0,
                alignment: Alignment.center,
              ),
              SizedBox(
                height: 1.0,
              ),
              Text(
                "Login as a Driver",
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
                        onChanged: (String value) {
                          _formData['email'] = value;
                        },
                        validator: (value) {
                          if (value.toString().isEmpty ||
                              !RegExp(r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
                                  .hasMatch(value.toString())) {
                            return 'Invalid Email';
                          }
                        },
                        style: TextStyle(fontSize: 16.0),
                      ),
                      SizedBox(
                        height: 1.0,
                      ),
                      TextFormField(
                        obscureText: hidePwd,
                        decoration: InputDecoration(
                          labelText: "PASSWORD",
                          labelStyle: TextStyle(
                            fontSize: 14.0,
                          ),
                          suffixIcon: IconButton(
                              onPressed: togglePwdVisibility,
                              icon: seePwd(),
                              color: Colors.deepOrange),
                          hintStyle: TextStyle(
                            color: Colors.deepOrange,
                            fontSize: 10.0,
                          ),
                        ),
                        validator: (value) {
                          if (value.toString().isEmpty ||
                              value.toString().length < 8) {
                            return 'Invalid Password';
                          }
                        },
                        onChanged: (String value) {
                          _formData['password'] = value;
                        },
                        style: TextStyle(fontSize: 16.0),
                      ),
                      SizedBox(
                        height: 40.0,
                      ),
                      ScopedModelDescendant<MainModel>(
                          builder: (context, Widget child, MainModel model) {
                        return RaisedButton(
                          color: Colors.deepOrange,
                          textColor: Colors.white,
                          child: Container(
                            height: 50.0,
                            child: Center(
                              child: Text(
                                "LOGIN",
                                style: TextStyle(fontSize: 18.0),
                              ),
                            ),
                          ),
                          shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(24.0)),
                          onPressed: () => submitForm(model.login),
                        );
                      })
                    ],
                  ),
                ),
              ),
              FlatButton(
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(
                      context, SigninScreen.idScreen, (route) => false);
                },
                child: Text(
                  "Don't have hav an account? Register here as a driver.",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  submitForm(Function login) async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState!.save();
    final Map<String, dynamic> response = await login(
      _formData['password'],
      _formData['email'],
    );
    if (response['success']) {
      Navigator.pushNamedAndRemoveUntil(
          context, MainScreen.idScreen, (route) => false);
      displayToastMessage(response['message'], context);
    } else {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("An error occured"),
              content: Text(response['message']),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text("Okay"),
                )
              ],
            );
          });
      displayToastMessage(response['message'], context);
    }
  }

  displayToastMessage(String message, BuildContext context) {
    Fluttertoast.showToast(msg: message);
  }
}
