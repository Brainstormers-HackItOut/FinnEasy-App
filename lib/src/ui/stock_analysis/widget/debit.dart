// Flutter imports:
import 'dart:math';

import 'package:finneasy/resources/colors.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class Debit extends StatefulWidget {

  final Map<String, dynamic> debit;

  Debit({Key? key, required this.debit}) : super(key: key);

  @override
  _DebitState createState() => _DebitState();
}

class _DebitState extends State<Debit> {
  late TooltipBehavior _tooltipBehavior;

  @override
  void initState() {
    _tooltipBehavior =
        TooltipBehavior(enable: true, header: '', canShowMarker: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final List<_SalesData> chartData = <_SalesData>[];
    for (String key in widget.debit[widget.debit.keys.first].keys){
      print(key);
      chartData.add(_SalesData(key, widget.debit[widget.debit.keys.first][key]));
    }
    return Container(height : 200, width: 400, child: _buildRoundedBarChart(chartData));
  }

  /// Returns the rounded cartesian bar chart.
  SfCartesianChart _buildRoundedBarChart(List<_SalesData> data) {
    return SfCartesianChart(
        title: ChartTitle(
            text: 'Debit of your Account'),
        plotAreaBorderWidth: 0,
        enableAxisAnimation: true,
        primaryXAxis: CategoryAxis(
            labelPlacement: LabelPlacement.onTicks,
            labelRotation: -45,
            majorGridLines: MajorGridLines(width: 0)),
        primaryYAxis: NumericAxis(
          labelFormat: '{value}',
          axisLine: AxisLine(width: 0),
        ),
        margin: EdgeInsets.all(15),
        trackballBehavior: TrackballBehavior(enable: true),
        tooltipBehavior: TooltipBehavior(enable: true),
        series: <ChartSeries<_SalesData, String>>[
          SplineAreaSeries<_SalesData, String>(
              gradient: const LinearGradient(colors: <Color>[
                Color.fromRGBO(51, 133, 255, 1),
                Color.fromRGBO(160, 213, 255, 1)
              ], stops: <double>[
                0.2,
                0.6
              ], begin: Alignment.bottomCenter, end: Alignment.topCenter),
              borderWidth: 2,
              borderColor: AppColors.primaryColor,
              dataSource: data,
              xValueMapper: (_SalesData sales, _) => sales.day,
              yValueMapper: (_SalesData sales, _) => sales.sales,
              name: 'Sales',
              markerSettings: MarkerSettings(isVisible: true),
              dataLabelSettings: DataLabelSettings(isVisible: true))
        ]
    );
  }

}
class _SalesData {
  _SalesData(this.day, this.sales);
  final String day;
  final double sales;
}