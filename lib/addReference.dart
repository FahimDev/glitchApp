import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:glitchApp/main.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class AddRefe extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: AddRef());
  }
}

class AddRef extends StatefulWidget {
  var userName;
  var token;

  AddRef({this.token, this.userName});

  @override
  _AddRefState createState() => _AddRefState();
}

class _AddRefState extends State<AddRef> {
  var userName = LoginPage.user;
  var token = LoginPage.token;
  var passwd = LoginPage.passwd;
  var baseURL = LoginPage.baseURL;

  TextEditingController title = new TextEditingController();
  TextEditingController name = new TextEditingController();
  TextEditingController position = new TextEditingController();
  TextEditingController contact = new TextEditingController();
  TextEditingController eMail = new TextEditingController();
  TextEditingController url = new TextEditingController();

  var keyColor0 = Colors.black54;
  var keyColor1 = Colors.black54;

  Map<String, String> get headers => {
        "Access-Token": token,
        "User-Name": userName,
        "Password": passwd,
      };

  Future<String> addRef() async {
    var responser = await http.post(
        "" +
            baseURL +
            "update-reference?title=" +
            title.text +
            "&name=" +
            name.text +
            "&position=" +
            position.text +
            "&contact=" +
            contact.text +
            "&eMail=" +
            eMail.text +
            "&url=" +
            url.text +
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
    } else if (responser.body == "success") {
      showDialog(
        builder: (context) => new AlertDialog(
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
        context: context,
      );
    } else {
      showDialog(
        builder: (context) => new AlertDialog(
          title: new Text("Unknown Error!"),
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
          "Add New Reference",
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
                  FontAwesomeIcons.userTie,
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
                        FontAwesomeIcons.userTag,
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
                child: TextField(
                  controller: name,
                  decoration: InputDecoration(
                    prefixIcon: CircleAvatar(
                      child: FaIcon(
                        FontAwesomeIcons.signature,
                        color: Colors.black54,
                        size: 30,
                      ),
                      backgroundColor: Colors.transparent,
                    ),
                    labelText: "Name",
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
                  controller: contact,
                  decoration: InputDecoration(
                    prefixIcon: CircleAvatar(
                      child: FaIcon(
                        FontAwesomeIcons.mobileAlt,
                        color: Colors.black54,
                        size: 30,
                      ),
                      backgroundColor: Colors.transparent,
                    ),
                    labelText: "Contact [Optional]",
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
                  controller: eMail,
                  decoration: InputDecoration(
                    prefixIcon: CircleAvatar(
                      child: FaIcon(
                        FontAwesomeIcons.envelope,
                        color: Colors.black54,
                        size: 30,
                      ),
                      backgroundColor: Colors.transparent,
                    ),
                    labelText: "e-mail",
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
                  controller: url,
                  decoration: InputDecoration(
                    prefixIcon: CircleAvatar(
                      child: FaIcon(
                        FontAwesomeIcons.link,
                        color: Colors.black54,
                        size: 30,
                      ),
                      backgroundColor: Colors.transparent,
                    ),
                    labelText: "URL [Optional]",
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
                    this.addRef();
                  },
                  icon: FaIcon(
                    FontAwesomeIcons.plusCircle,
                    //color: Colors.white70,
                    size: 20,
                  ),
                  label: Text(
                    "Add Reference",
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
