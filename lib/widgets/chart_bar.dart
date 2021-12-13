import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String weekDay;
  final double spendingAmount;
  final double percentSpent;

  const ChartBar(
      {required this.weekDay,
      required this.spendingAmount,
      required this.percentSpent});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // shrinks size to fix into assigned width
        FittedBox(
          child: Text('Rs. ${spendingAmount.toStringAsFixed(0)}'),
        ),
        SizedBox(
          height: 5,
        ),
        Container(
          height: 60,
          width:10,
          // creates oerlaping 3-d widget
          child: Stack( 
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  // border: Border.all(color: Colors.grey, width: 1),
                  color:  Color.fromRGBO(220, 220, 220, 1),
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              FractionallySizedBox(
                heightFactor: percentSpent,
                  child: Container(
                  decoration: BoxDecoration(
                  color:  Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                )
              )
            ]
          ),
        ),
        SizedBox(
          height: 5,
        ),
        Text(weekDay),
      ]
    );
  }
}
