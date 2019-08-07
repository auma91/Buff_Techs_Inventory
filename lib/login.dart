import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
class Login extends StatelessWidget{
  String _user ='';
  String _pass='';
  _save(String val) async {
    //user library to get a pref instance, than set the a key and a value, the key being the identikey
    //will be removed later, acts more of a confirmation of saving for me.
    final prefs = await SharedPreferences.getInstance();
    final key = 'my_user';
    prefs.setString(key, val);
    print('saved $val');
  }
  _read() async {
    //retrieval of a key's value pair
    final prefs = await SharedPreferences.getInstance();
    final key = 'my_user';
    final value = prefs.getString(key) ?? '';
    print('read: $value');
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: <Widget>[
            Spacer(),
            Image.asset("images/circuit.png", width: 100,),
            Container(
              height: MediaQuery.of(context).size.height/2,
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.only(top: 62),
              child: Column(
                children: <Widget>[
                  textInput('Identikey', Icons.supervised_user_circle, context),
                  textInput('Password', Icons.vpn_key, context),
                  Spacer(),
                  loginButton(context),
                  Spacer(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
  submit(context) async{
    if(_pass.isEmpty | _user.isEmpty){ //if either field is
      if(_pass.isEmpty & _user.isEmpty) {
        //no credentials provided
        Alert(
          context: context,
          type: AlertType.error,
          title: 'Please Input Credentials',
        ).show();
      }
      else if(_user.isEmpty) {
        //No password provided
        Alert(
          context: context,
          type: AlertType.error,
          title: 'Missing User name',
        ).show();
      }
      else {
        //no identikey provided
        Alert(
          context: context,
          type: AlertType.error,
          title: 'Missing Password',
        ).show();
      }
    }
    else { //if both fields are full
      if(_pass == 'done'){ //check password currently I have a dummy value,
        // TODO: Should also cross check user input with a list of technicians.
        await _save(_user); //use the shared_pref library to store the the identikey, this will allow for the home screen to pull checked out items to him/her
        await _read(); //print debugging purposes should be removed soon.
      }
      else {
        //wrong password
        Alert(
          context: context,
          type: AlertType.error,
          title: 'Invalid Credentials',
        ).show();
      }
    }
  }
  Widget textInput(String hint, IconData icon, context) {
    //given that there two text inputs that differ only in icon and hint text I decided to make a function for itn
    return Container(
      //container widget which takes in account device width and uses a fixed height of 45
      width: MediaQuery.of(context).size.width/1.2,
      height: 45,
      margin: EdgeInsets.only(top: 32),
      padding: EdgeInsets.only(
          top: 4,left: 16, right: 16, bottom: 4
      ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
              Radius.circular(50)
          ),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                color: Colors.black12,
                blurRadius: 5
            )
          ]
      ),
      child: TextField(
        onChanged: (text){
          _pass = text;
          print(_pass);
        },
        decoration: InputDecoration(
          border: InputBorder.none,
          icon: Icon(icon,
            color: Colors.grey,
          ),
          hintText: hint,
        ),
      ),
    );
  }
  Widget loginButton(context) {
    //TODO: Fix the rounded edges on the button
    return RaisedButton(
      onPressed: submit(context),
      padding: const EdgeInsets.all(0),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFf45d27),
              Color(0xFFf5851f)
            ],
          ),
          /*borderRadius: BorderRadius.all(
                              Radius.circular(50)
                          )*/
        ),
        padding: const EdgeInsets.all(20.0),
        child: const Text(
            'Gradient Button',
            style: TextStyle(fontSize: 20)
        ),
      ),
    );
  }
}