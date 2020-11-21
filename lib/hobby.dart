import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:glitchApp/main.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

class Hobby extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: HobbyPage());
  }
}

class HobbyPage extends StatefulWidget {
  var userName;
  var token;

  HobbyPage({this.token, this.userName});

  @override
  _HobbyPageState createState() => _HobbyPageState();
}

class _HobbyPageState extends State<HobbyPage> {
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

  Future<String> getProfile() async {
    var responser =
        await http.get("" + baseURL + "member-hobby/" + userName + "");
    myElement = json.decode(responser.body.toString());
    data = myElement[0];
    print(data["hobby"]);

    return "Success";
  }

  TextEditingController newData = new TextEditingController();
  addHobbyWindow() {
    showDialog(
      context: context,
      child: new AlertDialog(
        title: new Text("Do you want to add new Hobby ?"),
        content: new Stack(
          children: <Widget>[
            Container(
              child: TextField(
                keyboardType: TextInputType.multiline,
                minLines: 1,
                maxLines: 5,
                controller: newData,
                decoration: InputDecoration(
                  hintText: "Add new hobby",
                ),
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
              this.postHobby(newData.text);
            },
            child: Text("Add"),
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

  editHobbyWindow(int id, var currentInfo) {
    newData.text = currentInfo;
    showDialog(
      context: context,
      child: new AlertDialog(
        title: new Text("Change your Hobby-List ?"),
        content: new Stack(
          children: <Widget>[
            Container(
              child: TextField(
                keyboardType: TextInputType.multiline,
                minLines: 1,
                maxLines: 5,
                controller: newData,
                decoration: InputDecoration(
                    hintText: "Change hobby",
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
              this.putHobby(id, currentInfo, newData.text);
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

  confirmDelete(int id, String hobbyName) {
    showDialog(
      context: context,
      child: new AlertDialog(
        title: new Text("Delete"),
        content: new Stack(
          children: <Widget>[
            Container(
              child: Text("Are you sure you want to remove '" +
                  hobbyName +
                  "' from your Hobby-List."),
            ),
          ],
        ),
        actions: <Widget>[
          RaisedButton(
            onPressed: () {
              this.deleteHobby(id, hobbyName);
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

  //#################---->>ADD<<----###############
  Future<String> postHobby(String moveHobby) async {
    var changeInfo = await http.post(
        "" + baseURL + "update-hob?hobby=" + moveHobby + "",
        headers: headers);
    Navigator.of(context, rootNavigator: true).pop('dialog');
    (context as Element).reassemble();
    if (changeInfo.body == "Invalid Token !") {
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
    } else if (changeInfo.body == "success") {
      (context as Element).reassemble();
      showDialog(
        context: context,
        child: new AlertDialog(
          title: new Text("Done!"),
          content: new Stack(
            children: <Widget>[
              Container(
                child: Text("Point has been added."),
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
          title: new Text("Something went Wrong"),
          content: new Stack(
            children: <Widget>[
              Container(
                child: Text("An error occurred.Please,try again."),
              )
            ],
          ),
        ),
      );
    }
    print(changeInfo.body);
  }

  //#################---->>UPDATE<<----###############
  Future<String> putHobby(int id, String currHobby, String puteHobby) async {
    var changeInfo = await http.put(
        "" +
            baseURL +
            "update-hob?id=" +
            id.toString() +
            "&hobby=" +
            currHobby +
            "&changeVal=" +
            puteHobby +
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
                child: Text("Hobby has been updated."),
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
                child: Text("Cause unknown.Please,try again." +
                    changeInfo.body.toString()),
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
  Future<String> deleteHobby(int id, String moveHobby) async {
    var changeInfo = await http.delete(
        "" +
            baseURL +
            "update-hob?id=" +
            id.toString() +
            "&hobby=" +
            moveHobby +
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
                child: Text("Hobby has been removed."),
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
                child: Text("Cause unknown.Please,try again." +
                    changeInfo.body.toString()),
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
          "Hobbies",
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
                      height: 50,
                      width: screenWeight,
                      child: ListTile(
                        title: Text(
                          myElement[index]["hobby"],
                          style: TextStyle(color: Colors.white),
                        ),
                        leading: IconButton(
                          icon: CircleAvatar(
                            child: FaIcon(FontAwesomeIcons.minusCircle,
                                color: Colors.white),
                            backgroundColor: Colors.red,
                          ),
                          onPressed: () {
                            var hobbyName = myElement[index]["hobby"];
                            int id = myElement[index]["id"];
                            confirmDelete(id, hobbyName);
                          },
                        ), //FaIcon(FontAwesomeIcons.solidHandPointRight,
                        //color: Colors.white70),
                        trailing: IconButton(
                          icon: CircleAvatar(
                            child: Icon(
                              Icons.edit,
                            ),
                            backgroundColor: Color(0xFF0D47A1),
                          ),
                          onPressed: () {
                            var currentInfo = myElement[index]["hobby"];
                            int id = myElement[index]["id"];
                            editHobbyWindow(id, currentInfo);
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
          addHobbyWindow();
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
