import 'package:flutter/material.dart';

class NewTransaction extends StatelessWidget {
  // late String name;
  // late String price;
  final name = TextEditingController();
  final price = TextEditingController();
  final Function addTrans;
  NewTransaction(this.addTrans);

  @override
  Widget build(BuildContext context) {
    return  Container(
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
                    //   name = value;
                    // },
                    controller: name,
                  ),
                  TextField(
                    decoration: const InputDecoration(
                      label: Text('Price'),
                    ),
                    //  onChanged: (value) => price = value,
                    controller: price,
                    keyboardType: TextInputType.number,
                  ),
                  FlatButton(
                    onPressed: submitData,
                    child: const Text('Add Expenditure'),
                    textColor: Colors.purple,
                  )
                ])),
          );
  }

  submitData(){
    final enteredName = name.text;
    final enteredPrice = double.parse(price.text);
     print('${price.text} and ${name.text}');
     if(enteredPrice <= 0 || enteredName.isEmpty) {
      return;
     }
      addTrans(enteredName, enteredPrice);
  }
}