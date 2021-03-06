import 'package:app_drivers/AllScrees/auth_screen/cart_info_screen.dart';
import 'package:app_drivers/AllScrees/auth_screen/loginscreen.dart';
import 'package:app_drivers/AllScrees/main_screen.dart';
import 'package:app_drivers/AllScrees/mainscreen.dart';
import 'package:app_drivers/AllScrees/auth_screen/signinscreen.dart';
import 'package:app_drivers/constants.dart';
import 'package:app_drivers/scoped-model/main_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

void main()  async
{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
  
}

final FirebaseAuth auth = FirebaseAuth.instance;
// final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

DatabaseReference usersRef =FirebaseDatabase.instance.reference().child("users");
DatabaseReference driversRef =FirebaseDatabase.instance.reference().child("drivers");
// DatabaseReference rideRef =FirebaseDatabase.instance.reference().child("drivers").child(currentfirebaseUser.uid).child("newRide");

class MyApp extends StatelessWidget {
    final MainModel _model = MainModel();
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScopedModel<MainModel>(
      model: _model,
      child: MaterialApp(
        title: 'Gebeta Delivery',
        theme: ThemeData(
          fontFamily:  "Brand Bold" ,
          primaryColor: gsecondaryColor,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        // initialRoute:MainScreen.idScreen,
        initialRoute:  MainScreenT.idScreen,
        routes:
      {
         SigninScreen.idScreen: (context) => SigninScreen(),
         LoginScreen.idScreen: (context) => LoginScreen(),
         MainScreen.idScreen: (context) => MainScreen(),
         MainScreenT.idScreen: (context) => MainScreenT(),
         CarInfoScreen.idScreen: (context) => CarInfoScreen(""),
      },
    
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);


  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {

      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
