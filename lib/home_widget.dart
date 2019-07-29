import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
//import 'package:flutter_slidable/flutter_slidable.dart';
import './placeholder_widget.dart';
class Home extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _HomeState();
  }
}

class _HomeState extends State<Home> {
  int _currentIndex =0;
  final List<Widget> _children =[PlaceholderWidget(Colors.amber),PlaceholderWidget(Colors.white),PlaceholderWidget(Colors.red)];
  _onBasicAlertPressed(context) {
    Alert(
        context: context,
        title: "RFLUTTER ALERT",
        desc: "Flutter is more awesome with RFlutter Alert.")
        .show();
  }
  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
  String _counter,_value = "";
  Future _incrementCounter(context) async {
    _counter = await FlutterBarcodeScanner.scanBarcode("#004297", "Cancel", true);
    setState(() {
      _value = _counter;
    });
    _onBasicAlertPressed(context);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Flutter App'),
        backgroundColor: Colors.black38,
        centerTitle: true,
      ),
      body: _children[_currentIndex],
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.scanner),
        onPressed: (){_incrementCounter(context);},
      ),

      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 5.0,
        child: new Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(icon: Icon(Icons.scanner) , onPressed: (){
              onTabTapped(0);
            },),
            IconButton(icon: Icon(Icons.mail) , onPressed: (){
              onTabTapped(1);

            }),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

/*BottomNavigationBar(
        onTap: onTabTapped,
        currentIndex: _currentIndex, // this will be set when a new tab is tapped
        items: [
          BottomNavigationBarItem(
            icon: new Icon(Icons.scanner),
            title: new Text('QR'),
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.mail),
            title: new Text('Messages'),
          ),
          /*BottomNavigationBarItem(
              icon: Icon(Icons.person),
              title: Text('Profile')
          )*/
        ],
      ),
      */