import 'dart:async';

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';
import 'dart:math' as math;

class SpeedometerPage extends StatefulWidget {
  const SpeedometerPage({Key? key}) : super(key: key);

  @override
  State<SpeedometerPage> createState() => _SpeedometerPageState();
}

class _SpeedometerPageState extends State<SpeedometerPage> {
  late List<SalesData> _chatData;
  late TooltipBehavior _tooltipBehavior;
  late ChartSeriesController chartSeriesController;
  late ZoomPanBehavior zoomPanBehavior;
  late bool isPointerMoved;

  @override
  void initState() {
    _chatData = getCharData();
    isPointerMoved = false;
    zoomPanBehavior = ZoomPanBehavior(
      enablePinching: true,
      zoomMode: ZoomMode.x,
      enablePanning: true,
    );
    _tooltipBehavior = TooltipBehavior(enable: true);
    Timer.periodic(const Duration(seconds: 1), updateBro);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: Padding(
                padding: const EdgeInsets.all(20.0),
                child: SfCartesianChart(
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
                      LineSeries<SalesData, double>(
                          onRendererCreated:
                              (ChartSeriesController controller) {
                            chartSeriesController = controller;
                          },
                          name: 'speed',
                          dataSource: _chatData,
                          xValueMapper: (SalesData sales, _) => sales.year,
                          yValueMapper: (SalesData sales, _) => sales.sales,
                          dataLabelSettings:
                              const DataLabelSettings(isVisible: true),
                          enableTooltip: true)
                    ],
                    primaryYAxis: NumericAxis(
                        edgeLabelPlacement: EdgeLabelPlacement.shift),
                    primaryXAxis: NumericAxis(
                        autoScrollingMode: AutoScrollingMode.end,
                        autoScrollingDelta: 10,
                        labelFormat: '{value}M',
                        numberFormat:
                            NumberFormat.simpleCurrency(decimalDigits: 0))))));
  }

  double date = 2018;

  void updateBro(Timer timer) {
    _chatData.add(SalesData(date++, math.Random().nextDouble()));
    chartSeriesController.updateDataSource(
        addedDataIndex: _chatData.length - 1);
  }

  List<SalesData> getCharData() {
    final List<SalesData> chartData = [SalesData(2017, 0.56)];
    return chartData;
  }
}

class SalesData {
  SalesData(this.year, this.sales);
  final double year;
  final double sales;
}
