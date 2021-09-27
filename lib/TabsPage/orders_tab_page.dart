import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class OrderTabPage extends StatelessWidget {
  const OrderTabPage({Key? key}) : super(key: key);

  void _launchMapsUrl(LatLng userLocation, LatLng driverLocation) async {
  // final url = 'https://www.google.com/maps/search/?api=1&query=$lat,$lon';
  // final directionUrl = 'https://www.google.com/maps/dir/${driverLocation.latitude},${driverLocation.longitude}/''/@${userLocation.latitude},${userLocation.latitude},15z/data=!3m1!4b1!4m16!1m6!3m5!1s0x164b8589e4c4a803:0xbae724e3b927f424!2sAddis+Ababa+University!8m2!3d9.0335063!4d38.7636817!4m8!1m1!4e1!1m5!1m1!1s0x164b8589e4c4a803:0xbae724e3b927f424!2m2!1d38.7636817!2d9.0335063';
  final directionUrl = "https://www.google.com/maps/dir/5+Kilo+Game+Zone,+Addis+Ababa/Mega+Publishing+and+Distribution+PLC,+King+George+VI+St,+Addis+Ababa/@9.0384286,38.7599328,17z/data=!3m1!4b1!4m14!4m13!1m5!1m1!1s0x164b8f901a6180a5:0xeb16a4f6fd665c1a!2m2!1d38.7613043!2d9.0408842!1m5!1m1!1s0x164b8f63d691b2ad:0xf56ef2f524806d24!2m2!1d38.76258!2d9.0358504!3e0";
  if (await canLaunch(directionUrl)) {
    await launch(directionUrl);
  } else {
    throw 'Could not launch $directionUrl';
  }
}
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text("This is Page"),
          ElevatedButton(onPressed: (){
            _launchMapsUrl(LatLng(9.0471105,38.7602693),LatLng(9.039877,38.7524169));
          }, child: Text("Navigate"))
        ],
      ),
    );
  }
}