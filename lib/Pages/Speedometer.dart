import 'dart:async';
import 'dart:convert';
import 'package:go_kart/dataclasses/vehicle_data.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';
import 'dart:math' as math;

import '../api_key.dart';
import '../dataclasses/vehicle.dart';

class SpeedometerPage extends StatefulWidget {
  const SpeedometerPage({Key? key}) : super(key: key);

  @override
  State<SpeedometerPage> createState() => _SpeedometerPageState();
}

class _SpeedometerPageState extends State<SpeedometerPage> {
  late TooltipBehavior _tooltipBehavior;
  late ZoomPanBehavior zoomPanBehavior;
  late bool isPointerMoved;
  late ChartSeriesController chartSeriesController;
  late List<Vehicle> vehicleList = <Vehicle>[];

  @override
  void initState() {
    Provider.of<VehicleData>(context, listen: false).getInfo();
    vehicleList = Provider.of<VehicleData>(context, listen: false).vehicleList;
    Timer.periodic(const Duration(seconds: 1), (timer) {
      Provider.of<VehicleData>(context, listen: false).update();
    });
    isPointerMoved = false;
    zoomPanBehavior = ZoomPanBehavior(
      enablePinching: true,
      zoomMode: ZoomMode.x,
      enablePanning: true,
    );
    _tooltipBehavior = TooltipBehavior(enable: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Consumer<VehicleData>(
                  builder: (_, data, __) {
                    if (vehicleList.isEmpty) {
                      return CircularProgressIndicator();
                    }
                    return SfCartesianChart(
                        onChartTouchInteractionMove:
                            (ChartTouchInteractionArgs args) {
                          isPointerMoved = true;
                        },
                        onChartTouchInteractionUp:
                            (ChartTouchInteractionArgs args) {
                          isPointerMoved = false;
                        },
                        zoomPanBehavior: zoomPanBehavior,
                        title: ChartTitle(text: 'Speed of Vehical'),
                        legend: Legend(isVisible: true),
                        tooltipBehavior: _tooltipBehavior,
                        enableAxisAnimation: true,
                        series: <ChartSeries>[
                          LineSeries<Vehicle, DateTime>(
                              onRendererCreated:
                                  (ChartSeriesController controller) {
                                chartSeriesController = controller;
                              },
                              name: 'speed',
                              dataSource: data.vehicleList,
                              xValueMapper: (Vehicle sales, _) =>
                                  sales.dateTime,
                              yValueMapper: (Vehicle sales, _) =>
                                  double.parse(sales.speed),
                              dataLabelSettings:
                                  const DataLabelSettings(isVisible: true),
                              enableTooltip: true)
                        ],
                        primaryYAxis: NumericAxis(
                            edgeLabelPlacement: EdgeLabelPlacement.shift),
                        primaryXAxis: DateTimeAxis(
                            autoScrollingMode: AutoScrollingMode.end,
                            autoScrollingDelta: 10,
                            labelFormat: '{value}'));
                  },
                ))));
  }
}

// void updateBro(Timer timer) {
//   _chatData.add(SalesData(date++, math.Random().nextDouble()));
//   chartSeriesController.updateDataSource(
//       addedDataIndex: _chatData.length - 1);
// }

// Future<void> updateSpeed(Timer timer) async {
//   var url = Uri.parse(
//       "https://io.adafruit.com/api/v2/skyadav/feeds/distance/?X-AIO-Key=${ApiKey.key}");
//   final response = await http.get(url);
//   final dataBody = json.decode(response.body);
//
//   _chatData.add(SalesData(DateTime.parse(dataBody["updated_at"].toString()),
//       double.parse(dataBody["last_value"].toString())));
//   chartSeriesController.updateDataSource(
//       addedDataIndex: _chatData.length - 1);
// }

//   Future<void> getSpeeds() async {
//     var url = Uri.parse(
//         "https://io.adafruit.com/api/v2/skyadav/feeds/distance/data?X-AIO-Key=${ApiKey.key}");
//     final response = await http.get(url);
//     final dataBody = json.decode(response.body);
//     for (var d in dataBody) {
//       _chatData.insert(
//           0,
//           SalesData(DateTime.parse(d["created_at"].toString()),
//               double.parse(d["value"].toString())));
//
//       // print(DateTime.parse(d["created_at"].toString()));
//       // print(double.parse(d["value"].toString()));
//     }
//
//     print(_chatData[0].sales);
//     setState(() {});
//   }
// }
//
// class SalesData {
//   SalesData(this.year, this.sales);
//   final DateTime year;
//   final double sales;
// }
