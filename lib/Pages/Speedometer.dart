import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';

class SpeedometerPage extends StatefulWidget  {
  const SpeedometerPage({Key? key}) : super(key: key);

  @override
  State<SpeedometerPage> createState() => _SpeedometerPageState();
}

class _SpeedometerPageState extends State<SpeedometerPage> {
  late List<SalesData> _chatData;
  late TooltipBehavior _tooltipBehavior;

  @override
  void initState(){
    _chatData = getCharData();
    _tooltipBehavior = TooltipBehavior(enable:true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(body: SfCartesianChart(
      title: ChartTitle(text:'Speed of Vehical'),
      legend: Legend(isVisible: true),
      tooltipBehavior: _tooltipBehavior,
      series:<ChartSeries>[
        LineSeries<SalesData,double>(
          name:'speed',
          dataSource: _chatData,
          xValueMapper: (SalesData sales, _) => sales.year,
          yValueMapper: (SalesData sales ,_) => sales.sales,
          dataLabelSettings: const DataLabelSettings(isVisible: true),
        enableTooltip: true)
      ],
      primaryYAxis: NumericAxis(edgeLabelPlacement: EdgeLabelPlacement.shift),
      primaryXAxis: NumericAxis(
          labelFormat: '{value}M',
          numberFormat: NumberFormat.simpleCurrency(decimalDigits: 0)),
    ),
    ));
  }
  List<SalesData>getCharData(){
    final List<SalesData> chartData=[
      SalesData(2017,25),
      SalesData(2018,12),
      SalesData(2019,24),
      SalesData(2022,18),
      SalesData(2021,30),
    ];
    return chartData;
  }
}

class SalesData{
  SalesData(this.year,this.sales);
  final double year;
  final double sales;
}
