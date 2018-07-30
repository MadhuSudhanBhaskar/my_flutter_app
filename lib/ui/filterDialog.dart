import 'package:flutter/material.dart';
import 'dateTIme.dart';


class FilterDialog extends StatefulWidget {
  @override
  FilterDialogState createState() => new FilterDialogState();
}

class FilterDialogState extends State<FilterDialog> {
  DateTime _dateTime = new DateTime.now();
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: const Text('FILTER'),
        actions: [
          new FlatButton(
              onPressed: () => print('Test'),
              child: new Text('SAVE',
                  style: Theme
                      .of(context)
                      .textTheme
                      .subhead
                      .copyWith(color: Colors.white))),
        ],
      ),
      body: new Form(
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: <Widget>[
            new Container(
              padding: const EdgeInsets.all(10.0),
              alignment: Alignment.bottomRight,
              child: TextField(
                decoration: const InputDecoration(
                  labelText: "Fill in Name",
                  filled: false
                ),
              ),
            ),
            new Container(
              child: new ListTile(
                leading: new Icon(Icons.today, color: Colors.grey[500]),
                title: new DateTimeItem(
                  dateTime: _dateTime,
                  onChanged: (dateTime) => setState(() => _dateTime = dateTime),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}