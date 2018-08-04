// Copyright 2017 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.
import 'dart:async';
import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'ui/animation.example.dart';

class StaggerAnimation{
  StaggerAnimation(this.controller)
  : animation = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: controller,
        curve: Interval(
          0.0, 0.4,
          curve: Curves.bounceIn,
        ),
      ),
    ),
    _opacity = new Tween(begin: 0.0, end: 0.4).animate(
          new CurvedAnimation(
            parent: controller,
            curve: new Interval(
              0.80,1.0,
              curve: Curves.bounceOut,
            ),
          ),
    ),
    
    color = ColorTween(
      begin: Colors.indigo[100],
      end: Colors.orange[800],
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(
          0.80, 1.0,
          curve: Curves.fastOutSlowIn,
        ),
      ),
    );
  final AnimationController controller;
  Animation<double> animation;
  Animation<double> _opacity;
  Animation<Color> color;
} 
class SplashScreen extends StatelessWidget {
  SplashScreen({@required AnimationController controller})
  :animation = new StaggerAnimation(controller);

  final StaggerAnimation animation;

  @override
  Widget build(BuildContext context) {
    return  Scaffold (
      body:  Container (
        child: Column ( 
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
              new Center(
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 10.0),
                  height: animation.animation.value*100,
                  width: animation.animation.value*100,
                  child: FlutterLogo(),
                ), 
              ),
              new Opacity(
                opacity: animation._opacity.value,
                child: CircularProgressIndicator(
                  valueColor: animation.color,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
class LogoApp extends StatefulWidget {
  _LogoAppState createState() => _LogoAppState();
}

class _LogoAppState extends State<LogoApp> with SingleTickerProviderStateMixin {

  AnimationController controller;

  handleTimeout() {
    print('intimeout1');
    Navigator.of(context).pushReplacement(new MaterialPageRoute(
      builder: (BuildContext context) => new MyApp()));
  }

   @override
  initState() {
    super.initState();
    controller = AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this);
        controller.addListener(() {
        setState(() {
          // the state that has changed here is the animation object’s value
        });
    });
    controller.forward();
    Timer(Duration(seconds: 3), () => handleTimeout);
  }

  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      controller: controller
    );
  }


  dispose() {
    controller.dispose();
    super.dispose();
  }
}

void main() {
  runApp(
    new MaterialApp( 
      home: LogoApp(),
      theme: ThemeData.dark(),
    )
  );
}
