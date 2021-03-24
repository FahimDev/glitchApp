import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:glitchApp/profile.dart';
import 'package:http/http.dart' as http;
import 'main.dart';

class AddEduPort extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: AddEdu());
  }
}

class AddEdu extends StatefulWidget {
  var userName;
  var token;

  AddEdu({this.token, this.userName});

  @override
  _AddEduState createState() => _AddEduState();
}

class _AddEduState extends State<AddEdu> {
  var userName = LoginPage.user;
  var token = LoginPage.token;
  var passwd = LoginPage.passwd;
  var baseURL = LoginPage.baseURL;

  var batchDate;

  Map<String, String> get headers => {
        "Access-Token": token,
        "User-Name": userName,
        "Password": passwd,
      };

  TextEditingController institute = new TextEditingController();
  TextEditingController degree = new TextEditingController();
  TextEditingController batch = new TextEditingController();
  DateTime _dateTime;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF0D47A1),
          title: Text(
            "Add new degree",
            style: TextStyle(fontFamily: 'Raleway', color: Colors.white),
          ),
          leading: IconButton(
            icon: Icon(
              Icons.backspace,
              color: Colors.white70,
            ),
            onPressed: () {
              Navigator.of(context, rootNavigator: true).pop('dialog');
            },
          ),
        ),
        backgroundColor: Colors.blue,
        body: SingleChildScrollView(
          child: Center(
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
                    height: 20,
                  ),
                  CircleAvatar(
                    backgroundColor: Color(0xFF398AE5),
                    radius: 50,
                    child: FaIcon(
                      FontAwesomeIcons.graduationCap,
                      color: Colors.white70,
                      size: 60,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                    child: ListTile(
                      title: Text(
                        "Select your education stage.",
                        style: TextStyle(color: Colors.black54),
                      ),
                      subtitle: MyStatefulWidget(),
                      leading: CircleAvatar(child: Icon(Icons.arrow_downward)),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                    child: TextField(
                      controller: institute,
                      decoration: InputDecoration(
                        prefixIcon: CircleAvatar(
                          child: FaIcon(
                            FontAwesomeIcons.building,
                            color: Colors.black54,
                            size: 30,
                          ),
                          backgroundColor: Colors.transparent,
                        ),
                        labelText: "Institute",
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
                      controller: degree,
                      decoration: InputDecoration(
                        prefixIcon: CircleAvatar(
                          child: FaIcon(
                            FontAwesomeIcons.award,
                            color: Colors.black54,
                            size: 30,
                          ),
                          backgroundColor: Colors.transparent,
                        ),
                        labelText: "Group/Degree Program",
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
                      controller: batch,
                      onTap: () {
                        FocusScope.of(context).requestFocus(new FocusNode());
                        showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2060),
                        ).then((date) {
                          setState(() {
                            batchDate =
                                "${date.day}-${date.month}-${date.year}";
                            _dateTime = date;
                          });
                          batch.text = batchDate;
                        });
                      },
                      decoration: InputDecoration(
                        prefixIcon: CircleAvatar(
                          child: FaIcon(
                            FontAwesomeIcons.calendarAlt,
                            color: Colors.black54,
                            size: 30,
                          ),
                          backgroundColor: Colors.transparent,
                        ),
                        labelText: "Batch",
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
                        //this.addRef();
                        var type = _MyStatefulWidgetState.newData;
                        var auth = institute.text;
                        var session = batch.text;
                        var prog = degree.text;

                        print(type + auth + prog + session);
                      },
                      icon: FaIcon(
                        FontAwesomeIcons.plusCircle,
                        //color: Colors.white70,
                        size: 20,
                      ),
                      label: Text(
                        "Add Degree",
                        //style: TextStyle(fontSize: 15),
                      ),
                      color: Colors.green,
                    ),
                  ),
                ],
              ),
            ),
          )),
        ),
      ),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  MyStatefulWidget({Key key}) : super(key: key);

  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  String dropdownValue = 'None';
  static String newData = "Null";
  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: dropdownValue,
      icon: Icon(Icons.arrow_downward),
      iconSize: 24,
      elevation: 16,
      style: TextStyle(color: Colors.deepPurple),
      underline: Container(
        height: 2,
        color: Colors.deepPurpleAccent,
      ),
      onChanged: (String newValue) {
        setState(() {
          dropdownValue = newValue;
          newData = newValue;
          print(newValue + "  1");
          print(dropdownValue);
          print(newValue + "  2");
        });
      },
      items: <String>[
        'None',
        'School',
        'College',
        'Bachelor Degree',
        'Master Degree',
        'Doctorate Degree'
      ].map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
