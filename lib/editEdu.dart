import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:glitchApp/profile.dart';
import 'package:glitchApp/viewEdu.dart';
import 'package:http/http.dart' as http;
import 'main.dart';

class EditEdu extends StatefulWidget {
  int id;
  var type;
  var auth;
  var program;
  var batch;

  EditEdu({Key key, this.id, this.type, this.auth, this.program, this.batch})
      : super(key: key);

  @override
  _EditEduState createState() => _EditEduState(id, type, auth, program, batch);
}

class _EditEduState extends State<EditEdu> {
  var userName = LoginPage.user;
  var token = LoginPage.token;
  var passwd = LoginPage.passwd;
  var baseURL = LoginPage.baseURL;

  var batchDate;

  int id;
  var stage;
  var inst;
  var pdegProgram;
  var batchYear;
  _EditEduState(
      this.id, this.stage, this.inst, this.pdegProgram, this.batchYear);

  Map<String, String> get headers => {
        "Access-Token": token,
        "User-Name": userName,
        "Password": passwd,
      };

  TextEditingController institute = new TextEditingController();
  TextEditingController degree = new TextEditingController();
  TextEditingController batch = new TextEditingController();
  DateTime _dateTime;

  Future<String> updateEdu(
      int id, var type, var institute, var degree, var batch) async {
    var responser = await http.put(
        "" +
            baseURL +
            "update-profile-edu?id=" +
            id.toString() +
            "&type=" +
            type +
            "&institute=" +
            institute +
            "&degree=" +
            degree +
            "&batch=" +
            batch +
            "",
        headers: headers);

    print(responser.body);

    if (responser.body == "401") {
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
          actions: <Widget>[
            RaisedButton(
              onPressed: () {
                Navigator.of(context, rootNavigator: true).pop('dialog');
                (context as Element).reassemble();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MyApp(),
                  ),
                );
              },
              child: Text("ok"),
            ),
          ],
        ),
        context: context,
      );
    } else if (responser.body == "405") {
      (context as Element).reassemble();
      showDialog(
        builder: (context) => new AlertDialog(
          title: new Text("ERROR!"),
          content: new Stack(
            children: <Widget>[
              Container(
                child: Text("Request Method Unknown. [Status Code: 405]"),
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
    } else if (responser.body == "304") {
      (context as Element).reassemble();
      showDialog(
        builder: (context) => new AlertDialog(
          title: new Text("ERROR!"),
          content: new Stack(
            children: <Widget>[
              Container(
                child: Text("Not updated.Please,try again. [Status Code: 305]"),
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
    } else if (responser.body == "200") {
      (context as Element).reassemble();
      showDialog(
        builder: (context) => new AlertDialog(
          title: new Text("Done!"),
          content: new Stack(
            children: <Widget>[
              Container(
                child: Text("Educational information has been updated."),
              )
            ],
          ),
          actions: <Widget>[
            RaisedButton(
              onPressed: () {
                Navigator.of(context, rootNavigator: true).pop('dialog');
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ViewEduPage(
                      type: type,
                    ),
                  ),
                );
              },
              child: Text("ok"),
            ),
          ],
        ),
        context: context,
      );
    } else {
      (context as Element).reassemble();
      showDialog(
        builder: (context) => new AlertDialog(
          title: new Text("Error!"),
          content: new Stack(
            children: <Widget>[
              Container(
                child: Text("Cause unknown.Please,try again. [" +
                    responser.body.toString() +
                    "]"),
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

    return "Success";
  }

  @override
  Widget build(BuildContext context) {
    institute.text = inst;
    degree.text = pdegProgram;
    //batch.text = batchYear;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF0D47A1),
          title: Text(
            "Update degree",
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
                        stage,
                        style: TextStyle(color: Colors.black54),
                      ),
                      subtitle: Text("Educational Stage"),
                      leading: CircleAvatar(
                          child: Icon(Icons.arrow_right_alt_sharp)),
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
                        labelText: "Batch:" + batchYear,
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
                        if (institute.text.length <= 0 ||
                            degree.text.length <= 0 ||
                            batch.text.length <= 0) {
                          showDialog(
                            builder: (context) => new AlertDialog(
                              title: new Text("Reminder!"),
                              content: new Stack(
                                children: <Widget>[
                                  Container(
                                    child: Text(
                                        "Please, fill up all the credentials properly."),
                                  )
                                ],
                              ),
                              actions: <Widget>[
                                RaisedButton(
                                  onPressed: () {
                                    Navigator.of(context, rootNavigator: true)
                                        .pop('dialog');
                                  },
                                  child: Text("ok"),
                                ),
                              ],
                            ),
                            context: context,
                          );
                        } else {
                          var type = stage;
                          var auth = institute.text;
                          var session = batch.text;
                          var prog = degree.text;

                          print(type + auth + prog + session);

                          updateEdu(id, type, auth, prog, session);
                        }
                      },
                      icon: FaIcon(
                        FontAwesomeIcons.edit,
                        //color: Colors.white70,
                        size: 20,
                      ),
                      label: Text(
                        "Update",
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
