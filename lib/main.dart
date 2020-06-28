import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: loginPage());
  }
}

class loginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.blueGrey,
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
        child: GestureDetector(
          child: Hero(
            tag: 'login',
            child: Column(
              children: <Widget>[
                Container(
                  height: screenHeight / 5,
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
                Container(
                  alignment: Alignment.centerLeft,
                  child: TextField(
                    style:
                        TextStyle(color: Colors.white, fontFamily: 'OpenSans'),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.only(top: 14.0),
                      prefixIcon: Icon(
                        Icons.account_circle,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
