import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:glitchApp/main.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class changePass extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false, home: changePassword());
  }
}

class changePassword extends StatefulWidget {
  var userName;
  var token;

  changePassword({this.token, this.userName});

  @override
  _changePasswordState createState() => _changePasswordState();
}

class _changePasswordState extends State<changePassword> {
  var userName = LoginPage.user;
  var token = LoginPage.token;
  var passwd = LoginPage.passwd;
  var baseURL = LoginPage.baseURL;

  TextEditingController newPasswd = new TextEditingController();
  TextEditingController oldpasswd = new TextEditingController();

  var keyColor0 = Colors.black54;
  var keyColor1 = Colors.black54;

  Map<String, String> get headers => {
        "Access-Token": token,
        "User-Name": userName,
        "Password": passwd,
      };

  Future<String> updatePasswd() async {
    var responser = await http.put(
        "" +
            baseURL +
            "update-password?newPassword=" +
            newPasswd.text +
            "&oldPassword=" +
            oldpasswd.text +
            "&userName=" +
            userName +
            "",
        headers: headers);

    print(responser.body);
    if (responser.body == "Invalid Token !") {
      (context as Element).reassemble();
      showDialog(
        builder: (context) => new AlertDialog(
          title: new Text("Something went Wrong"),
          content: new Stack(
            children: <Widget>[
              Container(
                child: Text("Your session is over.Please,login again."),
              )
            ],
          ),
        ),
        context: context,
      );
    } else if (responser.body == "Unauthorized.") {
      showDialog(
        builder: (context) => new AlertDialog(
          title: new Text("Something went Wrong"),
          content: new Stack(
            children: <Widget>[
              Container(
                child: Text("Authorization ERROR.Please,login again."),
              )
            ],
          ),
        ),
        context: context,
      );
    } else if (responser.body == "Wrong Password !") {
      showDialog(
        builder: (context) => new AlertDialog(
          title: new Text("Something went Wrong"),
          content: new Stack(
            children: <Widget>[
              Container(
                child: Text("Please,re-login and try again."),
              )
            ],
          ),
        ),
        context: context,
      );
    } else if (responser.body == "Update fail") {
      showDialog(
        builder: (context) => new AlertDialog(
          title: new Text("Something went Wrong!"),
          content: new Stack(
            children: <Widget>[
              Container(
                child: Text("Something went wrong.Please,try again."),
              )
            ],
          ),
        ),
        context: context,
      );
    } else {
      showDialog(
        builder: (context) => new AlertDialog(
          title: new Text("Done!"),
          content: new Stack(
            children: <Widget>[
              Container(
                child: Text("Your password has been updated."),
              )
            ],
          ),
          actions: <Widget>[
            RaisedButton(
              onPressed: () {
                Navigator.of(context, rootNavigator: true).pop('dialog');
                (context as Element).reassemble();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MyApp(),
                  ),
                );
              },
              child: Text("ok"),
            ),
          ],
        ),
        context: context,
      );
      //passwd = newPasswd.text;
    }

    return "Success";
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWeight = MediaQuery.of(context).size.width;

    //var token = LoginPage.token;
    return Scaffold(
      backgroundColor: Color(0xFF73AEF5),
      appBar: AppBar(
        backgroundColor: Color(0xFF1976D2),
        title: Text(
          "Change Password",
          style: TextStyle(fontFamily: 'Raleway', color: Colors.white),
        ),
      ),
      body: Center(
          child: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white24,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(80),
              topRight: Radius.circular(80),
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 10,
              ),
              CircleAvatar(
                backgroundColor: Color(0xFF398AE5),
                radius: 50,
                child: FaIcon(
                  FontAwesomeIcons.expeditedssl,
                  color: Colors.white70,
                  size: 60,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                child: Divider(),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                child: TextField(
                  onEditingComplete: () {
                    if (oldpasswd.text == passwd) {
                      keyColor0 = Colors.green;
                    } else {
                      keyColor0 = Colors.red;
                    }
                  },
                  onChanged: (value) {
                    if (oldpasswd.text == passwd) {
                      keyColor0 = Colors.green;
                    } else {
                      keyColor0 = Colors.red;
                    }
                  },
                  controller: oldpasswd,
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.vpn_key,
                      color: keyColor0,
                    ),
                    labelText: "Current Password",
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black38),
                    ),
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                child: TextField(
                  onChanged: (value) {
                    if (newPasswd.text == passwd) {
                      keyColor1 = Colors.red;
                    } else {
                      keyColor1 = Colors.green;
                    }
                  },
                  controller: newPasswd,
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.vpn_key,
                      color: keyColor1,
                    ),
                    labelText: "New Password",
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black38),
                    ),
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                child: RaisedButton.icon(
                  //Update Password
                  onPressed: () {
                    if (newPasswd.text.length < 5) {
                      showDialog(
                        builder: (context) => new AlertDialog(
                          title: new Text("Too Short!"),
                          content: new Stack(
                            children: <Widget>[
                              Container(
                                child: Text(
                                    "Please, try something BIG!.[Minimum length 6]"),
                              )
                            ],
                          ),
                          actions: <Widget>[
                            RaisedButton(
                              onPressed: () {
                                Navigator.of(context, rootNavigator: true)
                                    .pop('dialog');
                              },
                              child: Text("ok"),
                            ),
                          ],
                        ),
                        context: context,
                      );
                    } else if (oldpasswd.text != passwd) {
                      showDialog(
                        builder: (context) => new AlertDialog(
                          title: new Text("Error!"),
                          content: new Stack(
                            children: <Widget>[
                              Container(
                                child: Text(
                                    "Current password is incorrect!Please,try again."),
                              )
                            ],
                          ),
                          actions: <Widget>[
                            RaisedButton(
                              onPressed: () {
                                Navigator.of(context, rootNavigator: true)
                                    .pop('dialog');
                              },
                              child: Text("ok"),
                            ),
                          ],
                        ),
                        context: context,
                      );
                    } else if (newPasswd.text == passwd) {
                      showDialog(
                        builder: (context) => new AlertDialog(
                          title: new Text("Error!"),
                          content: new Stack(
                            children: <Widget>[
                              Container(
                                child: Text(
                                    "Current password & new password can not be same.Please,try again."),
                              )
                            ],
                          ),
                          actions: <Widget>[
                            RaisedButton(
                              onPressed: () {
                                Navigator.of(context, rootNavigator: true)
                                    .pop('dialog');
                              },
                              child: Text("ok"),
                            ),
                          ],
                        ),
                        context: context,
                      );
                    } else {
                      this.updatePasswd();
                      print(newPasswd.text.length);
                    }
                  },
                  icon: FaIcon(
                    FontAwesomeIcons.key,
                    //color: Colors.white70,
                    size: 20,
                  ),
                  label: Text(
                    "Update Password",
                    //style: TextStyle(fontSize: 15),
                  ),
                  color: Colors.green,
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
