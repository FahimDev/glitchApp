import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:glitchApp/addHashTag.dart';
import 'package:glitchApp/main.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'dart:core';

class HashTag extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: HashTagPage());
  }
}

class HashTagPage extends StatefulWidget {
  @override
  _HashTagPageState createState() => _HashTagPageState();
}

class _HashTagPageState extends State<HashTagPage> {
  List myElement;
  var data;
  var hashType = "type";
  static var currentInfo = "current";

  var userName = LoginPage.user;
  var token = LoginPage.token;
  var passwd = LoginPage.passwd;
  var baseURL = LoginPage.baseURL;
  /*
  Future<String> valUpdater() async {
    
  }
  */

  Map<String, String> get headers => {
        "Access-Token": token,
        "User-Name": userName,
        "Password": passwd,
      };

  Future<String> getProfile() async {
    var responser =
        await http.get("" + baseURL + "member-hashTag/" + userName + "");
    myElement = json.decode(responser.body.toString());
    data = myElement[0];
    print(data["hashTag"]);

    return "Success";
  }

  TextEditingController newData = new TextEditingController();

  confirmDelete(String moveHashTag, String colHashTag, int idHashTag) {
    showDialog(
      builder: (context) => new AlertDialog(
        title: new Text("Delete"),
        content: new Stack(
          children: <Widget>[
            Container(
              child: Text("Are you sure you want to remove '" +
                  moveHashTag +
                  "' from your #HashTag-List."),
            ),
          ],
        ),
        actions: <Widget>[
          RaisedButton(
            onPressed: () {
              this.deleteHashTag(moveHashTag, colHashTag, idHashTag);
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

  //#################---->>REMOVE<<----###############
  Future<String> deleteHashTag(
      String moveHashTag, String colHashTag, int idHashTag) async {
    var changeInfo = await http.delete(
        "" +
            baseURL +
            "update-hashtag?hashTag=" +
            moveHashTag +
            "&color=" +
            colHashTag +
            "&id=" +
            idHashTag.toString() +
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
          "#HasTag",
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
                        title: Row(
                          children: <Widget>[
                            Container(
                              child: Text(
                                myElement[index]["hashTag"],
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Container(
                              child: CircleAvatar(
                                radius: 10,
                                child: FaIcon(
                                  FontAwesomeIcons.palette,
                                  color: myElement[index]["color"] == "info"
                                      ? Colors.lightBlue
                                      : myElement[index]["color"] == "danger"
                                          ? Colors.red
                                          : myElement[index]["color"] ==
                                                  "success"
                                              ? Colors.green
                                              : myElement[index]["color"] ==
                                                      "warning"
                                                  ? Colors.yellow
                                                  : myElement[index]["color"] ==
                                                          "secondary"
                                                      ? Colors.grey
                                                      : myElement[index]
                                                                  ["color"] ==
                                                              "dark"
                                                          ? Colors.black
                                                          : Colors.blue,
                                  size: 15,
                                ),
                                backgroundColor: Colors.white,
                              ),
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
                            var moveHashTag = myElement[index]["hashTag"];
                            var colHashTag = myElement[index]["color"];
                            int idHashTag = myElement[index]["id"];
                            confirmDelete(moveHashTag, colHashTag, idHashTag);
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
                            currentInfo = myElement[index]["hashTag"];
                            hashType = "edit";
                            var colHashTag =
                                myElement[index]["color"]; //make it static
                            int idHashTag =
                                myElement[index]["id"]; //make it static
                            print("GG:" + hashType + currentInfo);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AddHashTag(
                                  id: idHashTag,
                                  hashTitle: currentInfo,
                                  hashType: hashType,
                                  hashCol: colHashTag,
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
                );
              },
            );
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: SizedBox(
                height: 200,
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
          // valUpdater();

          hashType = "add";
          currentInfo = "Title";
          (context as Element).reassemble();
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddHashTag(
                id: 0,
                hashType: hashType,
                hashTitle: currentInfo,
                hashCol: "Light Blue",
              ),
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
