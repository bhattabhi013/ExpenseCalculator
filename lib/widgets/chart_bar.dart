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
    return LayoutBuilder(
      builder: (context, constraints) {
        return Column(
          children: [
            // shrinks size to fix into assigned width
            Container(
              height: constraints.maxHeight * 0.15,
              child: FittedBox(
                child: Text('Rs. ${spendingAmount.toStringAsFixed(0)}'),
              ),
            ),
            SizedBox(
               height: constraints.maxHeight * 0.05,
            ),
            Container(
              height: constraints.maxHeight * 0.60,
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
               height: constraints.maxHeight * 0.05,
            ),
            Container(
              height: constraints.maxHeight * 0.15,
              child: Text(weekDay),
              ),
          ]
        );
      },
    );
  }
}
