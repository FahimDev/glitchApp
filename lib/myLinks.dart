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

  confirmDelete(int id, String buttNane) {
    showDialog(
      builder: (context) => new AlertDialog(
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
      context: context,
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
    } else if (changeInfo.body == "405") {
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
    } else if (changeInfo.body == "304") {
      (context as Element).reassemble();
      showDialog(
        builder: (context) => new AlertDialog(
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
        context: context,
      );
    } else if (changeInfo.body == "200") {
      (context as Element).reassemble();
      showDialog(
        builder: (context) => new AlertDialog(
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
        context: context,
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
    } else if (changeInfo.body == "405") {
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
    } else if (changeInfo.body == "304") {
      (context as Element).reassemble();
      showDialog(
        builder: (context) => new AlertDialog(
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
        context: context,
      );
    } else if (changeInfo.body == "200") {
      (context as Element).reassemble();
      showDialog(
        builder: (context) => new AlertDialog(
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
        context: context,
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
    } else if (changeInfo.body == "405") {
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
    } else if (changeInfo.body == "304") {
      (context as Element).reassemble();
      showDialog(
        builder: (context) => new AlertDialog(
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
        context: context,
      );
    } else if (changeInfo.body == "200") {
      (context as Element).reassemble();
      showDialog(
        builder: (context) => new AlertDialog(
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
                            /*
                            updateButt(
                              myElement[index]["id"],
                              myElement[index]["buttonTitle"],
                              myElement[index]["url"],
                              type,
                            );
                            */

                            showDialog(
                                context: context,
                                builder: (_) {
                                  return MyDialog(
                                    id: myElement[index]["id"],
                                    name: myElement[index]["buttonTitle"],
                                    url: myElement[index]["url"],
                                    type: type,
                                  );
                                });
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
          int id = 0;
          String name = "glitch";
          String url = "www.glitch-innovation.com";
          String type = "add";
          //updateButt(id, name, url, type);
          showDialog(
              context: context,
              builder: (_) {
                return MyDialog(
                  id: id,
                  name: name,
                  url: url,
                  type: type,
                );
              });
        },
        child: FaIcon(FontAwesomeIcons.anchor),
        backgroundColor: Color(0xFF1976D2),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
    );
  }
}

class MyDialog extends StatefulWidget {
  int id;
  String name;
  String url;
  String type;

  MyDialog(
      {Key key,
      @required this.id,
      @required this.name,
      @required this.url,
      @required this.type})
      : super(key: key);

  @override
  _MyDialogState createState() => new _MyDialogState(id, name, url, type);
}

class _MyDialogState extends State<MyDialog> {
  bool next = false;
  int id;
  String name;
  String url;
  String type;

  TextEditingController titleData = new TextEditingController();
  TextEditingController urlData = new TextEditingController();

  _MyDialogState(this.id, this.name, this.url, this.type);

  var userName = LoginPage.user;
  var token = LoginPage.token;
  var passwd = LoginPage.passwd;
  var baseURL = LoginPage.baseURL;

  Map<String, String> get headers => {
        "Access-Token": token,
        "User-Name": userName,
        "Password": passwd,
      };

  //#################---->>ADD NEW<<----###############
  Future<String> postLinkButt(String title, String urlData) async {
    var changeInfo = await http.post(
        "" + baseURL + "/update-links?title=" + title + "&url=" + urlData + "",
        headers: headers);

    //Navigator.of(context, rootNavigator: true).pop('dialog');
    (context as Element).reassemble();
    print("THIS-->" + title + urlData);
    print("THE RESPONSE ---->" + changeInfo.body);

    if (changeInfo.body == "401") {
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
        ),
        context: context,
      );
    } else if (changeInfo.body == "405") {
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
    } else if (changeInfo.body == "304") {
      (context as Element).reassemble();
      showDialog(
        builder: (context) => new AlertDialog(
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
        context: context,
      );
    } else if (changeInfo.body == "200") {
      //(context as Element).reassemble();
      showDialog(
        builder: (context) => new AlertDialog(
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
        context: context,
      );
    }
    print("THE RESPONSE ---->" + changeInfo.body);
  }

  //#################---->>UPDATE<<----###############
  Future<String> putLinkButt(
      int currID, String buttTitle, String newTitle, String buttURL) async {
    print(buttTitle + "This is NEW--------------->" + newTitle);
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
    //(context as Element).reassemble();

    print("THIS IS RESPONSE -->" +
        changeInfo.body +
        currID.toString() +
        buttTitle);

    if (changeInfo.body == "401") {
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
        ),
        context: context,
      );
    } else if (changeInfo.body == "405") {
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
    } else if (changeInfo.body == "304") {
      (context as Element).reassemble();
      showDialog(
        builder: (context) => new AlertDialog(
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
        context: context,
      );
    } else if (changeInfo.body == "200") {
      (context as Element).reassemble();
      showDialog(
        builder: (context) => new AlertDialog(
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
        context: context,
      );
    }
    print(changeInfo.body);
  }

  @override
  Widget build(BuildContext context) {
    var newTitle;
    if (type == "edit" && next == false) {
      titleData.text = name;
      urlData.text = url;
    }

    return AlertDialog(
      title: Text(next == false
          ? "Button Title"
          : next == true
              ? "Anchor URL"
              : "Action"),
      content: new Stack(
        children: <Widget>[
          Container(
            child: TextField(
              keyboardType: TextInputType.multiline,
              minLines: 1,
              maxLines: 5,
              controller: next == false ? titleData : urlData,
              decoration: InputDecoration(
                  hintText:
                      next == false ? "Button Title" : "Paste Related URL",
                  counterText: next == false
                      ? "Current Title :" + name
                      : "Current URL :" + url),
            ),
          ),
        ],
      ),
      actions: <Widget>[
        RaisedButton(
          onPressed: () {
            next == false ? titleData.text = "" : urlData.text = "";
          },
          child: next == false
              ? Text("Clear Text")
              : next == true
                  ? Text("Clear URL")
                  : Text("Clear"),
          color: Colors.yellowAccent,
        ),
        RaisedButton(
          onPressed: () => setState(
            () {
              if (next == false) {
                if (titleData.text.length <= 0) {
                  showDialog(
                    builder: (context) => new AlertDialog(
                      title: new Text("Emplty Flex"),
                      content: new Stack(
                        children: <Widget>[
                          Container(
                            child: Text("Button title can not be empty!"),
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
                  newTitle = titleData.text;
                  print(newTitle);
                  titleData.text = newTitle;
                  next = true;
                }
              } else {
                if (urlData.text.length <= 0) {
                  showDialog(
                    builder: (context) => new AlertDialog(
                      title: new Text("Emplty Flex"),
                      content: new Stack(
                        children: <Widget>[
                          Container(
                            child: Text("Button URL can not be empty!"),
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
                  print(titleData.text + urlData.text);
                  type == "edit"
                      ? putLinkButt(id, name, titleData.text, urlData.text)
                      : postLinkButt(titleData.text, urlData.text);
                  Navigator.of(context, rootNavigator: true).pop('dialog');
                }
              }
            },
          ),
          child: next == false
              ? Text("Next")
              : type == "edit" && next == true
                  ? Text("Update")
                  : type == "add" && next == true
                      ? Text("Add")
                      : Text("Action"),
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
    );
  }
}
/* 
 updateButt(int id, String name, String url, String type) {
    var currentInfo = name;
    if (type == "edit") {
      titleData.text = currentInfo;
      urlData.text = url;
    } else {
      titleData.text = "";
      urlData.text = "";
    }
    bool next = false;
    showDialog(
      context: context,
      child: new AlertDialog(
        title: Text("ok"),
        content: new Stack(
          children: <Widget>[
            Container(
              child: TextField(
                keyboardType: TextInputType.multiline,
                minLines: 1,
                maxLines: 5,
                controller: next == false ? titleData : urlData,
                decoration: InputDecoration(
                    hintText:
                        next == false ? "Button Title" : "Paste Related URL",
                    counterText: next == false
                        ? "Current Title :" + currentInfo
                        : "Current URL :" + url),
              ),
            ),
          ],
        ),
        actions: <Widget>[
          RaisedButton(
            onPressed: () {
              urlData.text = "";
            },
            child: Text("Clear Text"),
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
*/
