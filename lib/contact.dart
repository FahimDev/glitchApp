import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
//import 'package:email_validator/email_validator.dart';
import 'package:glitchApp/main.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'dart:core';

class Contacts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: ContactsPage());
  }
}

class ContactsPage extends StatefulWidget {
  var userName;
  var token;

  ContactsPage({this.token, this.userName});

  @override
  _ContactsPageState createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {
  List myElement;
  var data;
  var number;
  var mail;
  Future<String> getProfile() async {
    var responser =
        await http.get("" + baseURL + "member-profile/" + userName + "");
    myElement = json.decode(responser.body.toString());
    data = myElement[0];
    number = data["contact"];
    mail = data["eMail"];

    return "Success";
    //_listView();
  }

  TextEditingController newData = new TextEditingController();
  updateMenu(String lable, String type, String current) {
    var currentInfo = current;
    newData.text = currentInfo;
    showDialog(
      context: context,
      child: new AlertDialog(
        title: new Text("Change '" + lable + "' section ?"),
        content: new Stack(
          children: <Widget>[
            Container(
              child: type == "contact"
                  ? TextField(
                      keyboardType: TextInputType.number,
                      minLines: 1,
                      maxLines: 5,
                      controller: newData,
                      decoration: InputDecoration(
                          hintText: lable,
                          counterText: "Current Information:" + currentInfo),
                    )
                  : TextField(
                      keyboardType: TextInputType.multiline,
                      minLines: 1,
                      maxLines: 5,
                      controller: newData,
                      decoration: InputDecoration(
                          hintText: lable,
                          counterText: "Current Information:" + currentInfo),
                    ),
            )
          ],
        ),
        actions: <Widget>[
          RaisedButton(
            onPressed: () {
              //newInfo = newData.text;
              newData.text = "";
            },
            child: Text("Make it Null"),
            color: Colors.yellowAccent,
          ),
          RaisedButton(
            onPressed: () {
              infoNoti();
              this.commitChange(type);
            },
            child: Text("Update"),
            color: Colors.green,
          ),
          RaisedButton(
            onPressed: () {
              Navigator.of(context, rootNavigator: true).pop('dialog');
              //(context as Element).reassemble();
            },
            child: Text("No"),
            color: Colors.red,
          ),
        ],
      ),
    );
  }

  infoNoti() {
    Navigator.of(context, rootNavigator: true).pop('dialog');
    //(context as Element).reassemble();
    showDialog(
      context: context,
      child: new AlertDialog(
        title: new Text("Updating..."),
        content: new Stack(
          children: <Widget>[
            Container(
              child: Text("Please,wait.This will take few seconds."),
            )
          ],
        ),
      ),
    );
  }

  //#####################################################
  Map<String, String> get headers => {
        "Access-Token": token,
        "User-Name": userName,
        "Password": passwd,
      };
  Future<String> commitChange(String type) async {
    var changeInfo = await http.put(
        "" +
            baseURL +
            "update-profile?userName=" +
            userName +
            "&type=" +
            type +
            "&data=" +
            newData.text +
            "",
        headers: headers);
    /*
    String email = newData.text;
    final bool isValid = EmailValidator.validate(email);
    print('Email is valid? ' + (isValid ? 'yes' : 'no'));
        */
    Navigator.of(context, rootNavigator: true).pop('dialog');
    (context as Element).reassemble();
    if (changeInfo.body == "Invalid Token !") {
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
    } else if (changeInfo.body == "Unauthorized.") {
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
    } else {
      (context as Element).reassemble();
      showDialog(
        context: context,
        child: new AlertDialog(
          title: new Text("Done!"),
          content: new Stack(
            children: <Widget>[
              Container(
                child: Text("Your contact information has been updated."),
              )
            ],
          ),
          actions: <Widget>[
            RaisedButton(
              onPressed: () {
                Navigator.of(context, rootNavigator: true).pop('dialog');
                //(context as Element).reassemble();
              },
              child: Text("ok"),
            ),
          ],
        ),
      );
    }
    print(changeInfo.body);
  }

  var userName = LoginPage.user;
  var token = LoginPage.token;
  var passwd = LoginPage.passwd;
  var baseURL = LoginPage.baseURL;

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWeight = MediaQuery.of(context).size.width;
    //var token = LoginPage.token;
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: AppBar(
          backgroundColor: Color(0xFF1976D2),
          title: Text(
            "Contacts",
            style: TextStyle(fontFamily: 'Raleway', color: Colors.white),
          ),
        ),
        backgroundColor: Colors.lightBlueAccent,
        body: FutureBuilder<String>(
          future: getProfile(),
          builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return new Container(
                child: Container(
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 50,
                      ),
                      Container(
                        child: Card(
                          elevation: 2,
                          child: ClipPath(
                            child: Container(
                              height: 100,
                              width: screenWeight,
                              child: ListTile(
                                title: Text(
                                  "Mobile Number:",
                                  style: TextStyle(color: Colors.white),
                                ),
                                subtitle: Text(number,
                                    style: TextStyle(color: Colors.white70)),
                                leading: Icon(
                                  Icons.phone_android,
                                  color: Colors.white70,
                                ),
                                trailing: IconButton(
                                  icon: CircleAvatar(
                                    child: Icon(
                                      Icons.edit,
                                    ),
                                    backgroundColor: Color(0xFF0D47A1),
                                  ),
                                  onPressed: () {
                                    var lable = "Mobile Number";
                                    var type = "contact";
                                    var current = number;

                                    updateMenu(lable, type, current);
                                  },
                                ),
                              ),
                              decoration: const BoxDecoration(
                                gradient: LinearGradient(
                                  colors: <Color>[
                                    Color(0xFF0D47A1),
                                    Color(0xFF1976D2),
                                    Color(0xFF42A5F5),
                                  ],
                                ),
                                border: Border(
                                  right: BorderSide(
                                      color: Color(0xFF0D47A1), width: 5),
                                ),
                              ),
                            ),
                            clipper: ShapeBorderClipper(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(3))),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        child: Card(
                          elevation: 2,
                          child: ClipPath(
                            child: Container(
                              height: 100,
                              width: screenWeight,
                              child: ListTile(
                                title: Text("E-mail:",
                                    style: TextStyle(color: Colors.white)),
                                subtitle: Text(mail,
                                    style: TextStyle(color: Colors.white70)),
                                leading: Icon(
                                  Icons.mail_outline,
                                  color: Colors.white70,
                                ),
                                trailing: IconButton(
                                  icon: CircleAvatar(
                                    child: Icon(Icons.edit),
                                    backgroundColor: Color(0xFF0D47A1),
                                  ),
                                  onPressed: () {
                                    var lable = "E-mail";
                                    var type = "eMail";
                                    var current = mail;

                                    updateMenu(lable, type, current);
                                  },
                                ),
                              ),
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: <Color>[
                                      Color(0xFF0D47A1),
                                      Color(0xFF1976D2),
                                      Color(0xFF42A5F5),
                                    ],
                                  ),
                                  border: Border(
                                      right: BorderSide(
                                          color: Color(0xFF0D47A1), width: 5))),
                            ),
                            clipper: ShapeBorderClipper(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(3))),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return Text("loading ...");
            }
          },
        ));
  }
}
