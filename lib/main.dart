import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './home_widget.dart';
import './login.dart';
void main() {
  runApp(MyApp());
} 

class MyApp extends StatefulWidget{
  State<StatefulWidget> createState(){
    // TODO: implement createState
    return _App();
  }
}
class _App extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    /*This is where the app essentially starts.
    * Currently I have a working prototype of the login screen and the Home inventory screen.
    * The login screen is stored in the login.dart
    * The home screen is stored in the home_widget.dart
    * TODO: Work on a way to switch between the login widget and home widget in the home: attribute of the Material app
    * */
    return MaterialApp(
      title: 'Buff Techs Inventory',
      home: Home(),
      debugShowCheckedModeBanner: false,
    );
  }
}