import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTrans;
  NewTransaction(this.addTrans);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  // late String _name;
  final _name = TextEditingController();

  final _price = TextEditingController();

  late DateTime? _userSelectedDate = null;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      child: Card(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
            TextField(
              decoration: const InputDecoration(
                label: Text('Name'),
              ),
              // onChanged: (value){
              //   _name = value;
              // },
              controller: _name,
            ),
            TextField(
              decoration: const InputDecoration(
                label: Text('Price'),
              ),
              //  onChanged: (value) => _price = value,
              controller: _price,
              keyboardType: TextInputType.number,
            ),
            Expanded(
              // takes as much width available
              // height: 80,
              child: Row(children: <Widget>[
                 Text(_userSelectedDate == null ?
                 'Date not chosen'
                 :'Picked date ${DateFormat.yMd().format(_userSelectedDate!)}'),
                FlatButton(
                  child: const Text(
                    'Choose date',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  textColor: Theme.of(context).primaryColor,
                  onPressed: _showDatePicker,
                )
              ]),
            ),
            ElevatedButton(
              onPressed: _submitData,
              child: const Text('Add Expenditure'),
              style: ButtonStyle(
              backgroundColor:   MaterialStateProperty.all<Color>(Theme.of(context).primaryColor),
              foregroundColor:  MaterialStateProperty.all<Color>(Colors.white),
              ),
              
            )
          ])),
    );
  }

  _showDatePicker(){
    showDatePicker(
    context: context,
    initialDate: DateTime.now(), 
    firstDate: DateTime(2021), 
    lastDate: DateTime.now(),
    ).then((value){
      if(value == null){
        return;
      }
      setState(() {
         _userSelectedDate = (value as DateTime);
      });
    });
  }

  _submitData() {
    final enteredName = _name.text;
    final enteredPrice = double.parse(_price.text);
    if(_price.text.isEmpty){
      return ;
    }
    print('${_price.text} and ${_name.text}');
    if (enteredPrice <= 0 || enteredName.isEmpty || _userSelectedDate == null) {
      return;
    }
    widget.addTrans(enteredName, enteredPrice, _userSelectedDate);
  }
}
