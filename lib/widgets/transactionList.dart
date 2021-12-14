import '../models/transaction.dart';
import 'package:intl/intl.dart';

import 'package:flutter/material.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function removeTrans;
  TransactionList(this.transactions, this.removeTrans);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      child: transactions.isEmpty
          ? Column(
              children: [
                Text('Transaction list empty'),
                Container(
                  height: 200,
                  child:
                      Image.asset('assets/Images/logo.png', fit: BoxFit.cover),
                ),
              ],
            )
          : ListView.builder(
              itemBuilder: (context, index) {
                return Card(
                  elevation: 5,
                  margin: EdgeInsets.all(10),
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      child: Container(
                        padding: EdgeInsets.all(5),
                        margin: EdgeInsets.all(2),
                        child: FittedBox(
                          child: Text(
                              'Rs. ${transactions[index].price.toStringAsFixed(2)}'),
                        ),
                      ),
                    ),
                    title: Text(
                      transactions[index].name,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      DateFormat().format(transactions[index].date),
                      style: TextStyle(
                        color: Colors.green,
                        fontSize: 10,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    trailing: IconButton(
                      onPressed: ()  => removeTrans(transactions[index].id),
                      icon: Icon(Icons.delete),
                      color: Theme.of(context).errorColor,),
                  ),
                );
                // Card(
                // elevation: 5,
                // child: Row(
                //   children: <Widget>[
                //     Container(
                //       decoration: BoxDecoration(
                //           border: Border.all(
                //         color: Theme.of(context).primaryColor,
                //         width: 2,
                //       )),
                //       padding: EdgeInsets.all(10),
                //       margin: const EdgeInsets.symmetric(
                //         vertical: 10,
                //         horizontal: 50,
                //       ),
                //       child: Text(
                //         'Rs. ${transactions[index].price.toStringAsFixed(2)}',
                //         style: TextStyle(
                //           color: Theme.of(context).primaryColor,
                //           fontWeight: FontWeight.bold,
                //           fontSize: 24,
                //         ),
                //       ),
                //     ),
                //     Column(
                //       crossAxisAlignment: CrossAxisAlignment.start,
                //       children: <Widget>[
                //         Text(
                //           transactions[index].name,
                //           style: TextStyle(
                //             color: Colors.black,
                //             fontSize: 16,
                //             fontWeight: FontWeight.bold,
                //           ),
                //         ),
                //         Text(
                //           DateFormat().format(transactions[index].date),
                //           style: TextStyle(
                //             color: Colors.green,
                //             fontSize: 10,
                //             fontWeight: FontWeight.normal,
                //           ),
                //         ),
                //       ],
                //     ),
                //   ],
                // )
                // );
              },
              itemCount: transactions.length,
            ),
    );
  }
}
