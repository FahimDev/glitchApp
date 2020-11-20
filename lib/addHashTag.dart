import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:glitchApp/hashTag.dart';
import 'package:glitchApp/main.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class AddHashTag extends StatefulWidget {
  @override
  _AddHashTagState createState() => _AddHashTagState();
}

class _AddHashTagState extends State<AddHashTag> {
  var userName = LoginPage.user;
  var token = LoginPage.token;
  var passwd = LoginPage.passwd;
  var baseURL = LoginPage.baseURL;

  TextEditingController title = new TextEditingController();

  var keyColor0 = Colors.black54;
  var keyColor1 = Colors.black54;

  Map<String, String> get headers => {
        "Access-Token": token,
        "User-Name": userName,
        "Password": passwd,
      };

  Future<String> addRef(String title, String color) async {
    var responser = await http.post(
        "" +
            baseURL +
            "/update-hashtag?hashTag=" +
            title +
            "&color=" +
            color +
            "",
        headers: headers);

    print(responser.body);
    if (responser.body == "Invalid Token !") {
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
    } else if (responser.body == "Unauthorized.") {
      showDialog(
        context: context,
        child: new AlertDialog(
          title: new Text("Something went Wrong"),
          content: new Stack(
            children: <Widget>[
              Container(
                child: Text("Authorization ERROR.Please,login again."),
              )
            ],
          ),
        ),
      );
    } else if (responser.body == "Wrong Password !") {
      showDialog(
        context: context,
        child: new AlertDialog(
          title: new Text("Something went Wrong"),
          content: new Stack(
            children: <Widget>[
              Container(
                child: Text("Please,re-login and try again."),
              )
            ],
          ),
        ),
      );
    } else if (responser.body == "Update fail") {
      showDialog(
        context: context,
        child: new AlertDialog(
          title: new Text("Something went Wrong!"),
          content: new Stack(
            children: <Widget>[
              Container(
                child: Text("Something went wrong.Please,try again."),
              )
            ],
          ),
        ),
      );
    } else if (responser.body == "success") {
      showDialog(
        context: context,
        child: new AlertDialog(
          title: new Text("Done!"),
          content: new Stack(
            children: <Widget>[
              Container(
                child: Text("Your reference has been added."),
              )
            ],
          ),
          actions: <Widget>[
            RaisedButton(
              onPressed: () {
                Navigator.of(context, rootNavigator: true).pop('dialog');
                Navigator.of(context, rootNavigator: true).pop('dialog');
              },
              child: Text("ok"),
            ),
          ],
        ),
      );
    } else {
      showDialog(
        context: context,
        child: new AlertDialog(
          title: new Text("Unknown Error!"),
          content: new Stack(
            children: <Widget>[
              Container(
                child: Text("Something went wrong.Please,try again."),
              )
            ],
          ),
        ),
      );
    }

    return "Success";
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWeight = MediaQuery.of(context).size.width;
    //print(HashTagPage.hashType);
    print(HashTagPage.currentInfo);
    title.text = HashTagPage.currentInfo;
    //var token = LoginPage.token;
    return Scaffold(
      backgroundColor: Color(0xFF73AEF5),
      appBar: AppBar(
        backgroundColor: Color(0xFF1976D2),
        title: Text(
          "#HashTag",
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
                  FontAwesomeIcons.hashtag,
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
                        FontAwesomeIcons.hashtag,
                        color: Colors.black54,
                        size: 30,
                      ),
                      backgroundColor: Colors.transparent,
                    ),
                    labelText: "Title",
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black38),
                    ),
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                child: Row(
                  children: <Widget>[
                    Container(
                      child: CircleAvatar(
                        child: FaIcon(
                          FontAwesomeIcons.palette,
                          color: Colors.black54,
                          size: 30,
                        ),
                        backgroundColor: Colors.transparent,
                      ),
                    ),
                    Container(
                      child: MyColorWidget(),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                child: RaisedButton.icon(
                  //Update Password
                  onPressed: () {
                    this.addRef(title.text, _MyColorWidgetState.newData);
                  },

                  icon: FaIcon(
                    HashTagPage.hashType == "add"
                        ? FontAwesomeIcons.plusCircle
                        : HashTagPage.hashType == "edit"
                            ? FontAwesomeIcons.edit
                            : FontAwesomeIcons.upload,
                    //color: Colors.white70,
                    size: 20,
                  ),
                  label: Text(
                    "Submit #HashTag",
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

//################COLOR####################
class MyColorWidget extends StatefulWidget {
  MyColorWidget({Key key}) : super(key: key);

  @override
  _MyColorWidgetState createState() => _MyColorWidgetState();
}

class _MyColorWidgetState extends State<MyColorWidget> {
  String dropdownValue = 'Light Blue';
  static String newData = "Null";
  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: dropdownValue,
      icon: Icon(Icons.arrow_downward),
      iconSize: 24,
      elevation: 16,
      style: TextStyle(color: Colors.black87),
      underline: Container(
        height: 2,
        color: Colors.deepPurpleAccent,
      ),
      onChanged: (String newValue) {
        setState(() {
          dropdownValue = newValue;
          newData = newValue;
          print(newValue + "  1");
          print(dropdownValue);
          print(newValue + "  2");
        });
      },
      items: <String>[
        'Light Blue',
        'Blue',
        'Green',
        'Gray',
        'Black',
        'Yellow',
        'Red',
      ].map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
