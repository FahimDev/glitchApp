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

class MyLinkPage extends StatefulWidget {
  static var hashType = _MyLinkPageState.hashType;
  static var currentInfo = _MyLinkPageState.currentInfo;

  @override
  _MyLinkPageState createState() => _MyLinkPageState();
}

class _MyLinkPageState extends State<MyLinkPage> {
  List myElement;
  var data;
  static var hashType = "type";
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
        await http.get("" + baseURL + "member-url/" + userName + "");
    myElement = json.decode(responser.body.toString());
    data = myElement[0];
    print(data["hashTag"]);

    return "Success";
  }

  TextEditingController titleData = new TextEditingController();
  TextEditingController urlData = new TextEditingController();

  updateButt(int id, String name, String url, String type) {
    var currentInfo = name;
    if (type == "edit") {
      titleData.text = currentInfo;
      urlData.text = url;
    } else {
      titleData.text = "";
      urlData.text = "";
    }

    showDialog(
      context: context,
      child: new AlertDialog(
        title: TextField(
          keyboardType: TextInputType.multiline,
          minLines: 1,
          maxLines: 5,
          controller: titleData,
          decoration: InputDecoration(
              hintText: "Button Title",
              counterText: "Current Title :" + currentInfo),
        ),
        content: new Stack(
          children: <Widget>[
            Container(
              child: TextField(
                keyboardType: TextInputType.multiline,
                minLines: 1,
                maxLines: 5,
                controller: urlData,
                decoration: InputDecoration(
                    hintText: "Paste Related URL",
                    counterText: "Current URL :" + url),
              ),
            )
          ],
        ),
        actions: <Widget>[
          RaisedButton(
            onPressed: () {
              urlData.text = "";
            },
            child: Text("Clear URL"),
            color: Colors.yellowAccent,
          ),
          RaisedButton(
            onPressed: () {
              type == "edit"
                  ? putLinkButt(id, name, titleData.text, urlData.text)
                  : postLinkButt(titleData.text, urlData.text);
              Navigator.of(context, rootNavigator: true).pop('dialog');
            },
            child: type == "edit" ? Text("Update") : Text("Add"),
            color: Colors.green,
          ),
          RaisedButton(
            onPressed: () {
              Navigator.of(context, rootNavigator: true).pop('dialog');
              //(context as Element).reassemble();
            },
            child: Text("No"),
            color: Colors.red,
          ),
        ],
      ),
    );
  }

  confirmDelete(int id, String buttNane) {
    showDialog(
      context: context,
      child: new AlertDialog(
        title: new Text("Delete"),
        content: new Stack(
          children: <Widget>[
            Container(
              child: Text("Are you sure you want to remove '" +
                  buttNane +
                  "' Button from your Profile?"),
            ),
          ],
        ),
        actions: <Widget>[
          RaisedButton(
            onPressed: () {
              this.deleteButt(id, buttNane);
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

  //#################---->>ADD NEW<<----###############
  Future<String> postLinkButt(String title, String urlData) async {
    var changeInfo = await http.post(
        "" + baseURL + "/update-links?title=" + title + "&url=" + urlData + "",
        headers: headers);

    //Navigator.of(context, rootNavigator: true).pop('dialog');
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
                child: Text("Button has been added."),
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

  //#################---->>UPDATE<<----###############
  Future<String> putLinkButt(
      int currID, String buttTitle, String newTitle, String buttURL) async {
    var changeInfo = await http.put(
        "" +
            baseURL +
            "update-links?title=" +
            buttTitle +
            "&id=" +
            currID.toString() +
            "&changeKey=" +
            newTitle +
            "&changeVal=" +
            buttURL +
            "",
        headers: headers);
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
                child: Text("Button has been updated."),
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
  Future<String> deleteButt(int id, String buttName) async {
    var changeInfo = await http.delete(
        "" +
            baseURL +
            "update-links?title=" +
            buttName +
            "&id=" +
            id.toString() +
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
                child: Text("Button has been removed."),
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
          "Anchor Button",
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
                  //margin: const EdgeInsets.only(top: 25.0),myElement[index]["buttonTitle"]
                  child: ClipPath(
                    child: Container(
                      //height: 50,
                      width: screenWeight,
                      child: ListTile(
                        title: Row(
                          children: <Widget>[
                            Container(
                              child: Card(
                                elevation: 2,
                                child: ClipPath(
                                  child: Container(
                                    height: 70,
                                    width: screenWeight / 2.1,
                                    child: ListTile(
                                      title:
                                          Text(myElement[index]["buttonTitle"]),
                                      subtitle: Text(myElement[index]["url"]),
                                    ),
                                  ),
                                ),
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
                            int id = myElement[index]["id"];
                            var name = myElement[index]["buttonTitle"];
                            confirmDelete(id, name);
                          },
                        ),
                        trailing: IconButton(
                          icon: CircleAvatar(
                            child: Icon(
                              Icons.edit,
                            ),
                            backgroundColor: Color(0xFF0D47A1),
                          ),
                          onPressed: () {
                            var type = "edit";
                            updateButt(
                              myElement[index]["id"],
                              myElement[index]["buttonTitle"],
                              myElement[index]["url"],
                              type,
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
            return Text("loading ...");
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          int id = 0;
          String name = "glitch";
          String url = "www.glitch-innovation.com";
          String type = "add";
          updateButt(id, name, url, type);
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
