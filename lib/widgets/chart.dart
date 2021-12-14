import 'package:expense_calculator/models/transaction.dart';
import 'package:expense_calculator/widgets/chart_bar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  final List<Transaction> weeklyTransaction;
  Chart(this.weeklyTransaction);
  List<Map<String, Object>> get groupedTransaction {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(
        Duration(days: index),
      );
      var totalSum= 0.0;
      for (var i = 0; i < weeklyTransaction.length; i++) {
        if (weeklyTransaction[i].date.day == weekDay.day && 
            weeklyTransaction[i].date.month == weekDay.month &&
            weeklyTransaction[i].date.year == weekDay.year) {
          totalSum += weeklyTransaction[i].price;
        }
      }
      print('day is ${DateFormat.E().format(weekDay)} and amount: ${totalSum}');
      return {
        'day': DateFormat.E().format(weekDay).substring(0,1),
        'price': totalSum,
      };
    }).reversed.toList();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: groupedTransaction.map((res){
            // return Text('name is ${res.name} and price: ${res.price.toString()}');
            return Flexible(
              // helps in sizing and segmenting of rows and columns.
              fit: FlexFit.tight,
              child:  ChartBar(
              spendingAmount:  getMaxSpent == 0.0 ? 0.0 :(res['price'] as double), 
              percentSpent:  getMaxSpent == 0.0 ? 0.0 : (res['price'] as double) / getMaxSpent, 
              weekDay: res['day'].toString()
              ),
            );           
         }).toList(),
      ),
    );
  }

  double get getMaxSpent{
    return groupedTransaction.fold(0.0, (sum, item) {
      return sum + (item['price'] as double);
    });
  }
}
