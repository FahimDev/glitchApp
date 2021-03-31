import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:glitchApp/addReference.dart';
import 'package:glitchApp/editEdu.dart';
import 'package:glitchApp/main.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

class ViewEdu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: ViewEduPage());
  }
}

class ViewEduPage extends StatefulWidget {
  var type = "phd";

  ViewEduPage({Key key, @required this.type}) : super(key: key);

  @override
  _ViewEduPageState createState() => _ViewEduPageState(type);
}

class _ViewEduPageState extends State<ViewEduPage> {
  List myElement;
  var data;

  var formLoaderType = "phd";

  List myBackup = [
    {
      "id": 0,
      "school": "No Data Given",
      "sBatch": "No Data Given",
      "college": "No Data Given",
      "cBatch": "No Data Given",
      "diploma": "No Data Given",
      "dSub": "No Data Given",
      "dBatch": "No Data Given",
      "bachelor": "No Data Given",
      "baSub": "No Data Given",
      "baBatch": "No Data Given",
      "masters": "No Data Given",
      "maSub": "No Data Given",
      "msBatch": "No Data Given",
      "phd": "No Data Given",
      "phdSub": "No Data Given",
      "passYear": "No Data Given"
    }
  ];

  _ViewEduPageState(this.formLoaderType);

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
    var responser = await http
        .get("" + baseURL + "member-app-edu/$formLoaderType/" + userName + "");
    myElement = json.decode(responser.body.toString());
    data = myElement[0];
    if (data.length < 1) {
      myElement[0] = [
        {
          "id": 0,
          "school": "No Data Given",
          "sBatch": "No Data Given",
          "college": "No Data Given",
          "cBatch": "No Data Given",
          "diploma": "No Data Given",
          "dSub": "No Data Given",
          "dBatch": "No Data Given",
          "bachelor": "No Data Given",
          "baSub": "No Data Given",
          "baBatch": "No Data Given",
          "masters": "No Data Given",
          "maSub": "No Data Given",
          "msBatch": "No Data Given",
          "phd": "No Data Given",
          "phdSub": "No Data Given",
          "passYear": "No Data Given"
        }
      ];

      data = myElement[0];
    }
    print("-------------->" + data.length.toString());
    print(data);

