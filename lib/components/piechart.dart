import 'package:covid19_app/components/constants.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

class Pie_Chart extends StatelessWidget {
  var active;
  var recovered;
  var deaths;
   double size;
  ChartType type;
    Pie_Chart({super.key,
    required this.type,
    required this.active,
    required this.recovered,
    required this.deaths,
    required this.size
    });

  @override
  Widget build(BuildContext context) {
    Constant constant=Constant();
    return PieChart(
      dataMap: {
        'Active':
        double.parse(active.toString()),
        'Recovered':
        double.parse(recovered.toString()),
        'Deaths':
        double.parse(deaths.toString()),
      },
      chartRadius:MediaQuery.of(context).size.width/size,
      legendOptions:LegendOptions(
        legendPosition: LegendPosition.left,
        legendTextStyle: TextStyle(
            fontWeight: FontWeight.bold,
            color:constant.greenColor),
      ),
      animationDuration: const Duration(seconds: 3),
      chartType: type,
      chartLegendSpacing:50,
      ringStrokeWidth: 25,
      colorList:[
        constant.redColor,
        constant.greenColor,
        Colors.blue,
      ],
      chartValuesOptions: const ChartValuesOptions(
        showChartValueBackground: true,
        showChartValues: true,
        showChartValuesInPercentage: true,
        showChartValuesOutside: true,
        decimalPlaces: 2,
      ),
    );
  }
}
