import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:binge/pages/main.search.page.dart';
import 'package:binge/pages/checkout.page.dart';
import 'package:flutter/rendering.dart';
//
// Created by Braulio Cassule
// 30 December 2017
//
void main() {
  //debugPaintSizeEnabled=true;
  runApp(new MyApp());
}



class MyApp extends StatefulWidget {
  _LogoAppState createState() => _LogoAppState();
}

class _LogoAppState extends State<MyApp> with
  SingleTickerProviderStateMixin{
  int _page = 0;
  Color gradientEnd = const Color(0xFFFF5640); //Change start gradient color here
  Color gradientStart = const Color(0xFFE8E8E8);//Change end gradient color here
  AnimationController _controller;
  PageController _pageController;

  @override
  initState() {
    SystemChrome.setEnabledSystemUIOverlays([]);
     _pageController = new PageController();
    _controller = new AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void onPageChanged(int page) {
    setState(() {
      this._page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    TextStyle style = new TextStyle(
        color: Color(0xFF342D2A),
        fontFamily: 'KalamRegular',
        fontWeight: FontWeight.normal,
        fontSize: 20.0,
    );
    return new MaterialApp(
      home: new Scaffold(
        backgroundColor: gradientStart,
        body: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _topAppBar(context),
            new Container(
              padding: const EdgeInsets.only(top:10.0),
            ),
            Expanded(
              flex: 2,
              child: new PageView(
                physics:new NeverScrollableScrollPhysics(),
                children: <Widget>[
                  MainSearchPage(
                    controller: _controller,
                  ),
                  MainSearchPage(
                    controller: _controller,
                  ),
                  CheckoutPage(
                    controller: _controller,
                  ),
                ],
                onPageChanged: onPageChanged,
                controller: _pageController,
              ),
            ),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: Icon(Icons.home), title: Text('Home',style: style,)),
            BottomNavigationBarItem(icon: Icon(Icons.shopping_basket), title: Text('Checkout',style: style,)),
            BottomNavigationBarItem(icon: Icon(Icons.more), title: Text('More',style: style,)),
          ],
          fixedColor: Color(0xFF008761),
          onTap: navigationTapped,
          currentIndex: _page,
        ),
      ),
    );
  }
  void navigationTapped(int page) {
    // Animating to the page.
    // You can use whatever duration and curve you like
    _pageController.animateToPage(page,
        duration: const Duration(milliseconds: 300), curve: Curves.ease);
  }

  Widget _topAppBar(BuildContext context) {
    return new Card( 
      elevation: 3,
      child: Container(
    
    height: 140,
    decoration: BoxDecoration(
      color: Colors.white,
    ),
    padding: const EdgeInsets.all(10.0),
      child: new Column(
        children: <Widget>[
          new Row(
            children: <Widget>[
              Expanded(
              child: new Text('Binge', style: TextStyle(
                fontSize: 36,
                fontFamily: 'Pacifico',
                color: Color(0xFF008761),
                ),
              ),
              ),
              RaisedButton(
              child:Icon(
                Icons.search,
                color: Color(0xFF008761),
                size: 30.0,
              ),
                        onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SecondScreen()),
            );
          },
              ),
            ],
          ),
        ],
      ),
      ), 
    );
  }
}

class SecondScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Second Screen"),
      ),
      body: Center(
        child: RaisedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('Go back!'),
        ),
      ),
    );
  }
}
