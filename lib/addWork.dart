import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:glitchApp/main.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class AddRefe extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: AddWork());
  }
}

class AddWork extends StatefulWidget {
  var userName;
  var token;

  AddWork({this.token, this.userName});

  @override
  _AddWorkState createState() => _AddWorkState();
}

class _AddWorkState extends State<AddWork> {
  var userName = LoginPage.user;
  var token = LoginPage.token;
  var passwd = LoginPage.passwd;
  var baseURL = LoginPage.baseURL;

  TextEditingController title = new TextEditingController();
  TextEditingController name = new TextEditingController();
  TextEditingController position = new TextEditingController();
  TextEditingController start = new TextEditingController();
  TextEditingController end = new TextEditingController();

  DateTime _dateTime;

  var keyColor0 = Colors.black54;
  var keyColor1 = Colors.black54;

  Map<String, String> get headers => {
        "Access-Token": token,
        "User-Name": userName,
        "Password": passwd,
      };

  Future<String> addWork() async {
    var responser = await http.post(
        "" +
            baseURL +
            "update-employment?type=" +
            title.text +
            "&orgName=" +
            name.text +
            "&rank=" +
            position.text +
            "&start=" +
            start.text +
            "&end=" +
            end.text +
            "",
        headers: headers);

    print(responser.body);

    if (responser.body == "401") {
      (context as Element).reassemble();
      showDialog(
        context: context,
        child: new AlertDialog(
          title: new Text("Something went Wrong"),
          content: new Stack(
            children: <Widget>[
              Container(
                child: Text("Your session is over.Please,login again."),
              )
            ],
          ),
        ),
      );
    } else if (responser.body == "405") {
      (context as Element).reassemble();
      showDialog(
        context: context,
        child: new AlertDialog(
          title: new Text("ERROR!"),
          content: new Stack(
            children: <Widget>[
              Container(
                child: Text("Request Method Unknown. [Status Code: 405]"),
              )
            ],
          ),
          actions: <Widget>[
            RaisedButton(
              onPressed: () {
                Navigator.of(context, rootNavigator: true).pop('dialog');
              },
              child: Text("ok"),
            ),
          ],
        ),
      );
    } else if (responser.body == "304") {
      (context as Element).reassemble();
      showDialog(
        context: context,
        child: new AlertDialog(
          title: new Text("ERROR!"),
          content: new Stack(
            children: <Widget>[
              Container(
                child:
                    Text("Not Modified.Please,try again. [Status Code: 305]"),
              )
            ],
          ),
          actions: <Widget>[
            RaisedButton(
              onPressed: () {
                Navigator.of(context, rootNavigator: true).pop('dialog');
              },
              child: Text("ok"),
            ),
          ],
        ),
      );
    } else if (responser.body == "200") {
      (context as Element).reassemble();
      showDialog(
        context: context,
        child: new AlertDialog(
          title: new Text("Done!"),
          content: new Stack(
            children: <Widget>[
              Container(
                child: Text("Employment information has been updated."),
              )
            ],
          ),
          actions: <Widget>[
            RaisedButton(
              onPressed: () {
                Navigator.of(context, rootNavigator: true).pop('dialog');
                (context as Element).reassemble();
                Navigator.of(context, rootNavigator: true).pop('dialog');
              },
              child: Text("ok"),
            ),
          ],
        ),
      );
    } else {
      (context as Element).reassemble();
      showDialog(
        context: context,
        child: new AlertDialog(
          title: new Text("Error!"),
          content: new Stack(
            children: <Widget>[
              Container(
                child: Text("Cause unknown.Please,try again. [" +
                    responser.body.toString() +
                    "]"),
              )
            ],
          ),
          actions: <Widget>[
            RaisedButton(
              onPressed: () {
                Navigator.of(context, rootNavigator: true).pop('dialog');
              },
              child: Text("ok"),
            ),
          ],
        ),
      );
    }

    return "Success";
  }

