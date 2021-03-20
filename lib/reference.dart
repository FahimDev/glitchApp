import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:glitchApp/addReference.dart';
import 'package:glitchApp/main.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

class Reference extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false, home: ReferencePage());
  }
}

class ReferencePage extends StatefulWidget {
  var userName;
  var token;

  ReferencePage({this.token, this.userName});

  @override
  _ReferencePageState createState() => _ReferencePageState();
}

class _ReferencePageState extends State<ReferencePage> {
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
    var responser =
        await http.get("" + baseURL + "app-member-network/", headers: headers);
    myElement = json.decode(responser.body.toString());
    data = myElement[0];
    print(data["title"]);

    return "Success";
  }

  TextEditingController newData = new TextEditingController();
  showHideWindow(String title, String name, String position, String contact,
      String eMAil, String url, var currState) {
    showDialog(
      builder: (context) => new AlertDialog(
        title: new Text("Show/Hide Reference"),
        content: new Stack(
          children: <Widget>[
            Container(
                child: currState == "1" || currState == "3"
                    ? Text("Are you sure? You want to hide this Reference?")
                    : Text("Are you sure? You want to show this Reference?")),
          ],
        ),
        actions: <Widget>[
          RaisedButton(
            onPressed: () {
              this.visiblityRef(
                  title, name, position, contact, eMAil, url, currState);
            },
            child: currState == "1" || currState == "3"
                ? Text("Hide")
                : Text("Show"),
            color: Colors.green,
          ),
          RaisedButton(
            onPressed: () {
              Navigator.of(context, rootNavigator: true).pop('dialog');
              //(context as Element).reassemble();
            },
            child: Text("No"),
            color: Colors.orange,
          ),
        ],
      ),
      context: context,
    );
  }

  editHobbyWindow(String title, String name, String position, String contact,
      String eMAil, String url, String changeKey, var currentInfo) {
    newData.text = currentInfo;
    showDialog(
      builder: (context) => new AlertDialog(
        title: new Text("Change reference info ?"),
        content: new Stack(
          children: <Widget>[
            Container(
              child: TextField(
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
              this.putHobby(title, name, position, contact, eMAil, url,
                  changeKey, changeVal);
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
      context: context,
    );
  }

  confirmDelete(String title, String name, String position, String contact,
      String eMAil, String url) {
    showDialog(
      builder: (context) => new AlertDialog(
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
              this.deleteHobby(title, name, position, contact, eMAil, url);
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
      context: context,
    );
  }

  //#################---->>SHOW/HIDE HTTP<<----###############
  Future<String> visiblityRef(String title, String name, String position,
      String contact, String eMAil, String url, String visibility) async {
    if (visibility == "0" || visibility == "2") {
      visibility = "1";
    } else if (visibility == "1" || visibility == "3") {
      visibility = "0";
    }
    var changeInfo = await http.put(
        "" +
            baseURL +
            "show-reference? title=" +
            title +
            "&name=" +
            name +
            "&position=" +
            position +
            "&contact=" +
            contact +
            "&eMail=" +
            eMAil +
            "&url=" +
            url +
            "&status=" +
            visibility +
            "",
        headers: headers);
    Navigator.of(context, rootNavigator: true).pop('dialog');
    (context as Element).reassemble();
    if (changeInfo.body == "Invalid Token !") {
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
    } else if (changeInfo.body == "success") {
      (context as Element).reassemble();
      showDialog(
        builder: (context) => new AlertDialog(
          title: new Text("Done!"),
          content: new Stack(
            children: <Widget>[
              Container(
                child: Text("Reference visibility has been added."),
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
      (context as Element).reassemble();
      showDialog(
        builder: (context) => new AlertDialog(
          title: new Text("Something went Wrong"),
          content: new Stack(
            children: <Widget>[
              Container(
                child: Text("An error occurred.Please,try again."),
              )
            ],
          ),
        ),
        context: context,
      );
    }
    print(changeInfo.body);
  }

  //#################---->>UPDATE<<----###############
  Future<String> putHobby(
      String title,
      String name,
      String position,
      String contact,
      String eMAil,
      String url,
      String changeKey,
      String changeVal) async {
    var changeInfo = await http.put(
        "" +
            baseURL +
            "update-reference?title=" +
            title +
            "&name=" +
            name +
            "&position=" +
            position +
            "&contact=" +
            contact +
            "&eMail=" +
            eMAil +
            "&url=" +
            url +
            "&changeKey=" +
            changeKey +
            "&changeVal=" +
            changeVal +
            "",
        headers: headers);
    Navigator.of(context, rootNavigator: true).pop('dialog');
    (context as Element).reassemble();
    if (changeInfo.body == "Invalid Token !") {
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
    } else if (changeInfo.body == "success") {
      (context as Element).reassemble();
      showDialog(
        builder: (context) => new AlertDialog(
          title: new Text("Done!"),
          content: new Stack(
            children: <Widget>[
              Container(
                child: Text("The point has been updated."),
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
      (context as Element).reassemble();
      showDialog(
        builder: (context) => new AlertDialog(
          title: new Text("Something went Wrong"),
          content: new Stack(
            children: <Widget>[
              Container(
                child: Text("An error occurred.Please,try again."),
              )
            ],
          ),
        ),
        context: context,
      );
    }
    print(changeInfo.body);
  }

  //#################---->>REMOVE<<----###############
  Future<String> deleteHobby(String title, String name, String position,
      String contact, String eMAil, String url) async {
    var changeInfo = await http.delete(
        "" +
            baseURL +
            "update-reference?title=" +
            title +
            "&name=" +
            name +
            "&position=" +
            position +
            "&contact=" +
            contact +
            "&eMail=" +
            eMAil +
            "&url=" +
            url +
            "",
        headers: headers);
    Navigator.of(context, rootNavigator: true).pop('dialog');
    (context as Element).reassemble();
    if (changeInfo.body == "Invalid Token !") {
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
    } else {
      (context as Element).reassemble();
      showDialog(
        builder: (context) => new AlertDialog(
          title: new Text("Done!"),
          content: new Stack(
            children: <Widget>[
              Container(
                child: Text("Point has been removed."),
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
    print(changeInfo.body);
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWeight = MediaQuery.of(context).size.width;
    //var token = LoginPage.token;
    return Scaffold(
      backgroundColor: Colors.lightBlueAccent,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Color(0xFF0D47A1),
        title: Text(
          "Reference",
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
                                    Text("Role: " + myElement[index]["title"]),
                                trailing: IconButton(
                                  icon: CircleAvatar(
                                    child: Icon(
                                      Icons.edit,
                                    ),
                                    backgroundColor: Color(0xFF0D47A1),
                                  ),
                                  onPressed: () {
                                    var currentInfo = myElement[index]["title"];
                                    var title = myElement[index]["title"];
                                    var name = myElement[index]["name"];
                                    var position = myElement[index]["position"];
                                    var contact = myElement[index]["contact"];
                                    var eMAil = myElement[index]["eMail"];
                                    var url = myElement[index]["url"];
                                    var changeKey = "title";

                                    this.editHobbyWindow(
                                        title,
                                        name,
                                        position,
                                        contact,
                                        eMAil,
                                        url,
                                        changeKey,
                                        currentInfo);
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
                                title:
                                    Text("Name: " + myElement[index]["name"]),
                                trailing: IconButton(
                                  icon: CircleAvatar(
                                    child: Icon(
                                      Icons.edit,
                                    ),
                                    backgroundColor: Color(0xFF0D47A1),
                                  ),
                                  onPressed: () {
                                    var currentInfo = myElement[index]["name"];
                                    var title = myElement[index]["title"];
                                    var name = myElement[index]["name"];
                                    var position = myElement[index]["position"];
                                    var contact = myElement[index]["contact"];
                                    var eMAil = myElement[index]["eMail"];
                                    var url = myElement[index]["url"];
                                    var changeKey = "name";

                                    this.editHobbyWindow(
                                        title,
                                        name,
                                        position,
                                        contact,
                                        eMAil,
                                        url,
                                        changeKey,
                                        currentInfo);
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
                                title: Text("Position: " +
                                    myElement[index]["position"]),
                                trailing: IconButton(
                                  icon: CircleAvatar(
                                    child: Icon(
                                      Icons.edit,
                                    ),
                                    backgroundColor: Color(0xFF0D47A1),
                                  ),
                                  onPressed: () {
                                    var currentInfo =
                                        myElement[index]["position"];

                                    var title = myElement[index]["title"];
                                    var name = myElement[index]["name"];
                                    var position = myElement[index]["position"];
                                    var contact = myElement[index]["contact"];
                                    var eMAil = myElement[index]["eMail"];
                                    var url = myElement[index]["url"];
                                    var changeKey = "position";

                                    this.editHobbyWindow(
                                        title,
                                        name,
                                        position,
                                        contact,
                                        eMAil,
                                        url,
                                        changeKey,
                                        currentInfo);
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
                                    "Contact: " + myElement[index]["contact"]),
                                trailing: IconButton(
                                  icon: CircleAvatar(
                                    child: Icon(
                                      Icons.edit,
                                    ),
                                    backgroundColor: Color(0xFF0D47A1),
                                  ),
                                  onPressed: () {
                                    var currentInfo =
                                        myElement[index]["contact"];
                                    var title = myElement[index]["title"];
                                    var name = myElement[index]["name"];
                                    var position = myElement[index]["position"];
                                    var contact = myElement[index]["contact"];
                                    var eMAil = myElement[index]["eMail"];
                                    var url = myElement[index]["url"];
                                    var changeKey = "contact";

                                    this.editHobbyWindow(
                                        title,
                                        name,
                                        position,
                                        contact,
                                        eMAil,
                                        url,
                                        changeKey,
                                        currentInfo);
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
                                    "e-mail: " + myElement[index]["eMail"]),
                                trailing: IconButton(
                                  icon: CircleAvatar(
                                    child: Icon(
                                      Icons.edit,
                                    ),
                                    backgroundColor: Color(0xFF0D47A1),
                                  ),
                                  onPressed: () {
                                    var currentInfo = myElement[index]["eMail"];
                                    var title = myElement[index]["title"];
                                    var name = myElement[index]["name"];
                                    var position = myElement[index]["position"];
                                    var contact = myElement[index]["contact"];
                                    var eMAil = myElement[index]["eMail"];
                                    var url = myElement[index]["url"];
                                    var changeKey = "eMail";

                                    this.editHobbyWindow(
                                        title,
                                        name,
                                        position,
                                        contact,
                                        eMAil,
                                        url,
                                        changeKey,
                                        currentInfo);
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
                                title: Text("URL: " + myElement[index]["url"]),
                                trailing: IconButton(
                                  icon: CircleAvatar(
                                    child: Icon(
                                      Icons.edit,
                                    ),
                                    backgroundColor: Color(0xFF0D47A1),
                                  ),
                                  onPressed: () {
                                    var currentInfo = myElement[index]["url"];
                                    var title = myElement[index]["title"];
                                    var name = myElement[index]["name"];
                                    var position = myElement[index]["position"];
                                    var contact = myElement[index]["contact"];
                                    var eMAil = myElement[index]["eMail"];
                                    var url = myElement[index]["url"];
                                    var changeKey = "url";

                                    this.editHobbyWindow(
                                        title,
                                        name,
                                        position,
                                        contact,
                                        eMAil,
                                        url,
                                        changeKey,
                                        currentInfo);
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
                            var title = myElement[index]["title"];
                            var name = myElement[index]["name"];
                            var position = myElement[index]["position"];
                            var contact = myElement[index]["contact"];
                            var eMAil = myElement[index]["eMail"];
                            var url = myElement[index]["url"];
                            confirmDelete(
                                title, name, position, contact, eMAil, url);
                          },
                        ),
                        trailing: IconButton(
                          icon: CircleAvatar(
                            child: FaIcon(
                              myElement[index]["status"] == "0"
                                  ? FontAwesomeIcons.eyeSlash
                                  : myElement[index]["status"] == "2"
                                      ? FontAwesomeIcons.eyeSlash
                                      : myElement[index]["status"] == "1"
                                          ? FontAwesomeIcons.eye
                                          : FontAwesomeIcons.eye,
                            ),
                            backgroundColor: myElement[index]["status"] == "0"
                                ? Colors.orange
                                : myElement[index]["status"] == "2"
                                    ? Colors.orange
                                    : myElement[index]["status"] == "1"
                                        ? Colors.green
                                        : Colors
                                            .green, //Colors.orange, //(0xFF0D47A1)
                          ),
                          onPressed: () {
                            var thisState = myElement[index]["status"];

                            var title = myElement[index]["title"];
                            var name = myElement[index]["name"];
                            var position = myElement[index]["position"];
                            var contact = myElement[index]["contact"];
                            var eMAil = myElement[index]["eMail"];
                            var url = myElement[index]["url"];

                            this.showHideWindow(title, name, position, contact,
                                eMAil, url, thisState);
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
            return Center(
              child: SizedBox(
                height: 50,
                width: 50,
                child: CircularProgressIndicator(
                  valueColor: new AlwaysStoppedAnimation<Color>(
                    Color(0xFF0D47A1),
                  ),
                ),
              ),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddRef(),
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
