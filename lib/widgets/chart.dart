import 'package:expense_calculator/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  final List<Transaction> weeklyTransaction;
  Chart(this.weeklyTransaction){
    print(weeklyTransaction);
  }

  List<Map<String, Object>> get groupedTransaction {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(
        Duration(days: index),
      );
      var totalSum;
      for (var i = 0; i < weeklyTransaction.length; i++) {
        if (weeklyTransaction[i].date.day == weekDay.day &&
            weeklyTransaction[i].date.month == weekDay.month &&
            weeklyTransaction[i].date.year == weekDay.year) {
          totalSum += weeklyTransaction[i].price;
        }
      }
      print('day is ${DateFormat.E().format(weekDay)} and amount: ${totalSum}');
      return {
        'day': DateFormat.E().format(weekDay),
        'amount': totalSum,
      };
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.all(20),
      child: Row(
        children: weeklyTransaction.map((res){
           return Text('name is ${res.name} and price: ${res.price.toString()}');
         }).toList(),
      ),
    );
  }
}
