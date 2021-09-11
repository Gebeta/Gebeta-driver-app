import 'package:app_drivers/AllScrees/loginscreen.dart';
import 'package:app_drivers/AllScrees/mainscreen.dart';
import 'package:app_drivers/main.dart';
import 'package:app_drivers/scoped-model/main_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:scoped_model/scoped_model.dart';

class SigninScreen extends StatefulWidget {
  static const String idScreen = "register";

  @override
  _SigninScreenState createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final Map<String, dynamic> _formData = {
    "id": null,
    "first_name": null,
    "last_name": null,
    "username": null,
    "password": null,
    "email": null,
    "phone_no": null,
    "address": null,
    "carplate": null
  };
  bool hidePwd = true;

  Widget seePwd() {
    return hidePwd == true
        ? Icon(Icons.visibility_off, color: Colors.deepOrange)
        : Icon(Icons.visibility);
  }

  void togglePwdVisibility() {
    setState(() {
      hidePwd = !hidePwd;
    });
  }

  TextEditingController passwordTextEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
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
                  "Register as a Driver",
                  style: TextStyle(fontSize: 40.0),
                  textAlign: TextAlign.center,
                ),
                Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 1.0,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          labelText: "First NAME",
                          labelStyle: TextStyle(
                            fontSize: 14.0,
                          ),
                          hintStyle: TextStyle(
                            color: Colors.deepOrange,
                            fontSize: 10.0,
                          ),
                        ),
                        validator: (value) {
                          if (value.toString().isEmpty) {
                            return 'First Name can\'t be Empty';
                          }
                        },
                        onChanged: (String value) {
                          _formData['first_name'] = value;
                        },
                        style: TextStyle(fontSize: 16.0),
                      ),
                      TextFormField(
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          labelText: "Last NAME",
                          labelStyle: TextStyle(
                            fontSize: 14.0,
                          ),
                          hintStyle: TextStyle(
                            color: Colors.deepOrange,
                            fontSize: 10.0,
                          ),
                        ),
                        validator: (value) {
                          if (value.toString().isEmpty) {
                            return 'Last Name can\'t be Empty';
                          }
                        },
                        onChanged: (String value) {
                          _formData['last_name'] = value;
                        },
                        style: TextStyle(fontSize: 16.0),
                      ),
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
                        validator: (value) {
                          if (value.toString().isEmpty ||
                              !RegExp(r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
                                  .hasMatch(value.toString())) {
                            print('Please enter a valid email');
                            return 'Please enter a valid email';
                          }
                        },
                        onChanged: (String value) {
                          _formData['email'] = value;
                        },
                        style: TextStyle(fontSize: 16.0),
                      ),
                      SizedBox(
                        height: 1.0,
                      ),
                      TextFormField(
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
                        onChanged: (String value) {
                          _formData['phone_no'] = value;
                        },
                        style: TextStyle(fontSize: 16.0),
                      ),
                      TextFormField(
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          labelText: "CAR PLATE NUMBER AA12345",
                          labelStyle: TextStyle(
                            fontSize: 14.0,
                          ),
                          hintStyle: TextStyle(
                            color: Colors.deepOrange,
                            fontSize: 10.0,
                          ),
                        ),
                        validator: (value) {
                          if (value.toString().isEmpty || value.toString().length < 7) {
                            return 'car palte can\'t be Empty';
                          }
                        },
                        onChanged: (String value) {
                          _formData['carplate'] = value;
                        },
                        style: TextStyle(fontSize: 16.0),
                      ),
                      SizedBox(
                        height: 1.0,
                      ),
                      TextFormField(
                        controller: passwordTextEditingController,
                        obscureText: hidePwd,
                        validator: (value) {
                          if (value.toString().isEmpty ||
                              value.toString().length < 6) {
                            return 'Invalid Password';
                          }
                        },
                        onChanged: (String value) {
                          _formData['password'] = value;
                        },
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
                      TextFormField(
                        obscureText: hidePwd,
                        validator: (value) {
                          if (passwordTextEditingController.text != value) {
                            return 'Passwords do not match.';
                          }
                        },
                        decoration: InputDecoration(
                          labelText: "CONFIRM PASSWORD",
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
                      SizedBox(
                        height: 30.0,
                      ),
                      ScopedModelDescendant<MainModel>(
                          builder: (context, Widget child, MainModel model) {
                        return RaisedButton(
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
                              borderRadius: new BorderRadius.circular(24.0)),
                          onPressed: () => _submmitForm(model.signUp),
                        );
                      })
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
      ),
    );
  }

//   final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

//   void registerNewUser(BuildContext context) async {
//     final User? firebaseUser = (await _firebaseAuth
//             .createUserWithEmailAndPassword(
//                 email: emailTextEditingController.text,
//                 password: passwordTextEditingController.text)
//             .catchError((errMsg) {
//       displayToastMessage("Error: " + errMsg.toString(), context);
//     }))
//         .user;

//     if (firebaseUser != null) {
//       usersRef.child(firebaseUser.uid);

//       Map userDataMap = {
//         "name": nameTextEditingController.text.trim(),
//         "email": emailTextEditingController.text.trim(),
//         "phone": phoneTextEditingController.text.trim(),
//       };

//       usersRef.child(firebaseUser.uid).set(userDataMap);
//       displayToastMessage("account created", context);

//       //Navigator.pushAndRemoveUntil(context,  MainScreen.idScreen, (route) => false);
//     } else {
//       displayToastMessage("account has not been created", context);
//     }
//   }

  displayToastMessage(String message, BuildContext context) {
    Fluttertoast.showToast(msg: message);
  }

  _submmitForm(Function signUp) async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState!.save();
    final Map<String, dynamic> response = await signUp(
        _formData['first_name'],
        _formData['last_name'],
        _formData['password'],
        _formData['email'],
        _formData['carplate'],
        "+251925272985",
        "Summit");
    print("response data " + response['success'].toString());

    if (response['success']) {
      displayToastMessage(response['message'], context);
      Navigator.pushNamedAndRemoveUntil(
          context, MainScreen.idScreen, (route) => false);
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
}
