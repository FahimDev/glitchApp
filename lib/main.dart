import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/services.dart'; //For preventing Rotation
import 'package:glitchApp/menu.dart';
import 'package:http/http.dart' as http;

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

  Map<String, String> get headers => {
        "User-Name": userName.text,
        "Password": password.text,
      };

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
        buttonColor = Colors.red;
        buttonColor1 = Colors.redAccent;
      } else {
        buttonColor = Colors.green;
        buttonColor1 = Colors.lightGreenAccent;
        var decode = json.decode(responser.body);
        data = decode;
        response = data['response'];
        token = data['Token'];

        if (response == 'As-Salamu Alaykum') {
          user = userName.text;
          passwd = password.text;
          print('Login Success!');
          //user = userName.text;
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => MyMenu(
                        accessToken: token,
                        userName: userName.text,
                      )));
          buttonColor = Color(0xFF61A4F1);
          buttonColor1 = Color(0xFF478DE0);
        } else {
          print('Something went wrong!');
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
      resizeToAvoidBottomPadding: false,
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
                        FontAwesomeIcons.userAstronaut,
                        color: Colors.white70,
                      ),
                      iconSize: 70,
                      onPressed: null,
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
                              decoration: InputDecoration(hintText: "Password"),
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
                            this.getData();
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
