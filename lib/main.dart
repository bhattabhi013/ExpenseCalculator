import 'dart:html';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'models/transaction.dart';
import 'widgets/chart.dart';
import 'widgets/new_transaction.dart';
import 'widgets/transactionList.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // disbales landscape mode
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp,
  //   DeviceOrientation.portraitDown
  // ]);
  runApp(ExpenseCalculator());
}

class ExpenseCalculator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expense Calculator',
      theme: ThemeData(
          brightness: Brightness.light,
          primarySwatch: Colors.purple,
          accentColor: Colors.yellow,
          textTheme: ThemeData.light().textTheme.copyWith(
                button: TextStyle(color: Colors.white),
              )),
      // darkTheme: ThemeData(
      //   brightness: Brightness.dark,
      //   primarySwatch: Colors.purple,
      //   accentColor: Colors.yellow,
      // ),
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
    // Transaction(id: '1', price: 999, name: "Shoes", date: DateTime.now()),
    // Transaction(id: '2', price: 499, name: "T-Shirt", date: DateTime.now()),
  ];
  late var _viewChart = false;
  List<Transaction> get _weeklyTransaction {
    return transactions.where((trans) {
      return trans.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
  }

  _addTransaction(String transName, double transPrice, DateTime date) {
    final newTransaction = Transaction(
        date: date,
        id: DateTime.now().toString(),
        name: transName,
        price: transPrice);
    setState(() {
      transactions.add(newTransaction);
    });
    Navigator.of(context).pop();
  }

  deleteTransaction(String id) {
    setState(() {
      transactions.removeWhere((element) => element.id == id);
    });
  }

  late bool _isLandscape = false;

  _checkLandscape(bool val) {
    _isLandscape = val;
  }

  @override
  Widget build(BuildContext context) {
    MediaQuery.of(context).orientation == Orientation.landscape;
    return Scaffold(
      appBar: _returnHeader(context),
      body: _returnBody(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () => showNewTransactionModal(context)),
    );
  }

  _returnHeader(BuildContext ctx) {
    return AppBar(
      title: Text(
        'Expense Calculator',
      ),
      actions: <Widget>[
        IconButton(
            onPressed: () => showNewTransactionModal(ctx),
            icon: const Icon(Icons.add)),
      ],
    );
  }

  _returnBody() {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          if (_isLandscape)
            Row(mainAxisAlignment: MainAxisAlignment.end, children: <Widget>[
              Text("View Chart"),
              Switch(
                onChanged: (bool value) {
                  setState(() {
                    _viewChart = value;
                  });
                },
                value: _viewChart,
              )
            ]),
          if (_isLandscape)
            _viewChart
                ? Chart(_weeklyTransaction)
                : TransactionList(transactions, deleteTransaction),
          if (!_isLandscape) Chart(_weeklyTransaction),
          TransactionList(transactions, deleteTransaction)
        ]);
  }

  showNewTransactionModal(BuildContext ctx) {
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
