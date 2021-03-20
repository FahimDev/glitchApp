import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:glitchApp/hashTag.dart';
import 'package:glitchApp/main.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class AddHashTag extends StatefulWidget {
  int id;
  var hashType;
  var hashTitle;
  var hashCol;

  AddHashTag(
      {Key key,
      @required this.id,
      @required this.hashType,
      @required this.hashTitle,
      @required this.hashCol})
      : super(key: key);

  @override
  _AddHashTagState createState() =>
      _AddHashTagState(id, hashType, hashTitle, hashCol);
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

  Future<String> addHash(String title, String color) async {
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
    if (responser.body == "401") {
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
    } else if (responser.body == "405") {
      (context as Element).reassemble();
      showDialog(
        builder: (context) => new AlertDialog(
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
        context: context,
      );
    } else if (responser.body == "304") {
      (context as Element).reassemble();
      showDialog(
        builder: (context) => new AlertDialog(
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
        context: context,
      );
    } else if (responser.body == "200") {
      (context as Element).reassemble();
      showDialog(
        builder: (context) => new AlertDialog(
          title: new Text("Done!"),
          content: new Stack(
            children: <Widget>[
              Container(
                child: Text("New #HashTag has been added."),
              )
            ],
          ),
          actions: <Widget>[
            RaisedButton(
              onPressed: () {
                Navigator.of(context, rootNavigator: true).pop('dialog');

                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HashTagPage()),
                );
              },
              child: Text("ok"),
            ),
          ],
        ),
        context: context,
      );
    } else {
      (context as Element).reassemble();
      showDialog(
        builder: (context) => new AlertDialog(
          title: new Text("Error!"),
          content: new Stack(
            children: <Widget>[
              Container(
                child: Text("Cause unknown.Please,try again." +
                    responser.body.toString()),
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
        context: context,
      );
    }

    return "Success";
  }

  Future<String> putHash(int id, String title, String color) async {
    var responser = await http.put(
        "" +
            baseURL +
            "/update-hashtag?hashTag=" +
            title +
            "&color=" +
            color +
            "&id=" +
            id.toString() +
            "",
        headers: headers);

    print(responser.body);
    if (responser.body == "401") {
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
    } else if (responser.body == "405") {
      (context as Element).reassemble();
      showDialog(
        builder: (context) => new AlertDialog(
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
        context: context,
      );
    } else if (responser.body == "304") {
      (context as Element).reassemble();
      showDialog(
        builder: (context) => new AlertDialog(
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
        context: context,
      );
    } else if (responser.body == "200") {
      (context as Element).reassemble();
      showDialog(
        builder: (context) => new AlertDialog(
          title: new Text("Done!"),
          content: new Stack(
            children: <Widget>[
              Container(
                child: Text("#HashTag has been updated."),
              )
            ],
          ),
          actions: <Widget>[
            RaisedButton(
              onPressed: () {
                Navigator.of(context, rootNavigator: true).pop('dialog');

                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HashTagPage()),
                );
              },
              child: Text("ok"),
            ),
          ],
        ),
        context: context,
      );
    } else {
      (context as Element).reassemble();
      showDialog(
        builder: (context) => new AlertDialog(
          title: new Text("Error!"),
          content: new Stack(
            children: <Widget>[
              Container(
                child: Text("Cause unknown.Please,try again." +
                    responser.body.toString()),
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
        context: context,
      );
    }

    return "Success";
  }

  int id;
  var hashType;
  var hashTitle;
  var hashCol;

  Color _col = Colors.black54;
  _AddHashTagState(this.id, this.hashType, this.hashTitle, this.hashCol);

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWeight = MediaQuery.of(context).size.width;

    if (hashType == "edit") {
      //title.text = hashTitle;

      if (hashCol == "info") {
        _col = Colors.lightBlue;
      } else if (hashCol == "danger") {
        _col = Colors.red;
      } else if (hashCol == "success") {
        _col = Colors.green;
      } else if (hashCol == "warning") {
        _col = Colors.yellow;
      } else if (hashCol == "secondary") {
        _col = Colors.grey;
      } else if (hashCol == "dark") {
        _col = Colors.black;
      } else {
        _col = Colors.blue;
      }
    }

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
                    labelText: hashTitle,
                    hintText: hashTitle,
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black38),
                    ),
                    border: OutlineInputBorder(),
                  ),
                  onTap: () {
                    hashType == "edit"
                        ? title.text = hashTitle
                        : hashTitle = "Title";
                  },
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
                          color: _col,
                          size: 30,
                        ),
                        backgroundColor: Colors.transparent,
                      ),
                    ),
                    Container(
                      child: MyColorWidget(
                        hashCol: hashCol,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                child: RaisedButton.icon(
                  onPressed: () {
                    if (hashType == "add") {
                      if (title.text.length <= 0) {
                        showDialog(
                          builder: (context) => new AlertDialog(
                            title: new Text("Emplty Flex"),
                            content: new Stack(
                              children: <Widget>[
                                Container(
                                  child:
                                      Text("#HashTag Title can not be empty!"),
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
                        this.addHash(
                            title.text, _MyColorWidgetState.dropdownValue);
                      }
                    } else {
                      if (title.text.length <= 0) {
                        title.text = hashTitle;
                        this.putHash(
                            id, title.text, _MyColorWidgetState.dropdownValue);
                      } else {
                        this.putHash(
                            id, title.text, _MyColorWidgetState.dropdownValue);
                      }
                    }
                  },
                  icon: FaIcon(
                    hashType == "add"
                        ? FontAwesomeIcons.plusCircle
                        : hashType == "edit"
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
  var hashCol;
  MyColorWidget({Key key, @required this.hashCol}) : super(key: key);

  @override
  _MyColorWidgetState createState() => _MyColorWidgetState(hashCol);
}

class _MyColorWidgetState extends State<MyColorWidget> {
  String hashCol = "Light Blue";
  _MyColorWidgetState(this.hashCol);

  Color _col = Colors.deepPurpleAccent;
  bool change = false;

  static String dropdownValue = "Light Blue";
  //static String newData = "Null";

  @override
  Widget build(BuildContext context) {
    if (change == false) {
      if (hashCol == "info") {
        _col = Colors.lightBlue;
        dropdownValue = "Light Blue";
      } else if (hashCol == "danger") {
        _col = Colors.red;
        dropdownValue = "Red";
      } else if (hashCol == "success") {
        _col = Colors.green;
        dropdownValue = "Green";
      } else if (hashCol == "warning") {
        _col = Colors.yellow;
        dropdownValue = "Yellow";
      } else if (hashCol == "secondary") {
        _col = Colors.grey;
        dropdownValue = "Grey";
      } else if (hashCol == "dark") {
        _col = Colors.black;
        dropdownValue = "Black";
      } else if (hashCol == "primary") {
        _col = Colors.blue;
        dropdownValue = "Blue";
      } else {
        _col = Colors.deepPurpleAccent;
      }
    }

    return DropdownButton<String>(
      value: dropdownValue,
      icon: Icon(Icons.arrow_downward),
      iconSize: 24,
      elevation: 16,
      style: TextStyle(color: Colors.black87),
      underline: Container(
        height: 2,
        color: _col,
      ),
      onChanged: (String newValue) {
        setState(() {
          change = true;
          dropdownValue = newValue;
          //newData = newValue;
          //print(newValue + "  1");
          print(dropdownValue);
          //print(newValue + "  2");
        });
      },
      items: <String>[
        'Light Blue',
        'Blue',
        'Green',
        'Grey',
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
