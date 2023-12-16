import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:wealth_wizard/model/add_data.dart';
import 'package:wealth_wizard/view/statistics.dart';

class IncomeChart extends StatefulWidget {
  const IncomeChart({super.key});

  @override
  State<IncomeChart> createState() => _IncomeScreenState();
}

class _IncomeScreenState extends State<IncomeChart> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.white12,
      body: ValueListenableBuilder(
          valueListenable: overViewGraphNotifier,
          builder: (BuildContext context, List<TransactionModel> newList,
              Widget? child) {
            var allincome =
                newList.where((element) => element.type == 'income').toList();
            return overViewGraphNotifier.value.isEmpty
                ? SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text('No data Found'),
                      ],
                    ),
                  )
                : SfCircularChart(
                    series: <CircularSeries>[
                      PieSeries<TransactionModel, String>(
                          dataSource: allincome,
                          xValueMapper: (TransactionModel incomeDate, _) =>
                              incomeDate.category,
                          yValueMapper: (TransactionModel incomeDate, _) =>
                              int.parse(incomeDate.amount),
                          dataLabelSettings: DataLabelSettings(
                            isVisible: true,
                          ))
                    ],
                    legend: Legend(
                        isVisible: true,
                        overflowMode: LegendItemOverflowMode.scroll,
                        alignment: ChartAlignment.center),
                  );
          }),
    ));
  }
}
