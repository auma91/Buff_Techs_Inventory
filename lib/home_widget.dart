import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import './slide_widget.dart';
import './placeholder_widget.dart';
class Home extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _HomeState();
    //Given we will need a form a dynamic screen, I used a StatefulWidget
  }
}

class _HomeState extends State<Home> {
  int _currentIndex = 0; // to be used in onTabTapped
  String _counter,_value = "";
  final List<Widget> _children =[new Slide(Colors.amberAccent), PlaceholderWidget(Colors.white)];
  /*There will a bottom navigation bar, with two sections, with a floating action button for opening the QR scanning.
  * The List above represents my two screens that you see depending on what tab of the bottom app bar that you click.
  * The first screen will have items checked out to the user (which was set using shared prefs. Check login.dart for more detals)
  * TODO: Need to make the second tab be either a profile page or an all time log. TBD at the moment*/
  /*
  * Return a pop up if the picked up barcode isn't for this inventory systems
  * @param context               context of the build widget
  * @return                      Alert dialog from the rflutter alert package
  * */
  _invaliditemAlert(context) {
    Alert(
        context: context,
        type: AlertType.error,
        title: 'Invalid item',
        desc: "Please check if this is an item in store.")
        .show();
  }
  /*
  * Return a pop up if the picked up barcode is valid
  * @param context               context of the build widget
  * @param String title          the item name to show on alert
  * @return                      Alert dialog from the rflutter alert package
  * */
  _itemAlert(context, String title) {
    Alert(
      context: context,
      image: Image.asset("images/circuit.png", width: 100,),
      //type: AlertType.info,
      title: "Item: " + title,
      desc: "Would you like to checkout this item?",
      buttons: [
        DialogButton(
          child: Text(
            "No",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => Navigator.pop(context),
          color: Color.fromRGBO(0, 179, 134, 1.0),
        ),
        DialogButton(
          child: Text(
            "Yes",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => Navigator.pop(context),
          gradient: LinearGradient(colors: [
            Color.fromRGBO(116, 116, 191, 1.0),
            Color.fromRGBO(52, 138, 199, 1.0)
          ]),
        )
      ],
    ).show();
  }

  /*
  * TODO: Make a pop up for when the more button is clicked on the slidable object (items)
  * getMore(context, name, serial, postgres_id)
  * */

  /*
  * if the bottom app bar is touched the tab will be switched*
  * @param int index              index in _children list
  * */
  void onTabTapped(int index) {
    //this is how we dynamically change pages, (note to self: in flutter there stateless and stateful objects)
    setState(() {
      _currentIndex = index;
      print(_currentIndex);
    });
  }
  /*
  * For use of the flutter barcode scan library
  *
  * @param context                Build context
  * @return future                scanBarcode is an asynchronous method that is called that read a barcode and put the data in _counter and then determine if its a buff techs item
  * */
  Future _incrementCounter(context) async {
    _counter = await FlutterBarcodeScanner.scanBarcode("#004297", "Cancel", true);
    setState(() {
      if(_counter.contains('bt-server.colorado.edu')){
        _value = _counter.substring(_counter.indexOf('deviceID=')+9);
        _itemAlert(context, _value);
      }
      else if(_counter.isNotEmpty){
        _invaliditemAlert(context);
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Inventory'),
        backgroundColor: Colors.black38,
        centerTitle: true,
      ),
      body: _children[_currentIndex], //Quick note this is where the setstate comes into play.
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
            IconButton(
              icon: Icon(Icons.scanner),
              onPressed: (){
              onTabTapped(0);
              _itemAlert(context, 'SSD');
            },),
            IconButton(
                icon: Icon(Icons.mail),
                onPressed: (){onTabTapped(1);}),
          ],
        ),
      ),
      //Personal note: Personally, I just wanted a center button that has the app bar curve around it
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

/*
    Some old code from the original bottom app bar but I couldn't figure out quite how to get it to work with a floating action button with the shape i desired
    BottomNavigationBar(
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