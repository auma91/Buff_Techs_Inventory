import 'package:shared_preferences/shared_preferences.dart';
import 'package:postgres/postgres.dart';
import 'dart:async';
class Database{
  //conection info
  final _connection = new PostgreSQLConnection(
    'ec2-54-204-35-248.compute-1.amazonaws.com',
    5432,
    'd89hrep51rfp9a',
    username: 'ednykvpveeevsn',
    password: 'aeabb5b26b67cd313ddc3ebce90ef105d1ef331ea5ce817b34aa177b33a771f0',
    useSSL: true
  );
  /*
  * @return     the current users identikey
  *
  * */
  Future<String>_getIdentikey() async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'my_user';
    final String value = prefs.getString(key) ?? '';
    return value;
  }
  ///Get all items linked to specific user.
  ///@return nested list of checked out items.
  Future<List<List<dynamic>>> allItems () async{
    final String user = await _getIdentikey();
    print("Connecting ..."); //I was having connection issues, in part due to data base set up and also due to
    await _connection.open();
    print("Connected");
    String identikey = await _getIdentikey();
    List<List<dynamic>> results = await _connection.query("SELECT * FROM items WHERE id = ANY(SELECT item_id FROM log WHERE identikey = '" + identikey + "');");
    _connection.close();
    return results;
  }

  /*Update info in both the log and the items tables
  * @param String serial_number    unique serial number passed in.
  * */
  addbySerial(String serial_number) async{
    print("Connecting ...");
    await _connection.open();
    print("Connected");
    String user = await _getIdentikey();
    var result = await _connection.query("UPDATE items SET checked_out = true WHERE serial_number = '" + serial_number + "';");
    var id = await _connection.query("SELECT id FROM items WHERE serial_number = '" + serial_number + "';");
    result = await _connection.query("INSERT INTO log (identikey, item_id, checked_out_time) VALUES ('" + user + "'," + id.toString() + "," + DateTime.now().millisecondsSinceEpoch.toString() +");");
    _connection.close();
  }

  /*Update info in both the log and the items tables
  * @param String serial_number    unique serial number passed in.
  * */
  removebySerial(String serial_number) async{
    print("Connecting ...");
    await _connection.open();
    print("Connected");
    //Dummy query
    var result = await _connection.query("DELETE FROM items WHERE items.serial_number = '" + serial_number + "';");
    _connection.close();
  }
  main() async{
    //print(await allItems());
  }
}
//"SELECT * FROM items"