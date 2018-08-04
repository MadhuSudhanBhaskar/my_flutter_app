// Copyright 2017 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';

class StaggerAnimation {
  StaggerAnimation(this.controller)
  : animation = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: controller,
        curve: Interval(
          0.0, 0.9500,
          curve: Curves.ease,
        ),
      ),
    ),
    _opacity = new Tween(begin: 0.5, end: 1.0).animate(
          new CurvedAnimation(
            parent: controller,
            curve: new Interval(
              0.0,
              0.2000,
              curve: Curves.ease,
            ),
          ),
    );

  final AnimationController controller;
  Animation<double> animation;
  Animation<double> _opacity;
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
                  height: animation.animation.value,
                  width: animation.animation.value,
                  child: FlutterLogo(),
                ), 
              ),
              new Opacity(
                opacity: animation._opacity.value,
                child: CircularProgressIndicator(),
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

  initState() {
    super.initState();
    controller = AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this);
    controller.forward();
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