  Future<String> nullValidator() async {
    //title.text/name.text/position.text/start.text/end.text
    if (title.text.length == 0) {
      showDialog(
        context: context,
        child: new AlertDialog(
          title: new Text("Empty Flask"),
          content: new Stack(
            children: <Widget>[
              Container(
                child: Text(
                    "Please,provide your employment type(Job/Intern/Business) & try again."),
              )
            ],
          ),
        ),
      );
    } else if (name.text.length == 0) {
      showDialog(
        context: context,
        child: new AlertDialog(
          title: new Text("Empty Flask"),
          content: new Stack(
            children: <Widget>[
              Container(
                child: Text(
                    "Please,provide your institute/organization name & try again."),
              )
            ],
          ),
        ),
      );
    } else if (position.text.length == 0) {
      showDialog(
        context: context,
        child: new AlertDialog(
          title: new Text("Empty Flask"),
          content: new Stack(
            children: <Widget>[
              Container(
                child: Text(
                    "Please,provide your position/rank at your work place & try again."),
              )
            ],
          ),
        ),
      );
    } else if (start.text.length == 0) {
      showDialog(
        context: context,
        child: new AlertDialog(
          title: new Text("Empty Flask"),
          content: new Stack(
            children: <Widget>[
              Container(
                child: Text(
                    "Please,provide your work starting/joining date & try again."),
              )
            ],
          ),
        ),
      );
    } else {
      addWork();
    }
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
          "Add New Work",
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
                  FontAwesomeIcons.briefcase,
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
                  controller: title,
                  decoration: InputDecoration(
                    prefixIcon: CircleAvatar(
                      child: FaIcon(
                        FontAwesomeIcons.briefcase,
                        color: Colors.black54,
                        size: 30,
                      ),
                      backgroundColor: Colors.transparent,
                    ),
                    labelText: "Employment Type",
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black38),
                    ),
                    border: OutlineInputBorder(),
                    hintText: "Business/Job/Intern",
                  ),
                  //enableSuggestions: true,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                child: TextField(
                  controller: name,
                  decoration: InputDecoration(
                    prefixIcon: CircleAvatar(
                      child: FaIcon(
                        FontAwesomeIcons.building,
                        color: Colors.black54,
                        size: 30,
                      ),
                      backgroundColor: Colors.transparent,
                    ),
                    labelText: "Institute Name",
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
                  controller: position,
                  decoration: InputDecoration(
                    prefixIcon: CircleAvatar(
                      child: FaIcon(
                        FontAwesomeIcons.chair,
                        color: Colors.black54,
                        size: 30,
                      ),
                      backgroundColor: Colors.transparent,
                    ),
                    labelText: "Position",
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
                  controller: start,
                  onTap: () {
                    FocusScope.of(context).requestFocus(new FocusNode());
                    showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2060),
                    ).then((date) {
                      setState(() {
                        _dateTime = date;
                      });
                      start.text = _dateTime.toString();
                    });
                  },
                  decoration: InputDecoration(
                    prefixIcon: CircleAvatar(
                      child: FaIcon(
                        FontAwesomeIcons.hourglassStart,
                        color: Colors.black54,
                        size: 30,
                      ),
                      backgroundColor: Colors.transparent,
                    ),
                    labelText: "Started at",
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
                  controller: end,
                  onTap: () {
                    FocusScope.of(context).requestFocus(new FocusNode());
                    showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2060),
                    ).then((date) {
                      setState(() {
                        _dateTime = date;
                      });
                      //end.text = dateFormat.format(_dateTime);
                      end.text = _dateTime.toString();
                    });
                  },
                  decoration: InputDecoration(
                    prefixIcon: CircleAvatar(
                      child: FaIcon(
                        FontAwesomeIcons.hourglassEnd,
                        color: Colors.black54,
                        size: 30,
                      ),
                      backgroundColor: Colors.transparent,
                    ),
                    labelText: "Ended at",
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
                    this.nullValidator();
                  },
                  icon: FaIcon(
                    FontAwesomeIcons.plusCircle,
                    //color: Colors.white70,
                    size: 20,
                  ),

                  label: Text(
                    "Add Work",
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
