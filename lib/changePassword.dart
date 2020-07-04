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
  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWeight = MediaQuery.of(context).size.width;
    //var token = LoginPage.token;
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Center(
        child: Container(
          child: IconButton(
            icon: FaIcon(FontAwesomeIcons.key, color: Colors.white70),
            iconSize: 250,
            onPressed: () {},
          ),
        ),
      ),
    );
  }
}
