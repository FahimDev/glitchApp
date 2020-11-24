import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:glitchApp/academic.dart';
import 'package:glitchApp/hashTag.dart';
import 'package:glitchApp/main.dart';
import 'package:glitchApp/profile.dart';
import 'package:glitchApp/reference.dart';
import 'package:glitchApp/social.dart';
import 'package:glitchApp/test.dart';
import 'package:glitchApp/webview.dart';
import 'package:glitchApp/work.dart';

import 'acquisition.dart';
import 'changePassword.dart';
import 'contact.dart';
import 'hobby.dart';
import 'myLinks.dart';

class MyMenu extends StatelessWidget {
  var accessToken;
  var userName;

  MyMenu({this.accessToken, this.userName});

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWeight = MediaQuery.of(context).size.width;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            "Welcome",
            style:
                TextStyle(fontFamily: 'Raleway', color: Colors.lightBlueAccent),
          ),
          centerTitle: true,
          backgroundColor: Color.fromRGBO(25, 54, 78, 42),
          leading: IconButton(
            icon: FaIcon(FontAwesomeIcons.internetExplorer,
                color: Colors.lightBlueAccent),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => UserWebViewExample(),
                ),
              );
            },
          ),
        ),
        backgroundColor: Colors.lightBlue,
        body: Stack(
          children: <Widget>[
            new Container(
              decoration: new BoxDecoration(
                image: new DecorationImage(
                    image: new AssetImage("customAsset/images/background1.jpg"),
                    fit: BoxFit.fill),
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.vertical,

              //padding: const EdgeInsets.only(left: 20.0, right: 20.0),
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Container(
                        //color: Colors.black12,

                        height: screenHeight / 3,
                        width: screenWeight / 2,
                        padding: const EdgeInsets.only(
                            top: 10.0, left: 10.0, right: 10.0),
                        child: Column(
                          children: <Widget>[
                            Card(
                              color: Color(0xFF0D47A1),
                              child: InkWell(
                                splashColor: Colors.green.withAlpha(100),
                                onTap: () {},
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                      decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(80),
                                          topRight: Radius.circular(80),
                                        ),
                                        gradient: LinearGradient(
                                          colors: <Color>[
                                            Color(0xFF0D47A1),
                                            Color(0xFF1976D2),
                                            Color(0xFF42A5F5),
                                          ],
                                        ),
                                      ),
                                      width: screenWeight / 2,
                                      height: screenHeight / 5,
                                      //color: Colors.black12,
                                      child: IconButton(
                                          icon: Icon(
                                            Icons.account_circle,
                                          ),
                                          iconSize: 60,
                                          color: Colors.white70,
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    ProfilePage(
                                                  token: accessToken,
                                                  userName: userName,
                                                ),
                                              ),
                                            );
                                          }),
                                    ),
                                    Container(
                                      child: Text(
                                        "Profile",
                                        style: TextStyle(
                                            fontFamily: 'Aleo',
                                            fontStyle: FontStyle.normal,
                                            //fontWeight: FontWeight.bold,
                                            fontSize: 25.0,
                                            color: Colors.white70),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        //color: Colors.black12,
                        height: screenHeight / 3,
                        width: screenWeight / 2,
                        padding: const EdgeInsets.only(
                            top: 10.0, left: 10.0, right: 10.0),
                        child: Column(
                          children: <Widget>[
                            Card(
                              color: Color(0xFF0D47A1),
                              child: InkWell(
                                splashColor: Colors.green.withAlpha(100),
                                onTap: () {},
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                      decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(80),
                                          topRight: Radius.circular(80),
                                        ),
                                        gradient: LinearGradient(
                                          colors: <Color>[
                                            Color(0xFF42A5F5),
                                            Color(0xFF1976D2),
                                            Color(0xFF0D47A1),
                                          ],
                                        ),
                                      ),
                                      width: screenWeight / 2,
                                      height: screenHeight / 5,
                                      //color: Colors.black12,
                                      child: IconButton(
                                        icon: Icon(
                                          Icons.contact_mail,
                                          color: Colors.white70,
                                        ),
                                        iconSize: 60,
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  ContactsPage(
                                                token: accessToken,
                                                userName: userName,
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                    Container(
                                      child: Text(
                                        "Contacts",
                                        style: TextStyle(
                                            fontFamily: 'Aleo',
                                            fontStyle: FontStyle.normal,
                                            //fontWeight: FontWeight.bold,
                                            fontSize: 25.0,
                                            color: Colors.white70),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                    width: 10,
                  ),
                  Row(
                    children: <Widget>[
                      Container(
                        //color: Colors.black12,

                        height: screenHeight / 3,
                        width: screenWeight / 2,
                        padding: const EdgeInsets.only(
                            top: 10.0, left: 10.0, right: 10.0),
                        child: Column(
                          children: <Widget>[
                            Card(
                              color: Color(0xFF0D47A1),
                              child: InkWell(
                                splashColor: Colors.green.withAlpha(100),
                                onTap: () {},
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                      decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(80),
                                          topRight: Radius.circular(80),
                                        ),
                                        gradient: LinearGradient(
                                          colors: <Color>[
                                            Color(0xFF0D47A1),
                                            Color(0xFF1976D2),
                                            Color(0xFF42A5F5),
                                          ],
                                        ),
                                      ),
                                      width: screenWeight / 2,
                                      height: screenHeight / 5,
                                      //color: Colors.black12,
                                      child: IconButton(
                                        icon: Icon(
                                          Icons.school,
                                          color: Colors.white70,
                                        ),
                                        iconSize: 60,
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  AcademicPage(
                                                token: accessToken,
                                                userName: userName,
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                    Container(
                                      child: Text(
                                        "Academic",
                                        style: TextStyle(
                                            fontFamily: 'Aleo',
                                            fontStyle: FontStyle.normal,
                                            //fontWeight: FontWeight.bold,
                                            fontSize: 25.0,
                                            color: Colors.white70),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        //color: Colors.black12,
                        height: screenHeight / 3,
                        width: screenWeight / 2,
                        padding: const EdgeInsets.only(
                            top: 10.0, left: 10.0, right: 10.0),
                        child: Column(
                          children: <Widget>[
                            Card(
                              color: Color(0xFF0D47A1),
                              child: InkWell(
                                splashColor: Colors.green.withAlpha(100),
                                onTap: () {},
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                      decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(80),
                                          topRight: Radius.circular(80),
                                        ),
                                        gradient: LinearGradient(
                                          colors: <Color>[
                                            Color(0xFF42A5F5),
                                            Color(0xFF1976D2),
                                            Color(0xFF0D47A1),
                                          ],
                                        ),
                                      ),
                                      width: screenWeight / 2,
                                      height: screenHeight / 5,
                                      //color: Colors.black12,
                                      child: IconButton(
                                          icon: Icon(
                                            Icons.work,
                                            color: Colors.white70,
                                          ),
                                          iconSize: 60,
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    WorkStatusPage(),
                                              ),
                                            );
                                          }),
                                    ),
                                    Container(
                                      child: Text(
                                        "Employment",
                                        style: TextStyle(
                                            fontFamily: 'Aleo',
                                            fontStyle: FontStyle.normal,
                                            //fontWeight: FontWeight.bold,
                                            fontSize: 25.0,
                                            color: Colors.white70),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                    width: 10,
                  ),
                  Row(
                    children: <Widget>[
                      Container(
                        //color: Colors.black12,

                        height: screenHeight / 3,
                        width: screenWeight / 2,
                        padding: const EdgeInsets.only(
                            top: 10.0, left: 10.0, right: 10.0),
                        child: Column(
                          children: <Widget>[
                            Card(
                              color: Color(0xFF0D47A1),
                              child: InkWell(
                                splashColor: Colors.green.withAlpha(100),
                                onTap: () {},
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                      decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(80),
                                          topRight: Radius.circular(80),
                                        ),
                                        gradient: LinearGradient(
                                          colors: <Color>[
                                            Color(0xFF0D47A1),
                                            Color(0xFF1976D2),
                                            Color(0xFF42A5F5),
                                          ],
                                        ),
                                      ),
                                      width: screenWeight / 2,
                                      height: screenHeight / 5,
                                      //color: Colors.black12,
                                      child: IconButton(
                                        icon: FaIcon(FontAwesomeIcons.hashtag,
                                            color: Colors.white70),
                                        iconSize: 60,
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  HashTagPage(),
                                            ),
                                          );
                                        },
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
                                            color: Colors.white70),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        //color: Colors.black12,
                        height: screenHeight / 3,
                        width: screenWeight / 2,
                        padding: const EdgeInsets.only(
                            top: 10.0, left: 10.0, right: 10.0),
                        child: Column(
                          children: <Widget>[
                            Card(
                              color: Color(0xFF0D47A1),
                              child: InkWell(
                                splashColor: Colors.green.withAlpha(100),
                                onTap: () {},
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                      decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(80),
                                          topRight: Radius.circular(80),
                                        ),
                                        gradient: LinearGradient(
                                          colors: <Color>[
                                            Color(0xFF42A5F5),
                                            Color(0xFF1976D2),
                                            Color(0xFF0D47A1),
                                          ],
                                        ),
                                      ),
                                      width: screenWeight / 2,
                                      height: screenHeight / 5,
                                      //color: Colors.black12,
                                      child: IconButton(
                                        icon: FaIcon(FontAwesomeIcons.boxOpen,
                                            color: Colors.white70),
                                        iconSize: 60,
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => HobbyPage(
                                                token: accessToken,
                                                userName: userName,
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                    Container(
                                      child: Text(
                                        "Hobbies",
                                        style: TextStyle(
                                            fontFamily: 'Aleo',
                                            fontStyle: FontStyle.normal,
                                            //fontWeight: FontWeight.bold,
                                            fontSize: 25.0,
                                            color: Colors.white70),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                    width: 10,
                  ),
                  Row(
                    children: <Widget>[
                      Container(
                        //color: Colors.black12,

                        height: screenHeight / 3,
                        width: screenWeight / 2,
                        padding: const EdgeInsets.only(
                            top: 10.0, left: 10.0, right: 10.0),
                        child: Column(
                          children: <Widget>[
                            Card(
                              color: Color(0xFF0D47A1),
                              child: InkWell(
                                splashColor: Colors.green.withAlpha(100),
                                onTap: () {},
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                      decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(80),
                                          topRight: Radius.circular(80),
                                        ),
                                        gradient: LinearGradient(
                                          colors: <Color>[
                                            Color(0xFF0D47A1),
                                            Color(0xFF1976D2),
                                            Color(0xFF42A5F5),
                                          ],
                                        ),
                                      ),
                                      width: screenWeight / 2,
                                      height: screenHeight / 5,
                                      //color: Colors.black12,
                                      child: IconButton(
                                        icon: FaIcon(
                                            FontAwesomeIcons.streetView,
                                            color: Colors.white70),
                                        iconSize: 60,
                                        onPressed: null,
                                      ),
                                    ),
                                    Container(
                                      child: Text(
                                        "Attribute",
                                        style: TextStyle(
                                            fontFamily: 'Aleo',
                                            fontStyle: FontStyle.normal,
                                            //fontWeight: FontWeight.bold,
                                            fontSize: 25.0,
                                            color: Colors.white70),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        //color: Colors.black12,
                        height: screenHeight / 3,
                        width: screenWeight / 2,
                        padding: const EdgeInsets.only(
                            top: 10.0, left: 10.0, right: 10.0),
                        child: Column(
                          children: <Widget>[
                            Card(
                              color: Color(0xFF0D47A1),
                              child: InkWell(
                                splashColor: Colors.green.withAlpha(100),
                                onTap: () {},
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                      decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(80),
                                          topRight: Radius.circular(80),
                                        ),
                                        gradient: LinearGradient(
                                          colors: <Color>[
                                            Color(0xFF42A5F5),
                                            Color(0xFF1976D2),
                                            Color(0xFF0D47A1),
                                          ],
                                        ),
                                      ),
                                      width: screenWeight / 2,
                                      height: screenHeight / 5,
                                      //color: Colors.black12,
                                      child: IconButton(
                                        icon: FaIcon(FontAwesomeIcons.award,
                                            color: Colors.white70),
                                        iconSize: 60,
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  WebViewExample(),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                    Container(
                                      child: Text(
                                        "Acquisition",
                                        style: TextStyle(
                                            fontFamily: 'Aleo',
                                            fontStyle: FontStyle.normal,
                                            //fontWeight: FontWeight.bold,
                                            fontSize: 25.0,
                                            color: Colors.white70),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                    width: 10,
                  ),
                  Row(
                    children: <Widget>[
                      Container(
                        //color: Colors.black12,

                        height: screenHeight / 3,
                        width: screenWeight / 2,
                        padding: const EdgeInsets.only(
                            top: 10.0, left: 10.0, right: 10.0),
                        child: Column(
                          children: <Widget>[
                            Card(
                              color: Color(0xFF0D47A1),
                              child: InkWell(
                                splashColor: Colors.green.withAlpha(100),
                                onTap: () {},
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                      decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(80),
                                          topRight: Radius.circular(80),
                                        ),
                                        gradient: LinearGradient(
                                          colors: <Color>[
                                            Color(0xFF0D47A1),
                                            Color(0xFF1976D2),
                                            Color(0xFF42A5F5),
                                          ],
                                        ),
                                      ),
                                      width: screenWeight / 2,
                                      height: screenHeight / 5,
                                      //color: Colors.black12,
                                      child: IconButton(
                                          icon: Icon(
                                            Icons.speaker_group,
                                            color: Colors.white70,
                                          ),
                                          iconSize: 60,
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    SocialPage(),
                                              ),
                                            );
                                          }),
                                    ),
                                    Container(
                                      child: Text(
                                        "Social Link",
                                        style: TextStyle(
                                            fontFamily: 'Aleo',
                                            fontStyle: FontStyle.normal,
                                            //fontWeight: FontWeight.bold,
                                            fontSize: 25.0,
                                            color: Colors.white70),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        //color: Colors.black12,
                        height: screenHeight / 3,
                        width: screenWeight / 2,
                        padding: const EdgeInsets.only(
                            top: 10.0, left: 10.0, right: 10.0),
                        child: Column(
                          children: <Widget>[
                            Card(
                              color: Color(0xFF0D47A1),
                              child: InkWell(
                                splashColor: Colors.green.withAlpha(100),
                                onTap: () {},
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                      decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(80),
                                          topRight: Radius.circular(80),
                                        ),
                                        gradient: LinearGradient(
                                          colors: <Color>[
                                            Color(0xFF42A5F5),
                                            Color(0xFF1976D2),
                                            Color(0xFF0D47A1),
                                          ],
                                        ),
                                      ),
                                      width: screenWeight / 2,
                                      height: screenHeight / 5,
                                      //color: Colors.black12,
                                      child: IconButton(
                                          icon: Icon(
                                            Icons.link,
                                            color: Colors.white70,
                                          ),
                                          iconSize: 60,
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    MyLinkPage(),
                                              ),
                                            );
                                          }),
                                    ),
                                    Container(
                                      child: Text(
                                        "Links",
                                        style: TextStyle(
                                            fontFamily: 'Aleo',
                                            fontStyle: FontStyle.normal,
                                            //fontWeight: FontWeight.bold,
                                            fontSize: 25.0,
                                            color: Colors.white70),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                    width: 10,
                  ),
                  Row(
                    children: <Widget>[
                      Container(
                        //color: Colors.black12,

                        height: screenHeight / 3,
                        width: screenWeight / 2,
                        padding: const EdgeInsets.only(
                            top: 10.0, left: 10.0, right: 10.0),
                        child: Column(
                          children: <Widget>[
                            Card(
                              color: Color(0xFF0D47A1),
                              child: InkWell(
                                splashColor: Colors.green.withAlpha(100),
                                onTap: () {},
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                      decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(80),
                                          topRight: Radius.circular(80),
                                        ),
                                        gradient: LinearGradient(
                                          colors: <Color>[
                                            Color(0xFF0D47A1),
                                            Color(0xFF1976D2),
                                            Color(0xFF42A5F5),
                                          ],
                                        ),
                                      ),
                                      width: screenWeight / 2,
                                      height: screenHeight / 5,
                                      //color: Colors.black12,
                                      child: Hero(
                                        tag: "add",
                                        child: IconButton(
                                          icon: FaIcon(
                                              FontAwesomeIcons.expeditedssl,
                                              color: Colors.white70),
                                          iconSize: 60,
                                          onPressed: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        changePassword(
                                                          token: accessToken,
                                                          userName: userName,
                                                        )));
                                          },
                                        ),
                                      ),
                                    ),
                                    Container(
                                      child: Text(
                                        "Password",
                                        style: TextStyle(
                                            fontFamily: 'Aleo',
                                            fontStyle: FontStyle.normal,
                                            //fontWeight: FontWeight.bold,
                                            fontSize: 25.0,
                                            color: Colors.white70),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        //color: Colors.black12,
                        height: screenHeight / 3,
                        width: screenWeight / 2,
                        padding: const EdgeInsets.only(
                            top: 10.0, left: 10.0, right: 10.0),
                        child: Column(
                          children: <Widget>[
                            Card(
                              color: Color(0xFF0D47A1),
                              child: InkWell(
                                splashColor: Colors.green.withAlpha(100),
                                onTap: () {},
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                      decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(80),
                                          topRight: Radius.circular(80),
                                        ),
                                        gradient: LinearGradient(
                                          colors: <Color>[
                                            Color(0xFF42A5F5),
                                            Color(0xFF1976D2),
                                            Color(0xFF0D47A1),
                                          ],
                                        ),
                                      ),
                                      width: screenWeight / 2,
                                      height: screenHeight / 5,
                                      //color: Colors.black12,
                                      child: IconButton(
                                        icon: FaIcon(FontAwesomeIcons.sitemap,
                                            color: Colors.white70),
                                        iconSize: 60,
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  ReferencePage(),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                    Container(
                                      child: Text(
                                        "Networks",
                                        style: TextStyle(
                                            fontFamily: 'Aleo',
                                            fontStyle: FontStyle.normal,
                                            //fontWeight: FontWeight.bold,
                                            fontSize: 25.0,
                                            color: Colors.white70),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//** */
