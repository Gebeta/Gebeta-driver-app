import 'package:flutter/material.dart';

class SigninScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body:Column(
          children: [
            SizedBox(height:35.0,),
            Image(
              image: AssetImage("images/logo_1.png"),
              width: 10000.0,
              height: 250.0,
              alignment: Alignment.center,
            ),
            SizedBox(height: 1.0,),
            Text(
              "Register as a Driver",
              style: TextStyle(fontSize: 40.0 ),
              textAlign: TextAlign.center,
            ),


            Padding(
              padding: EdgeInsets.all(20.0),
              child: Column(
                children:

                [SizedBox(height: 1.0,),
              TextField(
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
                  keyboardType: TextInputType.phone ,
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
                    color:  Colors.yellow,
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
                    onPressed: (){
                      print("login button iss clicked");
                    }
                    ,
                  )
                ],
              ),
            ),

            FlatButton(
              onPressed: ()
              {
                print("clicked");
              } ,
              child: Text(
                "already have an account? Login here.",
              ),
            )

          ],

        )
    );
  }
}
