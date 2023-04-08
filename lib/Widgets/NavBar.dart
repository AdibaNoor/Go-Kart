import 'package:flutter/material.dart';
import 'package:go_kart/Pages/Fuel.dart';
import 'package:go_kart/Pages/Mileage.dart';
import 'package:go_kart/Pages/Speedometer.dart';
import 'package:go_kart/Pages/map_page.dart';

import '../Pages/HomePage.dart';

class NavBar extends StatelessWidget {
  const NavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.grey[900],
      elevation: 3,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xff09023f),
              Color(0xff5a5398),
              Color(0xffe7e6ee),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          )
        ),
        child: ListView(
          children: [
            //homepage
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30.0),
              child: ListTile(
                leading: const Icon(
                  Icons.home,
                  color: Colors.white,
                ),
                title: const Text(
                  'HomePage',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                onTap: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (BuildContext context) => const MyHomePage()));
                },
              ),
            ),
            //Fuel
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30.0),
              child: ListTile(
                leading: const Icon(
                  Icons.battery_3_bar_outlined,
                  color: Colors.white,
                ),
                title: const Text(
                  'Fuel',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => const FuelPage()));
                },
              ),
            ),
            //Map
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30.0),
              child: ListTile(
                leading: const Icon(
                  Icons.location_history,
                  color: Colors.white,
                ),
                title: const Text(
                  'Map',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => const MapPage()));
                },
              ),
            ),
            //Speedometer
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30.0),
              child: ListTile(
                leading: const Icon(
                  Icons.speed_outlined,
                  color: Colors.white,
                ),
                title: const Text(
                  'Speedometer',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => const SpeedometerPage()));
                },
              ),
            ),
            //Mileage
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30.0),
              child: ListTile(
                leading: const Icon(
                  Icons.av_timer,
                  color: Colors.white,
                ),
                title: const Text(
                  'Mileage',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => const MileagePage()));
                },
              ),
            ),
            //Notification
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30.0),
              child: ListTile(
                leading: const Icon(
                  Icons.notification_important_sharp,
                  color: Colors.white,
                ),
                title: const Text(
                  'Notification',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                onTap: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (BuildContext context) => const MyHomePage()));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
