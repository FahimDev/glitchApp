import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:glitchApp/addEdu.dart';
import 'package:glitchApp/main.dart';
import 'package:glitchApp/viewEdu.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

class Academic extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: AcademicPage());
  }
}

class AcademicPage extends StatefulWidget {
  var userName;
  var token;

  AcademicPage({this.token, this.userName});

  @override
  _AcademicPageState createState() => _AcademicPageState();
}

class _AcademicPageState extends State<AcademicPage> {
  List myElement;
  var data;
  Future<String> getProfile() async {
    var responser = await http.get(
        "http://www.office-rest.api.glitch-innovations.com/member-hobby/fahim0373");
    myElement = json.decode(responser.body.toString());
    data = myElement[0];
    print(data["hobby"]);

    return "Success";
    //_listView();
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWeight = MediaQuery.of(context).size.width;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Color(0xFF1976D2),
        title: Text(
          "Education",
          style: TextStyle(fontFamily: 'Raleway', color: Colors.white),
        ),
      ),
      backgroundColor: Colors.lightBlueAccent,
      body: Column(
        children: [
          SizedBox(
            height: 50,
          ),
          Container(
            child: Card(
              elevation: 2,
              child: ClipPath(
                child: Container(
                  height: 50,
                  width: screenWeight,
                  child: ListTile(
                    title: Text(
                      "School",
                      style: TextStyle(color: Colors.white),
                    ),
                    leading: FaIcon(FontAwesomeIcons.bookReader,
                        color: Colors.white70),
                    trailing: IconButton(
                      icon: CircleAvatar(
                        child: Icon(
                          Icons.open_in_full,
                        ),
                        backgroundColor: Color(0xFF0D47A1),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ViewEduPage(
                              type: "scl",
                            ),
                          ),
                        );
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
                      right: BorderSide(color: Color(0xFF0D47A1), width: 5),
                    ),
                  ),
                ),
                clipper: ShapeBorderClipper(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(3))),
              ),
            ),
          ),
          Container(
            child: Card(
              elevation: 2,
              child: ClipPath(
                child: Container(
                  height: 50,
                  width: screenWeight,
                  child: ListTile(
                    title: Text(
                      "College",
                      style: TextStyle(color: Colors.white),
                    ),
                    leading: FaIcon(FontAwesomeIcons.userGraduate,
                        color: Colors.white70),
                    trailing: IconButton(
                      icon: CircleAvatar(
                        child: Icon(
                          Icons.open_in_full,
                        ),
                        backgroundColor: Color(0xFF0D47A1),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ViewEduPage(
                              type: "clg",
                            ),
                          ),
                        );
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
                      right: BorderSide(color: Color(0xFF0D47A1), width: 5),
                    ),
                  ),
                ),
                clipper: ShapeBorderClipper(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(3))),
              ),
            ),
          ),
          Container(
            child: Card(
              elevation: 2,
              child: ClipPath(
                child: Container(
                  height: 50,
                  width: screenWeight,
                  child: ListTile(
                    title: Text(
                      "Diploma",
                      style: TextStyle(color: Colors.white),
                    ),
                    leading: FaIcon(FontAwesomeIcons.userGraduate,
                        color: Colors.white70),
                    trailing: IconButton(
                      icon: CircleAvatar(
                        child: Icon(
                          Icons.open_in_full,
                        ),
                        backgroundColor: Color(0xFF0D47A1),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ViewEduPage(
                              type: "dip",
                            ),
                          ),
                        );
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
                      right: BorderSide(color: Color(0xFF0D47A1), width: 5),
                    ),
                  ),
                ),
                clipper: ShapeBorderClipper(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(3))),
              ),
            ),
          ),
          Container(
            child: Card(
              elevation: 2,
              child: ClipPath(
                child: Container(
                  height: 50,
                  width: screenWeight,
                  child: ListTile(
                    title: Text(
                      "Bachelor's Degree",
                      style: TextStyle(color: Colors.white),
                    ),
                    leading: FaIcon(FontAwesomeIcons.graduationCap,
                        color: Colors.white70),
                    trailing: IconButton(
                      icon: CircleAvatar(
                        child: Icon(
                          Icons.open_in_full,
                        ),
                        backgroundColor: Color(0xFF0D47A1),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ViewEduPage(
                              type: "bs",
                            ),
                          ),
                        );
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
                      right: BorderSide(color: Color(0xFF0D47A1), width: 5),
                    ),
                  ),
                ),
                clipper: ShapeBorderClipper(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(3))),
              ),
            ),
          ),
          Container(
            child: Card(
              elevation: 2,
              child: ClipPath(
                child: Container(
                  height: 50,
                  width: screenWeight,
                  child: ListTile(
                    title: Text(
                      "Master's Degree",
                      style: TextStyle(color: Colors.white),
                    ),
                    leading: FaIcon(FontAwesomeIcons.university,
                        color: Colors.white70),
                    trailing: IconButton(
                      icon: CircleAvatar(
                        child: Icon(
                          Icons.open_in_full,
                        ),
                        backgroundColor: Color(0xFF0D47A1),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ViewEduPage(
                              type: "ms",
                            ),
                          ),
                        );
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
                      right: BorderSide(color: Color(0xFF0D47A1), width: 5),
                    ),
                  ),
                ),
                clipper: ShapeBorderClipper(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(3))),
              ),
            ),
          ),
          Container(
            child: Card(
              elevation: 2,
              child: ClipPath(
                child: Container(
                  height: 50,
                  width: screenWeight,
                  child: ListTile(
                    title: Text(
                      "Doctorate Degree",
                      style: TextStyle(color: Colors.white),
                    ),
                    leading:
                        FaIcon(FontAwesomeIcons.award, color: Colors.white70),
                    trailing: IconButton(
                      icon: CircleAvatar(
                        child: Icon(
                          Icons.open_in_full,
                        ),
                        backgroundColor: Color(0xFF0D47A1),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ViewEduPage(
                              type: "phd",
                            ),
                          ),
                        );
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
                      right: BorderSide(color: Color(0xFF0D47A1), width: 5),
                    ),
                  ),
                ),
                clipper: ShapeBorderClipper(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(3))),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddEdu()));
        },
        child: FaIcon(FontAwesomeIcons.plusCircle),
        backgroundColor: Color(0xFF1976D2),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
    );
  }
}
