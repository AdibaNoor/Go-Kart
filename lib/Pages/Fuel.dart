import 'dart:async';
import 'dart:convert';
import 'package:firebase_database/firebase_database.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../api_key.dart';

class FuelPage extends StatefulWidget {
  const FuelPage({Key? key}) : super(key: key);

  @override
  State<FuelPage> createState() => _FuelPageState();
}

class _FuelPageState extends State<FuelPage> {
  final List<SalesData> _chatData = <SalesData>[];
  final List<Temp> tempData = <Temp>[];
  late TooltipBehavior _tooltipBehavior;
  late ChartSeriesController chartSeriesController;
  late ZoomPanBehavior zoomPanBehavior;
  late bool isPointerMoved;
  late DatabaseReference dbusers;
  final StreamController _streamController = StreamController();

  @override
  void initState() {
    getSpeeds();
    isPointerMoved = false;
    dbusers = FirebaseDatabase.instance.ref().child('test/array');
    zoomPanBehavior = ZoomPanBehavior(
      enablePinching: true,
      zoomMode: ZoomMode.x,
      enablePanning: true,
    );
    _tooltipBehavior = TooltipBehavior(enable: true);
    Timer.periodic(const Duration(milliseconds: 500), updateSpeed);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  colors: [
                    Color(0xff09023f),
                    Color(0xff5a5398),
                    Color(0xffe7e6ee),
                  ]
                )
              ),
              child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: SfCartesianChart(
                    onChartTouchInteractionMove:
                        (ChartTouchInteractionArgs args) {
                      isPointerMoved = true;
                    },
                    onChartTouchInteractionUp: (ChartTouchInteractionArgs args) {
                      isPointerMoved = false;
                    },
                    zoomPanBehavior: zoomPanBehavior,
                    title: ChartTitle(text: 'Fuel',textStyle: TextStyle(color: Colors.white,fontSize: 20)),
                    legend: Legend(isVisible: true),
                    tooltipBehavior: _tooltipBehavior,
                    enableAxisAnimation: true,
                    series: <ChartSeries>[
                      LineSeries<Temp, int>(
                          onRendererCreated: (ChartSeriesController controller) {
                            chartSeriesController = controller;
                          },
                          color: Colors.white,
                          name: 'Fuel',
                          dataSource: tempData,
                          xValueMapper: (Temp t, _) => t.a,
                          yValueMapper: (Temp t, _) => t.b,
                          dataLabelSettings:
                              const DataLabelSettings(isVisible: true),
                          enableTooltip: true)
                    ],
                    primaryYAxis:
                        NumericAxis(edgeLabelPlacement: EdgeLabelPlacement.shift),
                    primaryXAxis:
                        NumericAxis(edgeLabelPlacement: EdgeLabelPlacement.shift),
                  )),
            )));
  }

  double date = 2018;

  Future<void> updateSpeed(Timer timer) async {
    var url = Uri.parse(
        "https://rfid-door-lock-dc802-default-rtdb.firebaseio.com/test/array.json");
    final response = await http.get(url);
    final dataBody = json.decode(response.body) as Map;

    tempData.add(Temp(int.parse(dataBody.values.last['value'].toString()),
        int.parse(dataBody.values.last['value1'].toString())));
    chartSeriesController.updateDataSource(addedDataIndex: tempData.length - 1);
  }

  Future<void> getSpeeds() async {
    var url = Uri.parse(
        "https://rfid-door-lock-dc802-default-rtdb.firebaseio.com/test/array.json");
    final response = await http.get(url);
    final dataBody = json.decode(response.body) as Map;
    for (var d in dataBody.values) {
      tempData.add(Temp(
          int.parse(d['value'].toString()), int.parse(d['value1'].toString())));
    }
    setState(() {});
  }
}

class SalesData {
  SalesData(this.year, this.sales);
  final DateTime year;
  final double sales;
}

class Temp {
  Temp(this.a, this.b);
  final int a;
  final int b;
}
