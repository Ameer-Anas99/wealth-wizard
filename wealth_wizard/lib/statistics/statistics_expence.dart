import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:wealth_wizard/model/add_data.dart';
import 'package:wealth_wizard/screens/screen/statistics.dart';

class ExpenceChart extends StatefulWidget {
  const ExpenceChart({super.key});

  @override
  State<ExpenceChart> createState() => _ExpenceChartState();
}

class _ExpenceChartState extends State<ExpenceChart> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.white,
      body: ValueListenableBuilder(
        valueListenable: overViewGraphNotifier,
        builder: (BuildContext context, List<TransactionModel> newList,
            Widget? child) {
          var allincome =
              newList.where((element) => element.type == 'expense').toList();
          return overViewGraphNotifier.value.isEmpty
              ? SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text('No data found'),
                    ],
                  ),
                )
              : SfCircularChart(
                  palette: [Color.fromARGB(224, 167, 79, 71)],
                  series: <CircularSeries>[
                    PieSeries<TransactionModel, String>(
                        dataSource: allincome,
                        xValueMapper: (TransactionModel expenseDate, _) =>
                            expenseDate.category,
                        yValueMapper: (TransactionModel expenseDate, _) =>
                            num.parse(expenseDate.amount),
                        dataLabelSettings: DataLabelSettings(
                          isVisible: true,
                        ))
                  ],
                  legend: Legend(
                      isVisible: true,
                      overflowMode: LegendItemOverflowMode.scroll,
                      alignment: ChartAlignment.center),
                );
        },
      ),
    ));
  }
}
