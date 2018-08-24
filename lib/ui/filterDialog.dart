import 'package:flutter/material.dart';
import 'clipper.dart';
import 'package:flutter_calendar/flutter_calendar.dart';

class StaggerAnimation {
  StaggerAnimation(this.controller)
  : animation = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: controller,
        curve: Interval(
          0.1, 0.3,
          curve: Curves.fastOutSlowIn,
        ),
      ),
    ),
    _opacity = new Tween(begin: 0.0, end: 0.4).animate(
      new CurvedAnimation(
        parent: controller,
        curve: new Interval(
          0.4,0.6,
          curve: Curves.linear,
        ),
      ),
  ),
  color = ColorTween(
      begin: Colors.indigo,
      end: Colors.white70,
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
class MainScreen extends StatelessWidget {
    MainScreen({@required AnimationController controller})
  :animation = new StaggerAnimation(controller);
  final StaggerAnimation animation;
  final now = new DateTime.now();

  void handleNewDate(date) {
    print(date);
  }

  Widget _headerPart() {
    return ClipPath(
      clipper: AppointmentHeader(),
      child: Container (
        height: 220.0,
        decoration: new BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            stops: [0.1, 0.5, 0.8, 0.8],
            colors: [
              // Colors are easy thanks to Flutter's
              // Colors class.
              Colors.deepPurple[400],
              Colors.deepPurple[400],
              Colors.deepPurple[400],
              Colors.deepPurple[400],
            ],
          ),
        ),
      ),
    );
  }

  Widget _date() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          FadeTransition(
            opacity: animation._opacity,
            child: CircleAvatar(
              backgroundColor: Color(0xFFFFFFFF),
              child: Text(now.day.toString(),
                        style: TextStyle(color: Colors.black, 
                          fontWeight: FontWeight.w600,
                          fontSize: 18.0,
                        )
                    ),
              radius: animation.animation.value * 30,
            ),
          ),
        ],
      ),
      padding: EdgeInsets.only(top:10.0),
    );
  }

  Widget _calander() {
    return Card(
      margin: EdgeInsets.only(top:220.0),
      child:Container(
        
        child: Calendar(
          onDateSelected: (date) => handleNewDate(date),
      ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: Text('Now'),
      ),
      body: Stack(
        children: <Widget>[
          _headerPart(),
          _date(),
          _calander(),
        ],
      ),
    );
  }
}
/*This is the main animation class*/
class _MyHomePageState extends State<AppointmentDetails> with SingleTickerProviderStateMixin{

  AnimationController myHomePageAnimation;
  
  @override
  initState() {
    super.initState();
    myHomePageAnimation = new AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this);
      myHomePageAnimation.addListener(() {
        setState(() {
                  
        });
      });
      myHomePageAnimation.forward();
  }
  
  @override
  Widget build(BuildContext context) {
    return MainScreen(
      controller: myHomePageAnimation,
    );
  }
}

class AppointmentDetails extends StatefulWidget {
   AppointmentDetails({Key key, this.title}) : super(key: key);
   final title;
  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

/* This is the main start of the home page*/
class TodayAppointment extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Appointment Page',
      home: AppointmentDetails(title: 'Appointment'),
    );
  }
}
