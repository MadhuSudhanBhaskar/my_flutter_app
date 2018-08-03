// Copyright 2017 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';

class LogoApp extends StatefulWidget {
  _LogoAppState createState() => _LogoAppState();
}

class _LogoAppState extends State<LogoApp> with SingleTickerProviderStateMixin {
  Animation<double> animation;
  Animation<double> _opacity;
  AnimationController controller;

  initState() {
    super.initState();
    controller = AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this);
        
    animation = Tween(begin: 0.0, end: 150.0).animate(CurvedAnimation(
        parent: controller,
        curve: Interval(
          0.0, 0.9500,
          curve: Curves.fastOutSlowIn,
        ),
      ),
      );
   _opacity = Tween<double>(
      begin: 0.0,
      end: 0.10,
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(
          0.9500, 0.1100,
          curve: Curves.ease,
        ),
      ),
    )  ; 
      animation .addListener(() {
        setState(() {
          // the state that has changed here is the animation object’s value
        });
      });
    controller.forward();
  }
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
                  height: animation.value,
                  width: animation.value,
                  child: FlutterLogo(),
                ), 
              ),
              new Opacity(
                opacity: _opacity.value,
                child: CircularProgressIndicator(),
              ),
          ],
        ),
      ),
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
