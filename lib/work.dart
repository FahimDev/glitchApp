import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:glitchApp/addReference.dart';
import 'package:glitchApp/main.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

import 'addWork.dart';

class WorkStatus extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false, home: WorkStatusPage());
  }
}

class WorkStatusPage extends StatefulWidget {
  var userName;
  var token;

  WorkStatusPage({this.token, this.userName});

  @override
  _WorkStatusPageState createState() => _WorkStatusPageState();
}

class _WorkStatusPageState extends State<WorkStatusPage> {
  List myElement;
  var data;

  var userName = LoginPage.user;
  var token = LoginPage.token;
  var passwd = LoginPage.passwd;
  var baseURL = LoginPage.baseURL;

  Map<String, String> get headers => {
        "Access-Token": token,
        "User-Name": userName,
        "Password": passwd,
      };

  //##############GET INFO####################

  Future<String> getProfile() async {
    var responser = await http.get("" + baseURL + "member-work/" + userName);
    myElement = json.decode(responser.body.toString());
    data = myElement[0];
    print(data["type"]);

    return "Success";
  }

  TextEditingController newData = new TextEditingController();
  DateTime _dateTime;
  var jobDate;
  editWorkWindow(
      String title, String name, int id, String changeKey, String currentInfo) {
    newData.text = currentInfo;
    showDialog(
      context: context,
      child: new AlertDialog(
        title: new Text("Change reference info ?"),
        content: new Stack(
          children: <Widget>[
            Container(
              child: changeKey == 'end' || changeKey == 'started'
                  ? TextField(
                      keyboardType: TextInputType.multiline,
                      minLines: 1,
                      maxLines: 5,
                      controller: newData,
                      onTap: () {
                        FocusScope.of(context).requestFocus(new FocusNode());
                        showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2060),
                        ).then((date) {
                          setState(() {
                            jobDate = "${date.day}-${date.month}-${date.year}";
                            _dateTime = date;
                          });

                          newData.text = jobDate;
                        });
                      },
                    )
                  : TextField(
                      keyboardType: TextInputType.multiline,
                      minLines: 1,
                      maxLines: 5,
                      controller: newData,
                      decoration: InputDecoration(
                          hintText: "Change info..",
                          counterText: "Current Information:" + currentInfo),
                    ),
            ),
          ],
        ),
        actions: <Widget>[
          RaisedButton(
            onPressed: () {
              newData.text = "";
            },
            child: Text("Clear"),
            color: Colors.yellowAccent,
          ),
          RaisedButton(
            onPressed: () {
              String changeVal;
              changeVal = newData.text;
              this.putWork(title, name, id, changeKey, changeVal);
            },
            child: Text("Update"),
            color: Colors.green,
          ),
          RaisedButton(
            onPressed: () {
              Navigator.of(context, rootNavigator: true).pop('dialog');
              //(context as Element).reassemble();
            },
            child: Text("Back"),
            color: Colors.orange,
          ),
        ],
      ),
    );
  }

  confirmDelete(String title, String name, int id) {
    showDialog(
      context: context,
      child: new AlertDialog(
        title: new Text("Delete"),
        content: new Stack(
          children: <Widget>[
            Container(
              child: Text("Are you sure you want to remove this reference."),
            ),
          ],
        ),
        actions: <Widget>[
          RaisedButton(
            onPressed: () {
              this.deleteHobby(title, name, id);
            },
            child: Text("Delete"),
            color: Colors.red,
          ),
          RaisedButton(
            onPressed: () {
              Navigator.of(context, rootNavigator: true).pop('dialog');
            },
            child: Text("No"),
            color: Colors.green,
          ),
        ],
      ),
    );
  }

  //#################---->>UPDATE<<----###############
  Future<String> putWork(String title, String name, int id, String changeKey,
      String changeVal) async {
    var changeInfo = await http.put(
        "" +
            baseURL +
            "update-employment?type=" +
            title +
            "&orgName=" +
            name +
            "&id=" +
            id.toString() +
            "&changeKey=" +
            changeKey +
            "&changeVal=" +
            changeVal +
            "",
        headers: headers);
    Navigator.of(context, rootNavigator: true).pop('dialog');
    (context as Element).reassemble();
    if (changeInfo.body == "401") {
      (context as Element).reassemble();
      showDialog(
        context: context,
        child: new AlertDialog(
          title: new Text("Something went Wrong"),
          content: new Stack(
            children: <Widget>[
              Container(
                child: Text("Your session is over.Please,login again."),
              )
            ],
          ),
        ),
      );
    } else if (changeInfo.body == "405") {
      (context as Element).reassemble();
      showDialog(
        context: context,
        child: new AlertDialog(
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
      );
    } else if (changeInfo.body == "304") {
      (context as Element).reassemble();
      showDialog(
        context: context,
        child: new AlertDialog(
          title: new Text("ERROR!"),
          content: new Stack(
            children: <Widget>[
              Container(
                child:
                    Text("Not Modified.Please,try again. [Status Code: 305]"),
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
      );
    } else if (changeInfo.body == "200") {
      (context as Element).reassemble();
      showDialog(
        context: context,
        child: new AlertDialog(
          title: new Text("Done!"),
          content: new Stack(
            children: <Widget>[
              Container(
                child: Text("Work information: " +
                    name +
                    " has been updated. [updated: " +
                    changeVal +
                    ".]"),
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
      );
    } else {
      (context as Element).reassemble();
      showDialog(
        context: context,
        child: new AlertDialog(
          title: new Text("Error!"),
          content: new Stack(
            children: <Widget>[
              Container(
                child: Text("Cause unknown.Please,try again. [" +
                    changeInfo.body.toString() +
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
      );
    }
    print(changeInfo.body);
  }

  //#################---->>REMOVE<<----###############
  Future<String> deleteHobby(String title, String name, int id) async {
    var changeInfo = await http.delete(
        "" +
            baseURL +
            "update-employment?id=" +
            id.toString() +
            "&type=" +
            title +
            "&orgName=" +
            name +
            "",
        headers: headers);
    Navigator.of(context, rootNavigator: true).pop('dialog');
    if (changeInfo.body == "401") {
      (context as Element).reassemble();
      showDialog(
        context: context,
        child: new AlertDialog(
          title: new Text("Something went Wrong"),
          content: new Stack(
            children: <Widget>[
              Container(
                child: Text("Your session is over.Please,login again."),
              )
            ],
          ),
        ),
      );
    } else if (changeInfo.body == "405") {
      (context as Element).reassemble();
      showDialog(
        context: context,
        child: new AlertDialog(
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
      );
    } else if (changeInfo.body == "304") {
      (context as Element).reassemble();
      showDialog(
        context: context,
        child: new AlertDialog(
          title: new Text("ERROR!"),
          content: new Stack(
            children: <Widget>[
              Container(
                child:
                    Text("Not Modified.Please,try again. [Status Code: 305]"),
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
      );
    } else if (changeInfo.body == "200") {
      (context as Element).reassemble();
      showDialog(
        context: context,
        child: new AlertDialog(
          title: new Text("Done!"),
          content: new Stack(
            children: <Widget>[
              Container(
                child: Text("Work: " + name + " has been removed."),
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
      );
    } else {
      (context as Element).reassemble();
      showDialog(
        context: context,
        child: new AlertDialog(
          title: new Text("Error!"),
          content: new Stack(
            children: <Widget>[
              Container(
                child: Text("Cause unknown.Please,try again. [" +
                    changeInfo.body.toString() +
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
      );
    }
    print(changeInfo.body);
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWeight = MediaQuery.of(context).size.width;

    //var token = LoginPage.token;
    return Scaffold(
      backgroundColor: Colors.lightBlueAccent,
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        backgroundColor: Color(0xFF0D47A1),
        title: Text(
          "Work",
          style: TextStyle(fontFamily: 'Raleway', color: Colors.white),
        ),
      ),
      body: FutureBuilder<String>(
        future: getProfile(), // if you mean this method well return image url
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return new ListView.builder(
              padding: EdgeInsets.only(top: 50),
              itemCount: myElement.length == null ? 0 : myElement.length,
              itemBuilder: (BuildContext context, int index) {
                //myElement[index]["hobby"]
                return Card(
                  elevation: 2,
                  //margin: const EdgeInsets.only(top: 25.0),
                  child: ClipPath(
                    child: Container(
                      //height: 200,
                      width: screenWeight,
                      child: ListTile(
                        title: Column(
                          children: <Widget>[
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              color: Colors.white70,
                              child: ListTile(
                                title:
                                    Text("Type: " + myElement[index]["type"]),
                                leading: FaIcon(FontAwesomeIcons.briefcase,
                                    color: Colors.blueGrey),
                                trailing: IconButton(
                                  icon: CircleAvatar(
                                    child: Icon(
                                      Icons.edit,
                                    ),
                                    backgroundColor: Color(0xFF0D47A1),
                                  ),
                                  onPressed: () {
                                    int id = myElement[index]["id"];
                                    var type = myElement[index]["type"];
                                    var orgName = myElement[index]["orgName"];
                                    var changeKey = "type";
                                    var current = myElement[index]["type"];
                                    this.editWorkWindow(
                                        type, orgName, id, changeKey, current);
                                  },
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              color: Colors.white70,
                              child: ListTile(
                                title: Text("Institution: " +
                                    myElement[index]["orgName"]),
                                leading: FaIcon(FontAwesomeIcons.building,
                                    color: Colors.blueGrey),
                                trailing: IconButton(
                                  icon: CircleAvatar(
                                    child: Icon(
                                      Icons.edit,
                                    ),
                                    backgroundColor: Color(0xFF0D47A1),
                                  ),
                                  onPressed: () {
                                    int id = myElement[index]["id"];
                                    var type = myElement[index]["type"];
                                    var orgName = myElement[index]["orgName"];
                                    var changeKey = "orgName";
                                    var current = myElement[index]["orgName"];
                                    this.editWorkWindow(
                                        type, orgName, id, changeKey, current);
                                  },
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              color: Colors.white70,
                              child: ListTile(
                                title: Text(
                                    "Position: " + myElement[index]["rank"]),
                                leading: FaIcon(FontAwesomeIcons.chair,
                                    color: Colors.blueGrey),
                                trailing: IconButton(
                                  icon: CircleAvatar(
                                    child: Icon(
                                      Icons.edit,
                                    ),
                                    backgroundColor: Color(0xFF0D47A1),
                                  ),
                                  onPressed: () {
                                    int id = myElement[index]["id"];
                                    var type = myElement[index]["type"];
                                    var orgName = myElement[index]["orgName"];
                                    var changeKey = "rank";
                                    var current = myElement[index]["rank"];
                                    this.editWorkWindow(
                                        type, orgName, id, changeKey, current);
                                  },
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              color: Colors.white70,
                              child: ListTile(
                                title: Text("Start Date: " +
                                    myElement[index]["started"]),
                                leading: FaIcon(FontAwesomeIcons.hourglassStart,
                                    color: Colors.blueGrey),
                                trailing: IconButton(
                                  icon: CircleAvatar(
                                    child: Icon(
                                      Icons.edit,
                                    ),
                                    backgroundColor: Color(0xFF0D47A1),
                                  ),
                                  onPressed: () {
                                    int id = myElement[index]["id"];
                                    var type = myElement[index]["type"];
                                    var orgName = myElement[index]["orgName"];
                                    var changeKey = "started";
                                    var current = myElement[index]["started"];
                                    this.editWorkWindow(
                                        type, orgName, id, changeKey, current);
                                  },
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              color: Colors.white70,
                              child: ListTile(
                                title: Text(
                                    "End Date: " + myElement[index]["end"]),
                                leading: FaIcon(FontAwesomeIcons.hourglassEnd,
                                    color: Colors.blueGrey),
                                trailing: IconButton(
                                  icon: CircleAvatar(
                                    child: Icon(
                                      Icons.edit,
                                    ),
                                    backgroundColor: Color(0xFF0D47A1),
                                  ),
                                  onPressed: () {
                                    int id = myElement[index]["id"];
                                    var type = myElement[index]["type"];
                                    var orgName = myElement[index]["orgName"];
                                    var changeKey = "end";
                                    var current = myElement[index]["end"];
                                    this.editWorkWindow(
                                        type, orgName, id, changeKey, current);
                                  },
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                        leading: IconButton(
                          icon: CircleAvatar(
                            child: FaIcon(FontAwesomeIcons.minusCircle,
                                color: Colors.white),
                            backgroundColor: Colors.red,
                          ),
                          onPressed: () {
                            var workType = myElement[index]["type"];
                            var name = myElement[index]["orgName"];
                            var position = myElement[index]["rank"];
                            int key = myElement[index]["id"];
                            confirmDelete(workType, name, key);
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
                );
              },
            );
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("loading ...");
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddWork(),
            ),
          );
        },
        child: Icon(
          Icons.add_box,
          color: Colors.white,
        ),
        backgroundColor: Color(0xFF1976D2),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
    );
  }
}
