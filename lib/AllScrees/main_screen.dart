import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:app_drivers/TabsPage/earnings_tab_page.dart';
import 'package:app_drivers/TabsPage/home_tab_page.dart';
import 'package:app_drivers/TabsPage/profile_tab_page.dart';
import 'package:app_drivers/TabsPage/orders_tab_page.dart';


class MainScreenT extends StatefulWidget {
  static const String idScreen = "mainScreenT";

  @override
  _MainScreenTState createState() => _MainScreenTState();
}

class _MainScreenTState extends State<MainScreenT>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  int selectedIndex = 0;

  void onItemClicked(int index) {
    setState(() {
      selectedIndex = index;
      tabController.index = selectedIndex;
    });
  }

  @override
  void initState() {
    tabController = TabController(length: 4, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Driver App"),
      ),
      body: TabBarView(
        physics: NeverScrollableScrollPhysics(),
        controller: tabController,
        children: [
          HomeTabPage(),
          EarningTabPage(),
          OrderTabPage(),
          ProfileTabPage()
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.credit_card), label: "Earnings"),
          BottomNavigationBarItem(icon: Icon(Icons.dvr), label: "Orders"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile")
        ],
        unselectedItemColor: Colors.black54,
        selectedItemColor: Colors.yellow,
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle: TextStyle(fontSize: 12),
        showUnselectedLabels: true,
        currentIndex: selectedIndex,
        onTap: onItemClicked,
      ),
    );
  }
}
