import 'package:app_drivers/AllScrees/mainscreen.dart';
import 'package:app_drivers/scoped-model/main_model.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class WaitingScreen extends StatefulWidget {
  final String id;
  static const String idScreen = "waiting";
  WaitingScreen(this.id);

  @override
  _WaitingScreenState createState() => _WaitingScreenState();
}

class _WaitingScreenState extends State<WaitingScreen> {
  bool isAccepted = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar:AppBar(
         title: Text("Waiting Screen")
       ),
       body: ScopedModelDescendant(builder: (context, Widget child, MainModel model){
         checkAccepted(model.checkAccepted,widget.id);
         return  Center(child: isAccepted? Column(
           children: [
             Text("Wait until you're accepted"),
             CircularProgressIndicator()
           ],
         ): ElevatedButton(onPressed: (){
           Navigator.pushNamedAndRemoveUntil(
          context, MainScreen.idScreen, (route) => false);
         }, child: Text("Navigate to Main Screen"))
         );
       })
    );
  }

  checkAccepted(Function checkAccepted, id) async {
    var response = await checkAccepted(id);

    if(response["isAccepted"]){
      setState(() {
        isAccepted = true;
      });
    }
    else{
      setState(() {
        isAccepted = false;
      });
    }
  }
}