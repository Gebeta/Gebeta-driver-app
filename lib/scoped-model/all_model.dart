import 'dart:convert';

import 'package:app_drivers/models/address.dart';
import 'package:app_drivers/models/driver.model.dart';
import 'package:scoped_model/scoped_model.dart';

import 'package:http/http.dart' as http;

String link = "http://192.168.8.140:3000";

mixin AllModels on Model {
  Driver _authenticatedUser = Driver(id: "", email: "", token: "");
}

mixin DriverModel on AllModels {
  Driver get getDriver {
    return _authenticatedUser;
  }

  Future<Map<String, dynamic>> checkAccepted(id) async {
    Uri url = Uri.parse("$link/driver/$id");
    final http.Response response =
        await http.get(url, headers: {'Content-Type': 'application/json'});

    final Map<String, dynamic> responseData = json.decode(response.body);
    print(responseData);
    if (responseData['isAccepted']) {
      return {"isAccepted": true};
    } else {
      return {"isAccepted": false};
    }
  }

  Future<Map<String, dynamic>> signUp(
    String fname,
    String lname,
    String password,
    String email,
    String phoneNo,
  ) async {
    final Map<String, dynamic> userData = {
      "first_name": fname,
      "last_name": lname,
      "password": password,
      "email": email,
      "phone_no": phoneNo,
    };
    Uri url = Uri.parse("$link/auth/driversignup");
    final http.Response response = await http.post(url,
        body: json.encode(userData),
        headers: {'Content-Type': 'application/json'});

    final Map<String, dynamic> responseData = json.decode(response.body);
    print("Driver Signup");
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
    return {
      'success': !hasError,
      'message': message,
      "id": responseData['_id']
    };
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

  updateVehicle(id, carModel, carPlate) async {
    Uri url = Uri.parse("$link/driver/update");
    final Map<String, dynamic> carData = {
      "driverId": id,
      "car": carModel,
      "car_plate": carPlate,
    };
    print(json.encode(carData));
    http.Response response = await http.put(url,
        body: json.encode(carData),
        headers: {"Content-Type": "application/json"});
    final Map<String, dynamic> responseData = json.decode(response.body);
    print("responseData");
    print(responseData);
  }

  toggleActive(latitude,longtiude, id) async {
    Uri url = Uri.parse("$link/driver/ul/$id");
    Address userAddress = Address(latitude, longtiude);
    String jsonUser = jsonEncode(userAddress);

    Map<String, dynamic> data = {
      "address": jsonUser,
    };
    http.Response response = await http.put(url,
        body: json.encode(data), headers: {"Content-Type": "application/json"});
    final Map<String, dynamic> responseData = json.decode(response.body);
    print("object");
    print(responseData);
    return responseData;
  }

  addProfilePicture(image, id) async {
    Uri url = Uri.parse("$link/driver/upload");

    var request = http.MultipartRequest("POST", url);

    var pic = await http.MultipartFile.fromPath("driverImg", image.path);
    request.files.add(pic);
    var response = await request.send();

    var responseData = response.stream.toBytes();
    // var responseString = String.fromCharCodes(responseData);
    print("responseData");
    print(responseData);
    // final http.Response response = await http.post(url,body: json.encode(userData));
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
