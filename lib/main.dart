import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/services.dart'; //For preventing Rotation
import 'package:glitchApp/menu.dart';
import 'package:http/http.dart' as http;
import 'package:connectivity/connectivity.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: LoginPage());
  }
}

class LoginPage extends StatefulWidget {
  static String user = _LoginPageState.user;
  static String token = _LoginPageState.token;
  static String passwd = _LoginPageState.passwd;
  static String baseURL = "http://www.office-rest.api.glitch-innovations.com/";
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var data;
  var response;
  static var token;
  static var user;
  static var passwd;
  TextEditingController userName = new TextEditingController();
  TextEditingController password = new TextEditingController();

  var buttonColor = Color(0xFF61A4F1);
  var buttonColor1 = Color(0xFF478DE0);

  bool _passVisibility = true;

  Map<String, String> get headers => {
        "User-Name": userName.text,
        "Password": password.text,
      };

  void login() async {
    var status = "error";
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      status = "mobile";
    } else if (connectivityResult == ConnectivityResult.wifi) {
      status = "wifi";
    } else {
      status = "error";
    }

    if (status == "error") {
      showDialog(
        builder: (context) => new AlertDialog(
          title: new Text("ERROR!"),
          content: new Stack(
            children: <Widget>[
              Container(
                child: Text('No internet connection. Please, get connected.'),
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
    } else {
      print(status);
      this.getData();
    }
  }

  Future getData() async {
    var responser = await http.post(
        "http://www.office-rest.api.glitch-innovations.com/authority?userName=" +
            userName.text +
            "&password=" +
            password.text +
            "",
        headers: headers);
    setState(() {
      buttonColor = Colors.green;
      buttonColor1 = Colors.lightGreenAccent;
      if (responser.body == 'Shoitan!' || responser.body == "Unauthorized.") {
        print('Sorry! Wrong User-name or Password');

        showDialog(
          builder: (context) => new AlertDialog(
            title: new Text("ERROR!"),
            content: new Stack(
              children: <Widget>[
                Container(
                  child: Text('Sorry! Wrong User-name or Password'),
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
      } else if (responser.body == 'wrongUser') {
        showDialog(
          builder: (context) => new AlertDialog(
            title: new Text("ERROR!"),
            content: new Stack(
              children: <Widget>[
                Container(
                  child: Text('Sorry! Wrong User-name. Please, try again.'),
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
      } else {
        var decode = json.decode(responser.body);
        data = decode;
        response = data['response'];
        token = data['Token'];

        if (response == 'As-Salamu Alaykum') {
          user = userName.text;
          passwd = password.text;
          token = data['Token'];
          print('Login Success!');

          //user = userName.text;
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => MyMenu(
                        accessToken: token,
                        userName: userName.text,
                      )));
        } else {
          print('Something went wrong!');
          showDialog(
            builder: (context) => new AlertDialog(
              title: new Text("ERROR!"),
              content: new Stack(
                children: <Widget>[
                  Container(
                    child: Text("Something went wrong!"),
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
        }
      }
    });
  }

  @override
  void initState() {
    super.initState();

    //this.getData();
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return Scaffold(
      backgroundColor: Colors.transparent,
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFF73AEF5),
                Color(0xFF61A4F1),
                Color(0xFF478DE0),
                Color(0xFF398AE5),
              ]),
        ),
        child: Column(
          children: <Widget>[
            Container(
              height: screenHeight / 9,
            ),
            Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Container(
                  child: CircleAvatar(
                    radius: 50,
                  ),
                ),
                Positioned(
                  child: Container(
                    child: IconButton(
                      icon: FaIcon(
                        password.text.length == 0
                            ? FontAwesomeIcons.userAstronaut
                            : password.text.length != 0 &&
                                    _passVisibility == true
                                ? FontAwesomeIcons.eye
                                : password.text.length != 0 &&
                                        _passVisibility == false
                                    ? FontAwesomeIcons.eyeSlash
                                    : FontAwesomeIcons.userAstronaut,
                        color: Colors.white70,
                      ),
                      iconSize: 70,
                      onPressed: () {
                        if (password.text.length != 0 &&
                            _passVisibility == true) {
                          _passVisibility = false;
                          (context as Element).reassemble();
                          print(_passVisibility);
                        } else if (password.text.length != 0 &&
                            _passVisibility == false) {
                          _passVisibility = true;
                          (context as Element).reassemble();
                        }
                      },
                    ),
                  ),
                )
              ],
            ),
            Container(
              child: Text(
                "Login",
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Raleway',
                  fontSize: 30.0,
                  //fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white10,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white24,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 20,
                              offset: Offset(0, 10),
                            ),
                          ],
                        ),
                        child: Column(
                          children: <Widget>[
                            TextField(
                              controller: userName,
                              decoration:
                                  InputDecoration(hintText: "User Name"),
                            )
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white24,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(20),
                            bottomRight: Radius.circular(10),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 20,
                              offset: Offset(0, 10),
                            ),
                          ],
                        ),
                        child: Column(
                          children: <Widget>[
                            TextField(
                              controller: password,
                              decoration: InputDecoration(
                                hintText: "Password",
                              ),
                              enableSuggestions: false,
                              autocorrect: false,
                              obscureText: _passVisibility,
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        child: GestureDetector(
                          onTap: () {
                            this.login();
                          },
                          child: Container(
                            height: 50,
                            margin: EdgeInsets.symmetric(horizontal: 30),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Color(0xFF73AEF5),
                                    buttonColor,
                                    buttonColor,
                                    Color(0xFF398AE5),
                                  ]),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black38,
                                  blurRadius: 20,
                                  offset: Offset(0, 10),
                                ),
                              ],
                            ),
                            child: Center(
                              child: Text(
                                "Login",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
