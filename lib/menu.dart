import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MyMenu extends StatelessWidget {
  var accessToken;
  var userName;
  MyMenu({this.accessToken, this.userName});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          appBar: AppBar(
            title: Text(
              "Welcome",
              style:
                  TextStyle(fontFamily: 'Raleway', color: Colors.greenAccent),
            ),
            centerTitle: true,
            backgroundColor: Colors.black54,
            leading: IconButton(
              icon: Icon(
                Icons.android,
                color: Colors.green,
              ),
              onPressed: null,
            ),
          ),
          backgroundColor: Colors.blueGrey,
          body: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              //padding: const EdgeInsets.only(left: 20.0, right: 20.0),
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      MyProfileWidget(),
                      MyContactWidget(),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                    width: 10,
                  ),
                  Row(
                    children: <Widget>[
                      MyAcademicWidget(),
                      MyWorkWidget(),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                    width: 10,
                  ),
                  Row(
                    children: <Widget>[
                      MyURLWidget(),
                      MylinksWidget(),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                    width: 10,
                  ),
                  Row(
                    children: <Widget>[
                      MyHashTagWidget(),
                      MySettingsWidget(),
                    ],
                  ),
                ],
              ))),
    );
  }
}

class homePage extends StatelessWidget {
  homePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class MyProfileWidget extends StatelessWidget {
  MyProfileWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWeight = MediaQuery.of(context).size.width;
    return Container(
      color: Colors.black12,
      height: screenHeight / 3,
      width: screenWeight / 2,
      padding: const EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
      child: Column(
        children: <Widget>[
          Card(
            child: InkWell(
              splashColor: Colors.green.withAlpha(100),
              onTap: () {},
              child: Column(
                children: <Widget>[
                  Container(
                      width: screenWeight / 2,
                      height: screenHeight / 5,
                      color: Colors.black12,
                      child: IconButton(
                          icon: Icon(
                            Icons.account_circle,
                          ),
                          iconSize: 60,
                          onPressed: null)),
                  Container(
                    child: Text(
                      "Profile",
                      style: TextStyle(
                          fontFamily: 'Aleo',
                          fontStyle: FontStyle.normal,
                          //fontWeight: FontWeight.bold,
                          fontSize: 25.0,
                          color: Colors.blueGrey),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MyContactWidget extends StatelessWidget {
  MyContactWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWeight = MediaQuery.of(context).size.width;
    return Container(
      color: Colors.black12,
      height: screenHeight / 3,
      width: screenWeight / 2,
      padding: const EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
      child: Column(
        children: <Widget>[
          Card(
            child: InkWell(
              splashColor: Colors.green.withAlpha(100),
              onTap: () {},
              child: Column(
                children: <Widget>[
                  Container(
                      width: screenWeight / 2,
                      height: screenHeight / 5,
                      color: Colors.black12,
                      child: IconButton(
                          icon: Icon(
                            Icons.contact_mail,
                          ),
                          iconSize: 60,
                          onPressed: null)),
                  Container(
                    child: Text(
                      "Contacts",
                      style: TextStyle(
                          fontFamily: 'Aleo',
                          fontStyle: FontStyle.normal,
                          //fontWeight: FontWeight.bold,
                          fontSize: 25.0,
                          color: Colors.blueGrey),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MyAcademicWidget extends StatelessWidget {
  MyAcademicWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWeight = MediaQuery.of(context).size.width;
    return Container(
      color: Colors.black12,
      height: screenHeight / 3,
      width: screenWeight / 2,
      padding: const EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
      child: Column(
        children: <Widget>[
          Card(
            child: InkWell(
              splashColor: Colors.green.withAlpha(100),
              onTap: () {},
              child: Column(
                children: <Widget>[
                  Container(
                      width: screenWeight / 2,
                      height: screenHeight / 5,
                      color: Colors.black12,
                      child: IconButton(
                          icon: Icon(
                            Icons.school,
                          ),
                          iconSize: 60,
                          onPressed: null)),
                  Container(
                    child: Text(
                      "Academic",
                      style: TextStyle(
                          fontFamily: 'Aleo',
                          fontStyle: FontStyle.normal,
                          //fontWeight: FontWeight.bold,
                          fontSize: 25.0,
                          color: Colors.blueGrey),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MyWorkWidget extends StatelessWidget {
  MyWorkWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWeight = MediaQuery.of(context).size.width;
    return Container(
      color: Colors.black12,
      height: screenHeight / 3,
      width: screenWeight / 2,
      padding: const EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
      child: Column(
        children: <Widget>[
          Card(
            child: InkWell(
              splashColor: Colors.green.withAlpha(100),
              onTap: () {},
              child: Column(
                children: <Widget>[
                  Container(
                      width: screenWeight / 2,
                      height: screenHeight / 5,
                      color: Colors.black12,
                      child: IconButton(
                          icon: Icon(
                            Icons.work,
                          ),
                          iconSize: 60,
                          onPressed: null)),
                  Container(
                    child: Text(
                      "Employment",
                      style: TextStyle(
                          fontFamily: 'Aleo',
                          fontStyle: FontStyle.normal,
                          //fontWeight: FontWeight.bold,
                          fontSize: 25.0,
                          color: Colors.blueGrey),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MyURLWidget extends StatelessWidget {
  MyURLWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWeight = MediaQuery.of(context).size.width;
    return Container(
      color: Colors.black12,
      height: screenHeight / 3,
      width: screenWeight / 2,
      padding: const EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
      child: Column(
        children: <Widget>[
          Card(
            child: InkWell(
              splashColor: Colors.green.withAlpha(100),
              onTap: () {},
              child: Column(
                children: <Widget>[
                  Container(
                      width: screenWeight / 2,
                      height: screenHeight / 5,
                      color: Colors.black12,
                      child: IconButton(
                          icon: Icon(
                            Icons.speaker_group,
                          ),
                          iconSize: 60,
                          onPressed: null)),
                  Container(
                    child: Text(
                      "Social Link",
                      style: TextStyle(
                          fontFamily: 'Aleo',
                          fontStyle: FontStyle.normal,
                          //fontWeight: FontWeight.bold,
                          fontSize: 25.0,
                          color: Colors.blueGrey),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MylinksWidget extends StatelessWidget {
  MylinksWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWeight = MediaQuery.of(context).size.width;
    return Container(
      color: Colors.black12,
      height: screenHeight / 3,
      width: screenWeight / 2,
      padding: const EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
      child: Column(
        children: <Widget>[
          Card(
            child: InkWell(
              splashColor: Colors.green.withAlpha(100),
              onTap: () {},
              child: Column(
                children: <Widget>[
                  Container(
                      width: screenWeight / 2,
                      height: screenHeight / 5,
                      color: Colors.black12,
                      child: IconButton(
                          icon: Icon(
                            Icons.link,
                          ),
                          iconSize: 60,
                          onPressed: null)),
                  Container(
                    child: Text(
                      "Links",
                      style: TextStyle(
                          fontFamily: 'Aleo',
                          fontStyle: FontStyle.normal,
                          //fontWeight: FontWeight.bold,
                          fontSize: 25.0,
                          color: Colors.blueGrey),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MyHashTagWidget extends StatelessWidget {
  MyHashTagWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWeight = MediaQuery.of(context).size.width;
    return Container(
      color: Colors.black12,
      height: screenHeight / 3,
      width: screenWeight / 2,
      padding: const EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
      child: Column(
        children: <Widget>[
          Card(
            child: InkWell(
              splashColor: Colors.green.withAlpha(100),
              onTap: () {},
              child: Column(
                children: <Widget>[
                  Container(
                    width: screenWeight / 2,
                    height: screenHeight / 5,
                    color: Colors.black12,
                    child: IconButton(
                      icon: FaIcon(FontAwesomeIcons.hashtag),
                      iconSize: 60,
                      onPressed: null,
                    ),
                  ),
                  Container(
                    child: Text(
                      "#HashTag",
                      style: TextStyle(
                          fontFamily: 'Aleo',
                          fontStyle: FontStyle.normal,
                          //fontWeight: FontWeight.bold,
                          fontSize: 25.0,
                          color: Colors.blueGrey),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MySettingsWidget extends StatelessWidget {
  MySettingsWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWeight = MediaQuery.of(context).size.width;
    return Container(
      color: Colors.black12,
      height: screenHeight / 3,
      width: screenWeight / 2,
      padding: const EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
      child: Column(
        children: <Widget>[
          Card(
            child: InkWell(
              splashColor: Colors.green.withAlpha(100),
              onTap: () {},
              child: Column(
                children: <Widget>[
                  Container(
                      width: screenWeight / 2,
                      height: screenHeight / 5,
                      color: Colors.black12,
                      child: IconButton(
                          icon: Icon(
                            Icons.settings,
                          ),
                          iconSize: 60,
                          onPressed: null)),
                  Container(
                    child: Text(
                      "Settings",
                      style: TextStyle(
                          fontFamily: 'Aleo',
                          fontStyle: FontStyle.normal,
                          //fontWeight: FontWeight.bold,
                          fontSize: 25.0,
                          color: Colors.blueGrey),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
//** */