    return "Success";
  }

  Future<String> deleteEdu(int id, var title) async {
    var changeInfo = await http.delete(
        "" + baseURL + "update-profile-edu?id=" + id.toString(),
        headers: headers);
    Navigator.of(context, rootNavigator: true).pop('dialog');
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
                child: Text("$title has been removed."),
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

  confirmDelete(int id, var title) {
    showDialog(
      builder: (context) => new AlertDialog(
        title: new Text("Delete"),
        content: new Stack(
          children: <Widget>[
            Container(
              child: Text(
                  "Are you sure you want to remove $title from your Education list."),
            ),
          ],
        ),
        actions: <Widget>[
          RaisedButton(
            onPressed: () {
              this.deleteEdu(id, title);
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

  @override
  Widget build(BuildContext context) {
    var screenWeight = MediaQuery.of(context).size.width;
    //var token = LoginPage.token;
    return Scaffold(
      backgroundColor: Colors.lightBlueAccent,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Color(0xFF0D47A1),
        title: Text(
          "Education",
          style: TextStyle(fontFamily: 'Raleway', color: Colors.white),
        ),
      ),
      body: FutureBuilder<String>(
        future: getProfile(),
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return new ListView.builder(
              padding: EdgeInsets.only(top: 50),
              itemCount: myElement.length == null ? 0 : myElement.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  child: Card(
                    elevation: 2,
                    child: ClipPath(
                      child: Container(
                        height: 100,
                        width: screenWeight,
                        child: ListTile(
                          title: Text(
                            formLoaderType == "scl"
                                ? "Institute:" + myElement[index]["school"]
                                : formLoaderType == "clg"
                                    ? "Institute:" + myElement[index]["college"]
                                    : formLoaderType == "dip"
                                        ? "Institute:" +
                                            myElement[index]["diploma"]
                                        : formLoaderType == "bs"
                                            ? "Institute:" +
                                                myElement[index]["bachelor"]
                                            : formLoaderType == "ms"
                                                ? "Institute:" +
                                                    myElement[index]["masters"]
                                                : "Institute:" +
                                                    myElement[index]["phd"],
                          ),
                          subtitle: Text(
                            formLoaderType == "scl"
                                ? " [" + myElement[index]["sBatch"] + "] "
                                : formLoaderType == "clg"
                                    ? " [" + myElement[index]["cBatch"] + "] "
                                    : formLoaderType == "dip"
                                        ? myElement[index]["dSub"] +
                                            " [" +
                                            myElement[index]["dBatch"] +
                                            "] "
                                        : formLoaderType == "bs"
                                            ? myElement[index]["baSub"] +
                                                " [" +
                                                myElement[index]["baBatch"] +
                                                "] "
                                            : formLoaderType == "ms"
                                                ? myElement[index]["maSub"] +
                                                    " [" +
                                                    myElement[index]
                                                        ["msBatch"] +
                                                    "] "
                                                : myElement[index]["phdSub"] +
                                                    " [" +
                                                    myElement[index]
                                                        ["passYear"] +
                                                    "] ",
                          ),
                          leading: IconButton(
                            icon: CircleAvatar(
                              backgroundColor: Colors.red,
                              child: FaIcon(FontAwesomeIcons.minusCircle,
                                  color: Colors.white70),
                            ),
                            onPressed: () {
                              int id = myElement[index]["id"];
                              var inst = formLoaderType == "scl"
                                  ? myElement[index]["school"]
                                  : formLoaderType == "clg"
                                      ? myElement[index]["college"]
                                      : formLoaderType == "dip"
                                          ? myElement[index]["diploma"]
                                          : formLoaderType == "bs"
                                              ? myElement[index]["bachelor"]
                                              : formLoaderType == "ms"
                                                  ? myElement[index]["masters"]
                                                  : myElement[index]["phd"];
                              confirmDelete(id, inst);
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
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => EditEdu(
                                    id: myElement[index]["id"],
                                    type: formLoaderType,
                                    auth: formLoaderType == "scl"
                                        ? myElement[index]["school"]
                                        : formLoaderType == "clg"
                                            ? myElement[index]["college"]
                                            : formLoaderType == "dip"
                                                ? myElement[index]["diploma"]
                                                : formLoaderType == "bs"
                                                    ? myElement[index]
                                                        ["bachelor"]
                                                    : formLoaderType == "ms"
                                                        ? myElement[index]
                                                            ["masters"]
                                                        : myElement[index]
                                                            ["phd"],
                                    program: formLoaderType == "scl"
                                        ? "school"
                                        : formLoaderType == "clg"
                                            ? "college"
                                            : formLoaderType == "dip"
                                                ? myElement[index]["dSub"]
                                                : formLoaderType == "bs"
                                                    ? myElement[index]["baSub"]
                                                    : formLoaderType == "ms"
                                                        ? myElement[index]
                                                            ["maSub"]
                                                        : myElement[index]
                                                            ["phdSub"],
                                    batch: formLoaderType == "scl"
                                        ? myElement[index]["sBatch"]
                                        : formLoaderType == "clg"
                                            ? myElement[index]["cBatch"]
                                            : formLoaderType == "dip"
                                                ? myElement[index]["dBatch"]
                                                : formLoaderType == "bs"
                                                    ? myElement[index]
                                                        ["baBatch"]
                                                    : formLoaderType == "ms"
                                                        ? myElement[index]
                                                            ["msBatch"]
                                                        : myElement[index]
                                                            ["passYear"],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        decoration: const BoxDecoration(
                          color: Colors.white54,
                        ),
                      ),
                      clipper: ShapeBorderClipper(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(3))),
                    ),
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
    );
  }
}
