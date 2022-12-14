import 'package:expenses/components/chart_bar.dart';
import 'package:expenses/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;

  Chart(this.recentTransactions);

  List<Map<String, Object>> get groupedTransanction {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(
        Duration(days: index),
      );

      double totalSum = 0.0;

      for (var i = 0; i < recentTransactions.length; i++) {
        bool sameDay = recentTransactions[i].date.day == weekDay.day;
        bool sameMonth = recentTransactions[i].date.month == weekDay.month;
        bool sameYear = recentTransactions[i].date.year == weekDay.year;

        if (sameDay && sameMonth && sameYear) {
          totalSum += recentTransactions[i].value;
        }
      }

      return {
        "day": DateFormat.E().format(weekDay)[0],
        "value": totalSum,
      };
    }).reversed.toList();
  }

  double get _weekTotalValue {
    return groupedTransanction.fold(0.0, (sum, transaction) {
      double value = transaction["value"] as double;
      return sum + value;
    });
  }

  @override
  Widget build(BuildContext context) {
    groupedTransanction;
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTransanction.map((tr) {
            double value = tr["value"] as double;
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(
                day: tr["day"].toString(),
                value: value,
                percentage: _weekTotalValue == 0 ? 0 : value / _weekTotalValue,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
