import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:go_kart/Pages/Mileage.dart';
import 'package:go_kart/Pages/Speedometer.dart';
import 'package:go_kart/Pages/map_page.dart';
import 'package:go_kart/dataclasses/vehicle_data.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:http/http.dart' as http;
import '../Widgets/NavBar.dart';
import '../notification.dart';
import 'Fuel.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final StreamController _streamController = StreamController();

  @override
  void initState() {
    super.initState();
    Provider.of<VehicleData>(context, listen: false).getInfo();
    Timer.periodic(const Duration(seconds: 1), (timer) {
      Provider.of<VehicleData>(context, listen: false).update();
    });
  }

  @override
  void dispose() {
    _streamController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    NotificationService ns = NotificationService();
    ns.instantNofitication();

    return Scaffold(
        drawer: const NavBar(),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text(
            'Dashboard',
            style: TextStyle(fontSize: 28, color: Colors.white),
          ),
        ),
        backgroundColor: Colors.black38,
        body: SafeArea(
          child: Expanded(
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                //Fuel container, Map
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (BuildContext context) => FuelPage()));
                        },
                        child: Container(
                          width: 100,
                          height: 45,
                          decoration: BoxDecoration(
                            color: Colors.white12,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20.0, vertical: 15.0),
                            child: Text(
                              'Mileage',
                              style:
                                  TextStyle(fontSize: 16, color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (BuildContext context) => MapPage()));
                        },
                        child: Container(
                          width: 100,
                          height: 45,
                          decoration: BoxDecoration(
                            color: Colors.white12,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20.0, vertical: 15.0),
                            child: Text(
                              'Map',
                              style:
                                  TextStyle(fontSize: 16, color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                //speedometer
                SizedBox(height: 10),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) =>
                          ChangeNotifierProvider<VehicleData>.value(
                              value: VehicleData(), child: SpeedometerPage()),
                    ));
                  },
                  child: Container(
                    width: 300,
                    height: 410, //450
                    decoration: BoxDecoration(
                      color: Colors.white12,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 10.0),
                      child: Column(
                        children: [
                          const Text(
                            'Speedometer',
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                          Consumer<VehicleData>(builder: (_, data, child) {
                            if (data.size == 0) {
                              return CircularProgressIndicator();
                            }
                            return Column(
                              children: [
                                SfRadialGauge(
                                  axes: [
                                    RadialAxis(
                                      minimum: 0,
                                      maximum: 150,
                                      interval: 10,
                                      ranges: [
                                        GaugeRange(
                                          startValue: 0,
                                          endValue: 50,
                                          color: Colors.white,
                                        ),
                                        GaugeRange(
                                          startValue: 50,
                                          endValue: 100,
                                          color: Colors.white,
                                        ),
                                        GaugeRange(
                                          startValue: 100,
                                          endValue: 150,
                                          color: Colors.white,
                                        ),
                                      ],
                                      useRangeColorForAxis: true,
                                      pointers: [
                                        NeedlePointer(
                                          needleColor: Colors.white,
                                          value: double.parse(data
                                              .vehicleList.last.speed
                                              .toString()),
                                          enableAnimation: true,
                                          enableDragging: true,
                                        )
                                      ],
                                    )
                                  ],
                                ),
                                Text(
                                  data.vehicleList.last.speed.toString(),
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16),
                                )
                              ],
                            );
                          })
                        ],
                      ),
                    ),
                  ),
                ),
                //Temp,Gear,Mileage
                SizedBox(
                  height: 9,
                ),
                //Temp,Gear,Mileage
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 300,
                        height: 90,
                        decoration: BoxDecoration(
                          color: Colors.white12,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 10.0),
                          child: Column(
                            children: [
                              Consumer<VehicleData>(builder: (_, data, __) {
                                if (data.size == 0) {
                                  return CircularProgressIndicator();
                                }
                                return Container(
                                  child: SfLinearGauge(
                                    markerPointers: [
                                      LinearShapePointer(
                                          value: double.parse(
                                              data.vehicleList.last.speed),
                                          color: Colors.white)
                                    ],
                                    minorTicksPerInterval: 2,
                                    useRangeColorForAxis: true,
                                    animateAxis: true,
                                    axisTrackStyle:
                                        LinearAxisTrackStyle(thickness: 1),
                                    ranges: const <LinearGaugeRange>[
                                      LinearGaugeRange(
                                        startValue: 0,
                                        endValue: 33,
                                        position: LinearElementPosition.inside,
                                        color: Color(0xffF45656),
                                      ),
                                      LinearGaugeRange(
                                        startValue: 33,
                                        endValue: 66,
                                        position: LinearElementPosition.cross,
                                        color: Color(0xffFFC93E),
                                      ),
                                      LinearGaugeRange(
                                        startValue: 66,
                                        endValue: 100,
                                        position: LinearElementPosition.outside,
                                        color: Color(0xff0DC9AB),
                                      )
                                    ],
                                  ),
                                );
                              }),
                              const Text('Fuel',
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.white)),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      // SafeArea(
                      //   child: Container(
                      //     width: 100,
                      //     height: 50,
                      //     decoration: BoxDecoration(
                      //       color: Colors.white12,
                      //       borderRadius: BorderRadius.circular(12),
                      //     ),
                      //     child: Padding(
                      //       padding: const EdgeInsets.symmetric(
                      //           horizontal: 20.0, vertical: 15.0),
                      //       child: Text(
                      //         'Gear',
                      //         style: TextStyle(fontSize: 16, color: Colors.white),
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  MileagePage()));
                        },
                        child: SafeArea(
                          child: Container(
                            width: 300,
                            height: 70,
                            decoration: BoxDecoration(
                              color: Colors.white12,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20.0, vertical: 11.0),
                              child: Text(
                                'Temp',
                                style: TextStyle(
                                    fontSize: 16, color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
