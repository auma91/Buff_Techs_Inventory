import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import './postgresdata.dart';
class Slide extends StatefulWidget{
  final Color color;
  Slide(this.color);
  @override
  State<StatefulWidget> createState(){
    return _SlideObj(color);
  }
}
class _SlideObj extends State<Slide> {
  final Color color;
  _SlideObj(this.color);
  Future<List<List<dynamic>>> _query;

  /*
   * This is where initialize a list of objects
   * More info: https://api.flutter.dev/flutter/widgets/State/initState.html
   */
  @override
  void initState() {
    super.initState();
    _query = getItems();
  }
  /*
  * For the moment this acts as my method for refreshing the list of items that are checked out.
  * TODO: Implement a pull down to refresh
  * */
  void _retry() {
    setState(() {
      _query = getItems();
    });
  }
  /*
  * Call the database class i have to remove item
  * @param String serial       serial number of object for use in my WHERE statement (look in database one for more specifics)
  * */
  void removeItem(String serial) {
    Database remove = new Database();
    remove.removebySerial(serial.substring(serial.indexOf(":")+2));
    //I call this use of substring because the serial string contains "Serial: "
  }
  /*
  * Method to make horizontally slidable object, if you slide your finger over the onject form right to left you get a more and delete option
  * @param String name         name of object
  * @param String serial       serial number of object which is what I plan on using for passing on to the delete function
  * */
  Widget constructSlide(String name, String serial) {
    return new Slidable(
      actionPane: SlidableDrawerActionPane(),
      actionExtentRatio: 0.25,
      child: Container(
        color: Colors.white,
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.indigoAccent,
            child: new Icon(Icons.memory),
            foregroundColor: Colors.white,
          ),
          title: Text(name),
          subtitle: Text(serial),
        ),
      ),
      secondaryActions: <Widget>[
        IconSlideAction(
          caption: 'More',
          color: Colors.black45,
          icon: Icons.more_horiz,
          closeOnTap: true,
          //TODO: onTap: open a more pop up (have name, serial num, price to replace perhaps, etc)
        ),
        IconSlideAction(
          caption: 'Remove',
          color: Colors.red,
          icon: Icons.delete,
          closeOnTap: true,
          onTap: (){
            removeItem(serial);
          },
        ),
      ],
    );
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      color: color,
      child: new Column(
        children: <Widget>[
          /*
          * I have to use a Futurebuilder due to fact that the way i pull queries from mmy postgres database is using an async function.
          * I realize that, at least according to some stack overflow searches and whatnot I should avoid calling an async function.
          * For now I just want to prototype and get this part of the app fuctional.*/
          FutureBuilder<List<List<dynamic>>>(
            future: _query,
            builder: (BuildContext context, AsyncSnapshot<List<List<dynamic>>> snapshot) {
              List<Widget> fun = [];
              //I plan to add a column with full of constructSlide children
              if (snapshot.hasData) {
                for(int i = 0; i < snapshot.data.length; i++){
                  fun.add(constructSlide(snapshot.data[i][1], "Serial: " + snapshot.data[i][2]));
                }
                print(fun);
                return Column(
                  children: fun,
                );
              } else {
                //While we we wait for this Future Builder to build.
                return constructSlide("Fetching data", "...");
              }
            },
          ),
          //Refresh button, would like to replace with a pull down to refresh option.
          RaisedButton(
            onPressed: _retry,
            child: Text('Refresh'),
            hoverColor: Colors.white,
          )
        ],//<Widget>[constructSlide('SSD', 'T565')],
      )
    );
  }
  /*
    Get a list of all my queries.
    @return a nested list with a query of all the data checked out by a specific user.
   */
  Future<List<List<dynamic>>> getItems() async {
    Database items = new Database();
    List<List<dynamic>> query = await items.allItems();
    return query;
  }
}
/*

*/
