import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:binge/model/city.model.dart';
import 'package:binge/pages/search/search.page.dart';
import 'dart:async';
import 'dart:convert';
import 'package:binge/animation/animation.dart';

class AddEntryDialog extends StatefulWidget {
  @override
  AddEntryDialogState createState() => new AddEntryDialogState();
}

class AddEntryDialogState extends State<AddEntryDialog> {

  StreamController<CityList> streamController;
  List<CityList> list = [];
  bool hasLoaded = false;

  @override
  void initState() {
    super.initState();
    streamController = StreamController.broadcast();

    streamController.stream.listen((p) => setState(() {
      hasLoaded = true;
      list.add(p);
    }));

    load(streamController);
  }

  load(StreamController<CityList> sc) async {
    String url = "http://ABC.COM/city/statusid/2";
    var client = new http.Client();

    var req = new http.Request('get', Uri.parse(url));

    var streamedRes = await client.send(req);

    streamedRes.stream
      .transform(utf8.decoder)
      .transform(json.decoder)
      .expand((e) => e)
      .map((map) => CityList.fromJson(map))
      .pipe(sc);
  }

  @override
  void dispose() {
    super.dispose();
    streamController?.close();
    streamController = null;
  }

  @override
  Widget build(BuildContext context) {
    print('pagecalled===again');
    return new Scaffold(
      backgroundColor: Colors.white,
      appBar: new AppBar(
        iconTheme: IconThemeData(color: Color(0XFFff6969)),
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text('Please select city',style: TextStyle(
                    fontSize: 24,
                    fontFamily: 'Pacifico',
                    color: Color(0xFF515c6f),
                  )),
      ),
      body: new Column (
        crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            hasLoaded ? Container() : Center(
              child:Container(
                padding: EdgeInsets.only(top: 20.0),
                child:CircularProgressIndicator(),
              ),
            ),
            Expanded(
              child: ListView.builder(
              itemBuilder: (BuildContext context, int index) => _makeElement(index),
            ),
          ),
        ]
      ),
      

    );
  }

    Widget _makeElement(int index) {
    if (index >= list.length) {
      return null;
    }

   return Column(
      children: <Widget>[
        ListTile(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SecondScreen(
                cityPincode: list[index].data
                )),
            );
          },
          leading: Icon(Icons.location_city),
          title: Text('d'),
        ),
        Divider(
          color: Color(0xFFD8D8D8),
        ),
      ],
    );
  }
}
