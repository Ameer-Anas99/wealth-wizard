import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wealth_wizard/controller/db_function.dart';
import 'package:wealth_wizard/controller/statistics_provider.dart';

class DateFilterStatistics extends StatelessWidget {
  const DateFilterStatistics({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer2<Dbprovider, StatisticsProvider>(
      builder: (context, dbProvider, statisticProvider, child) {
        return PopupMenuButton<int>(
          shape: ContinuousRectangleBorder(
            borderRadius: BorderRadius.circular(
              70,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(
              right: 15.0,
            ),
            child: Row(
              children: [
                Text(
                  statisticProvider.dateFilterTitle,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Icon(
                  Icons.arrow_drop_down,
                  size: 30,
                ),
              ],
            ),
          ),
          itemBuilder: (context) => [
            PopupMenuItem(
              value: 1,
              child: const Text(
                "All",
              ),
              onTap: () {
                dbProvider.chartList = dbProvider.transactionList;
                statisticProvider.dateFilterTitle = "All";
                statisticProvider
                    .changeValue(statisticProvider.dateFilterTitle);
              },
            ),
            PopupMenuItem(
              value: 2,
              child: const Text(
                "Today",
              ),
              onTap: () {
                dbProvider.chartList = dbProvider.transactionList
                    .where(
                      (element) =>
                          element.datetime.day == DateTime.now().day &&
                          element.datetime.year == DateTime.now().year,
                    )
                    .toList();

                statisticProvider.dateFilterTitle = "Today";
                statisticProvider
                    .changeValue(statisticProvider.dateFilterTitle);
              },
            ),
            PopupMenuItem(
              value: 2,
              child: const Text(
                "Yesterday",
              ),
              onTap: () {
                dbProvider.chartList = dbProvider.transactionList
                    .where(
                      (element) =>
                          element.datetime.day == DateTime.now().day - 1 &&
                          element.datetime.month == DateTime.now().month &&
                          element.datetime.year == DateTime.now().year,
                    )
                    .toList();

                statisticProvider.dateFilterTitle = "Yesterday";
                statisticProvider
                    .changeValue(statisticProvider.dateFilterTitle);
              },
            ),
            PopupMenuItem(
              value: 2,
              child: const Text(
                "Month",
              ),
              onTap: () {
                dbProvider.chartList = dbProvider.transactionList
                    .where(
                      (element) =>
                          element.datetime.month == DateTime.now().month &&
                          element.datetime.year == DateTime.now().year,
                    )
                    .toList();

                statisticProvider.dateFilterTitle = "Month";
                statisticProvider
                    .changeValue(statisticProvider.dateFilterTitle);
              },
            ),
          ],
        );
      },
    );
  }
}

class DateFilterTransaction extends StatelessWidget {
  DateFilterTransaction({super.key});

  DateTime? startDate, endDate;

  @override
  Widget build(BuildContext context) {
    return Consumer2<Dbprovider, StatisticsProvider>(
      builder: (context, dbProvider, statisticProvider, child) {
        return PopupMenuButton<int>(
          shape: ContinuousRectangleBorder(
            borderRadius: BorderRadius.circular(
              20,
            ),
          ),
          child: const Icon(
            Icons.calendar_view_day_rounded,
          ),
          itemBuilder: (ctx) => [
            PopupMenuItem(
              value: 1,
              child: const Text(
                "All",
              ),
              onTap: () {
                dbProvider.chartList = dbProvider.transactionList;
                statisticProvider.dateFilterTitle = "All";
                statisticProvider
                    .changeValue(statisticProvider.dateFilterTitle);
              },
            ),
            PopupMenuItem(
              value: 2,
              child: const Text(
                "Today",
              ),
              onTap: () {
                dbProvider.chartList = dbProvider.transactionList
                    .where(
                      (element) =>
                          element.datetime.day == DateTime.now().day &&
                          element.datetime.year == DateTime.now().year,
                    )
                    .toList();

                statisticProvider.dateFilterTitle = "Today";
                statisticProvider
                    .changeValue(statisticProvider.dateFilterTitle);
              },
            ),
            PopupMenuItem(
                value: 2,
                child: const Text(
                  "Yesterday",
                ),
                onTap: () {
                  dbProvider.chartList = dbProvider.transactionList
                      .where(
                        (element) =>
                            element.datetime.day == DateTime.now().day - 1 &&
                            element.datetime.month == DateTime.now().month &&
                            element.datetime.year == DateTime.now().year,
                      )
                      .toList();

                  statisticProvider.dateFilterTitle = "Yesterday";
                  statisticProvider
                      .changeValue(statisticProvider.dateFilterTitle);
                }),
            PopupMenuItem(
                value: 2,
                child: const Text(
                  "Month",
                ),
                onTap: () {
                  dbProvider.chartList = dbProvider.transactionList
                      .where(
                        (element) =>
                            element.datetime.month == DateTime.now().month &&
                            element.datetime.year == DateTime.now().year,
                      )
                      .toList();

                  statisticProvider.dateFilterTitle = "Month";
                  statisticProvider
                      .changeValue(statisticProvider.dateFilterTitle);
                }),
          ],
        );
      },
    );
  }
}
