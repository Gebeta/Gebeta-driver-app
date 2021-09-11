import 'dart:convert';

import 'package:app_drivers/models/driver.model.dart';
import 'package:scoped_model/scoped_model.dart';

import 'package:http/http.dart' as http;

String link = "http://192.168.1.9:3000";

mixin AllModels on Model {
  Driver _authenticatedUser = Driver(id: "", email: "", token: "");
}

mixin DriverModel on AllModels {
  Driver get getDriver {
    return _authenticatedUser;
  }

  Future<Map<String, dynamic>> signUp(
      String fname,
      String lname,
      String password,
      String email,
      String carplate,
      String phoneNo,
      String address) async {
    final Map<String, dynamic> userData = {
      "first_name": fname,
      "last_name": lname,
      "car_plate": carplate,
      "password": password,
      "email": email,
      "phone_no": phoneNo,
      "address": address,
      "position": address
    };
    Uri url = Uri.parse("$link/auth/driversignup");
    final http.Response response = await http.post(url,
        body: json.encode(userData),
        headers: {'Content-Type': 'application/json'});

    final Map<String, dynamic> responseData = json.decode(response.body);
    print(responseData);

    
    // SharedPreferences preferences = await SharedPreferences.getInstance();

    // preferences.setString("token", responseData['token']);
    // preferences.setString("userEmail", email);
    // preferences.setString("userId", responseData['_id']);
    bool hasError = true;
    String message = 'Something went wrong';
    if (responseData['error'] == "true") {
      hasError = true;
      message = responseData['message'];
    } else {
      hasError = false;
      message = "Signed Up successfully";
      _authenticatedUser = Driver(
          id: responseData['_id'], email: email, token: responseData['token']);
    }
    notifyListeners();
    return {'success': !hasError, 'message': message};
  }

  Future<Map<String, dynamic>> login(String password, String email) async {
    final Map<String, dynamic> authData = {
      "email": email,
      "password": password,
    };

    Uri url = Uri.parse("$link/auth/driverlogin");
    final http.Response response = await http.post(url,
        body: json.encode(authData),
        headers: {'Content-Type': 'application/json'});

    final Map<String, dynamic> responseData = json.decode(response.body);
    print("responseData");
    print(responseData);

    // SharedPreferences preferences = await SharedPreferences.getInstance();

    // preferences.setString("token", responseData['token']);
    // preferences.setString("userEmail", email);
    // preferences.setString("userId", responseData['_id']);
    bool hasError = true;
    String message = 'Something went wrong';
    if (responseData['message'] == "Incorrect Email/password") {
      hasError = true;
      message = responseData['message'];
    } else {
      hasError = false;
      message = "Logged in successfully";
      _authenticatedUser = Driver(
          id: responseData['_id'], email: email, token: responseData['token']);
    }
    notifyListeners();
    return {'success': !hasError, 'message': message};
  }

  // void autoAuthenthicate() async {
  //   SharedPreferences preferences = await SharedPreferences.getInstance();
  //   final String? token = preferences.getString("token");
  //   final String? userEmail = preferences.getString("userEmail");
  //   final String? userId = preferences.getString("userId");
  //   if (token != null) {
  //     _authenticatedUser = User(
  //         id: userId.toString(),
  //         email: userEmail.toString(),
  //         token: userEmail.toString());
  //     notifyListeners();
  //   }
  // }

  // void logout() async {
  //   _authenticatedUser = User(id: "", email: "", token: "");
  //   SharedPreferences preferences = await SharedPreferences.getInstance();
  //   preferences.remove("token");
  //   preferences.remove("userEmail");
  //   preferences.remove("userId");
  //   notifyListeners();
  // }
}
