import 'package:flutter/material.dart';
import 'package:binge/animation/animation.dart';
import 'package:binge/model/resturants.model.dart';
import 'package:binge/pages/resturantdetails/resturants.detals.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MainSearchPage extends StatefulWidget {
    MainSearchPage({
    @required AnimationController controller,
    @required final this.pincode,
  }) : animation = new BingeAnimation(controller);
  final BingeAnimation animation;
  final pincode;
  static bool mountedData; 
   // Stateful Widgets don't have build methods.
   // They have createState() methods.
   // Create State returns a class that extends Flutters State class.
  @override
  _MyHomePageState createState() => new _MyHomePageState();

  // Stateful Widgets are rarely more complicated than this.
}

class _MyHomePageState extends State<MainSearchPage> with
  SingleTickerProviderStateMixin , AutomaticKeepAliveClientMixin<MainSearchPage>{

  AnimationController _controller;


  @override
  void initState(){

    if(!this.mounted) return;
    print('aftermounting===INWIDGETINIDATA=======search');
    super.initState();
     _controller = new AnimationController(
      duration: const Duration(milliseconds: 2200),
      vsync: this,
    );
    _controller.forward();
  }

  
  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  Widget _buildSearch() {
    print('widget.pincodepincodedatacoming===android');
    print(widget.pincode);
    //|| widget.pincode.toString() == '0.0'
    if(widget.pincode == null) {
      return new Container(
        child: Container(),
      );
    }
    print('NEWANIpincodeData');
    print(widget.pincode);
    return new Container(
      child: _resturanData(),
    );
  
  }

  Widget _resturanData() {
    return new FutureBuilder(
      future: _makeDataCall(),
      builder: (BuildContext context, AsyncSnapshot<ResturantsData> snapshot ) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
            return new CircularProgressIndicator();
          case ConnectionState.active:
          case ConnectionState.waiting:
            return Text('Awaiting result...');
          case ConnectionState.done:
            if (snapshot.hasError)
              return Text('Error: ${snapshot.error}');
            print(snapshot.data);
            return new ResturantDetailsPage(
              controller: _controller,
              resturants: snapshot.data,
            );
        }
      }
    );
  }

Future<ResturantsData> _makeDataCall() async {
  final response =
      await http.get('http://sgc/restaurants/pincode/560063');

  if (response.statusCode == 200) {
    // If the call to the server was successful, parse the JSON
    // return Video.fromJson(json.decode(response.body));
   print( response.body.length);
   var test = ResturantsData.fromJson(json.decode(response.body));
   if(test.success) {
     return test;
   }
   return test;
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to load post');
  }
}

  @override
  Widget build(BuildContext context) {
    
    print('INBUULS');
    return new Container(
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Flexible(flex: 4, child: _buildSearch()),
        ],
      ),
    );
  }
    @override
bool get wantKeepAlive => true;

}
