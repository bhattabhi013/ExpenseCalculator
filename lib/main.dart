
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'models/transaction.dart';
import 'widgets/new_transaction.dart';
import 'widgets/transactionList.dart';

void main() => runApp(ExpenseCalculator());

  class ExpenseCalculator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expense Calculator',
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.purple,
        accentColor: Colors.yellow,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.purple,
        accentColor: Colors.yellow,
      ),
      home: ExpenseCalculatorApp(),
    );
  }
}

class ExpenseCalculatorApp extends StatefulWidget {
  @override
  State<ExpenseCalculatorApp> createState() => _ExpenseCalculatorAppState();
}

class _ExpenseCalculatorAppState extends State<ExpenseCalculatorApp> {
   final List<Transaction> transactions = [
    Transaction(id: '1', price: 999, name: "Shoes", date: DateTime.now()),
    Transaction(id: '2', price: 499, name: "T-Shirt", date: DateTime.now()),
  ];
   _addTransaction(String transName, double transPrice) {
    final newTransaction = Transaction(
        date: DateTime.now(),
        id: DateTime.now().toString(),
        name: transName,
        price: transPrice);
    setState(() {
      transactions.add(newTransaction);
    });
    Navigator.of(context).pop();
   }


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: _returnHeader(context),
        body: _returnBody(),
          floatingActionButtonLocation :FloatingActionButtonLocation.centerDocked, 
          floatingActionButton : FloatingActionButton(
            child : Icon(Icons.add),
            onPressed: () => showNewTransactionModal(context)),
    );
  }
  
  _returnHeader(BuildContext ctx) {
    return AppBar(
      title: Text(
        'Expense Calculator',
      ),
      actions: <Widget>[
        IconButton(onPressed: () => showNewTransactionModal(ctx), icon: const Icon(Icons.add)),
      ],
    );
  }

  _returnBody() {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Card(
            child: Container(
              width: double.infinity,
              child: Text('Chart'),
            ),
            elevation: 5,
          ),
          TransactionList(transactions),
        ]);
         
  }

  showNewTransactionModal(BuildContext ctx){
     showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return GestureDetector(
          onTap: () {},
          child: NewTransaction(_addTransaction),
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }

  _printmsg() {
    print('buttonpressed');
  }
}
