import 'package:flutter/material.dart';
import './home_widget.dart';
import 'dart:async';
import 'package:postgres/postgres.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget{
  //printSelect();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    print("Hello");
    return MaterialApp(
      title: 'Bottom Navigation',
      home: Home(),
    );
  }
}
/*main() async {
  var connection = new PostgreSQLConnection("ec2-54-225-106-93.compute-1.amazonaws.com", 5432, "d67nqkf3arp740", username: "szzrympmyxwqci", password: "2f886bf6b8dfa3426adfb08852a5b5898dd32ceefa4f08e8bd539a6a57ae4aea",useSSL: true);
  print("c sonnecting ...");
  await connection.open();
  print("Connected");
  await connection.close();
  //postgressql connection


  //print(results);
}*/