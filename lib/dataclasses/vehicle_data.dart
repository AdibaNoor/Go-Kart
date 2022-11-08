import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:go_kart/dataclasses/vehicle.dart';
import 'package:http/http.dart' as http;

class VehicleData with ChangeNotifier {
  List<Vehicle> vehicleList = [];
  Vehicle get currentInfo => vehicleList.last;
  get size => vehicleList.length;

  Future<void> update() async {
    var url = Uri.parse(
        "https://rfid-door-lock-dc802-default-rtdb.firebaseio.com/history.json");
    final response = await http.get(url);
    try {
      final vehicleHistory = json.decode(response.body) as Map;
      if (vehicleList.isEmpty) {
        getInfo();
      }

      if (vehicleHistory.entries.last.key == vehicleList.last.id) {
        return;
      }
      var lastEntry = vehicleHistory.entries.last;
      Vehicle vehicle = Vehicle(
          speed: lastEntry.value['speed'].toString(),
          fuel: lastEntry.value['speed'].toString(),
          temp: lastEntry.value['speed'].toString(),
          loc: lastEntry.value['speed'].toString(),
          id: lastEntry.key.toString(),
          dateTime: DateTime.parse(lastEntry.value['dateTime'].toString()));
      vehicleList.add(vehicle);

      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  Future<void> getInfo() async {
    vehicleList.clear();
    var url = Uri.parse(
        "https://rfid-door-lock-dc802-default-rtdb.firebaseio.com/history.json");
    final response = await http.get(url);
    try {
      final vehicleHistory = json.decode(response.body) as Map;

      for (var vehicleInfo in vehicleHistory.entries) {
        vehicleList.add(Vehicle(
            speed: vehicleInfo.value['speed'].toString(),
            fuel: vehicleInfo.value['fuel'].toString(),
            temp: vehicleInfo.value['temp'].toString(),
            loc: vehicleInfo.value['loc'].toString(),
            id: vehicleInfo.key.toString(),
            dateTime:
                DateTime.parse(vehicleInfo.value['dateTime'].toString())));
      }
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }
}
