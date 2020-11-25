import 'package:events/screens/event_screen.dart';
import 'package:events/screens/login_screen.dart';
import 'package:events/shared/authentication.dart';
import 'package:flutter/material.dart';

class LaunchScreen extends StatefulWidget {
  @override
  _LaunchScreenState createState() => _LaunchScreenState();
}

class _LaunchScreenState extends State<LaunchScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }


  @override
  void initState(){
    super.initState();
    Authentication authentication = Authentication();
    authentication.getUser().then((user) {
      MaterialPageRoute route;
      if (user != null){
        route = MaterialPageRoute(builder: (context) => EventScreen());
      }
      else {
        route = MaterialPageRoute(builder: (context) => LoginScreen());
      }
      Navigator.pushReplacement(context, route);
    });
  }
}
