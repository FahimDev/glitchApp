import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
//import 'package:email_validator/email_validator.dart';
import 'package:glitchApp/main.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'dart:core';

class Social extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: SocialPage());
  }
}

class SocialPage extends StatefulWidget {
  @override
  _SocialPageState createState() => _SocialPageState();
}

class _SocialPageState extends State<SocialPage> {
  List myElement;
  var data;
  var fb;
  var twit;
  var git;
  var cv;
  Future<String> getProfile() async {
    var responser =
        await http.get("" + baseURL + "member-profile/" + userName + "");
    myElement = json.decode(responser.body.toString());
    data = myElement[0];
    fb = data["socialFB"];
    twit = data["socialTwit"];
    git = data["gitHub"];
    cv = data["linkedIN"];

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
        title: new Text("Change '" + lable + "' URL ?"),
        content: new Stack(
          children: <Widget>[
            Container(
              child: TextField(
                keyboardType: TextInputType.multiline,
                minLines: 1,
                maxLines: 5,
                controller: newData,
                decoration: InputDecoration(
                    hintText: lable,
                    counterText: "Current URL :" + currentInfo),
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
    } else {
      (context as Element).reassemble();
      showDialog(
        context: context,
        child: new AlertDialog(
          title: new Text("Done!"),
          content: new Stack(
            children: <Widget>[
              Container(
                child: Text("Your URL has been updated."),
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
            "Related URL",
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
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black54.withOpacity(0.5),
                              blurRadius: 50.00,
                              spreadRadius: 0.5,
                            ),
                          ],
                        ),
                        child: Card(
                          elevation: 2,
                          child: ClipPath(
                            child: Container(
                              height: 70,
                              width: screenWeight,
                              child: ListTile(
                                title: Text("Facebook:"),
                                subtitle: Text("Your Profile URL"),
                                leading: CircleAvatar(
                                  child: FaIcon(FontAwesomeIcons.facebook,
                                      color: Colors.white70),
                                ),
                                trailing: IconButton(
                                  icon: CircleAvatar(
                                    child: Icon(
                                      Icons.edit,
                                    ),
                                    backgroundColor: Color(0xFF0D47A1),
                                  ),
                                  onPressed: () {
                                    var lable = "Facebook";
                                    var type = "socialFB";
                                    var current = fb;

                                    updateMenu(lable, type, current);
                                  },
                                ),
                              ),
                              decoration: const BoxDecoration(
                                color: Colors.white54,
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
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black54.withOpacity(0.5),
                              blurRadius: 50.00,
                              spreadRadius: 0.5,
                            ),
                          ],
                        ),
                        child: Card(
                          elevation: 2,
                          child: ClipPath(
                            child: Container(
                              height: 70,
                              width: screenWeight,
                              child: ListTile(
                                title: Text("Twitter:"),
                                subtitle: Text("Your Profile URL"),
                                leading: CircleAvatar(
                                  child: FaIcon(FontAwesomeIcons.twitter,
                                      color: Colors.white70),
                                ),
                                trailing: IconButton(
                                  icon: CircleAvatar(
                                    child: Icon(
                                      Icons.edit,
                                    ),
                                    backgroundColor: Color(0xFF0D47A1),
                                  ),
                                  onPressed: () {
                                    var lable = "Twitter";
                                    var type = "socialTwit";
                                    var current = twit;

                                    updateMenu(lable, type, current);
                                  },
                                ),
                              ),
                              decoration: const BoxDecoration(
                                color: Colors.white54,
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
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black54.withOpacity(0.5),
                              blurRadius: 50.00,
                              spreadRadius: 0.5,
                            ),
                          ],
                        ),
                        child: Card(
                          elevation: 2,
                          child: ClipPath(
                            child: Container(
                              height: 70,
                              width: screenWeight,
                              child: ListTile(
                                title: Text("GitHub:"),
                                subtitle: Text("Your Profile URL"),
                                leading: CircleAvatar(
                                  child: FaIcon(FontAwesomeIcons.github,
                                      color: Colors.white70),
                                  backgroundColor: Colors.black87,
                                ),
                                trailing: IconButton(
                                  icon: CircleAvatar(
                                    child: Icon(
                                      Icons.edit,
                                    ),
                                    backgroundColor: Color(0xFF0D47A1),
                                  ),
                                  onPressed: () {
                                    var lable = "GitHub";
                                    var type = "gitHub";
                                    var current = git;

                                    updateMenu(lable, type, current);
                                  },
                                ),
                              ),
                              decoration: const BoxDecoration(
                                color: Colors.white54,
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
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black54.withOpacity(0.5),
                              blurRadius: 50.00,
                              spreadRadius: 0.5,
                            ),
                          ],
                        ),
                        child: Card(
                          elevation: 2,
                          child: ClipPath(
                            child: Container(
                              height: 70,
                              width: screenWeight,
                              child: ListTile(
                                title: Text("Linkedin:"),
                                subtitle: Text("Your Profile URL"),
                                leading: CircleAvatar(
                                  child: FaIcon(FontAwesomeIcons.linkedinIn,
                                      color: Colors.white70),
                                ),
                                trailing: IconButton(
                                  icon: CircleAvatar(
                                    child: Icon(
                                      Icons.edit,
                                    ),
                                    backgroundColor: Color(0xFF0D47A1),
                                  ),
                                  onPressed: () {
                                    var lable = "Linkedin";
                                    var type = "linkedIN";
                                    var current = cv;

                                    updateMenu(lable, type, current);
                                  },
                                ),
                              ),
                              decoration: const BoxDecoration(
                                color: Colors.white54,
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
