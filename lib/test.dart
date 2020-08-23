import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:glitchApp/profile.dart';
import 'package:http/http.dart' as http;
import 'main.dart';

//void main() => runApp(TestME());

/// This Widget is the main application widget.
class TestME extends StatelessWidget {
  String returnPage = "Null";
  bool showDial = false;

  TextEditingController newAbout = new TextEditingController();
  static String newData = "Null";

  var type = "Null";
  var currVal = "Null";

  TestME({this.type, this.currVal});

  var userName = LoginPage.user;
  var token = LoginPage.token;
  var passwd = LoginPage.passwd;
  var baseURL = LoginPage.baseURL;

  Map<String, String> get headers => {
        "Access-Token": token,
        "User-Name": userName,
        "Password": passwd,
      };

  Future<String> makeChange(String type, String newVal) async {
    var changeInfo = await http.put(
        "" +
            baseURL +
            "update-profile?userName=" +
            userName +
            "&type=" +
            type +
            "&data=" +
            newVal +
            "",
        headers: headers);

    print(changeInfo.body);
    if (changeInfo.body == "Invalid Token !") {
      returnPage = "Your session is over.Please,login again.";
      showDial == true;
    } else if (changeInfo.body == "Update fail") {
      returnPage = "An error occurred.Please,try again.";
      showDial == true;
    } else {
      returnPage = "success";
      showDial == false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF0D47A1),
          title: Text(
            "Edit Form",
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
          child: Column(
            children: <Widget>[
              showDial != true
                  ? SizedBox(
                      height: 20,
                      child: Container(
                        color: Colors.white70,
                      ),
                    )
                  : Text("Something went Wrong"),
              Container(
                child: Card(
                  elevation: 2,
                  child: ClipPath(
                    child: Container(
                      height: type == "About" ? 200 : 100,
                      //width: screenWeight,
                      child: ListTile(
                        title: Text("Correcr your '" + type + "' information:"),
                        subtitle: type == "Gender"
                            ? MyStatefulWidget()
                            : type == "About"
                                ? Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 16, horizontal: 16),
                                    child: TextField(
                                      onChanged: (value) {
                                        newData = newAbout.text;
                                      },
                                      keyboardType: TextInputType.multiline,
                                      minLines: 1,
                                      maxLines: 5,
                                      controller: newAbout,
                                      decoration: InputDecoration(
                                        labelText: "About",
                                        enabledBorder: OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.black38),
                                        ),
                                        border: OutlineInputBorder(),
                                      ),
                                    ),
                                  )
                                : MyBloodWidget(),
                        leading: CircleAvatar(child: Icon(Icons.edit)),
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white70,
                        border: Border(
                          right: BorderSide(color: Color(0xFF0D47A1), width: 5),
                        ),
                      ),
                    ),
                    clipper: ShapeBorderClipper(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(3),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                color: Colors.white54,
                child: Row(
                  children: <Widget>[
                    type != "About"
                        ? SizedBox(
                            width: 100,
                          )
                        : RaisedButton(
                            onPressed: () {
                              //newAbout.text = "";
                              newAbout.text = currVal;
                            },
                            child: Text("Current Data"),
                            color: Colors.yellow,
                          ),
                    SizedBox(
                      width: 20,
                    ),
                    RaisedButton(
                      onPressed: () {
                        var newValue;
                        var changeType;

                        if (type == "About") {
                          newValue = newData;
                          changeType = "about";
                        } else if (type == "Gender") {
                          newValue = _MyStatefulWidgetState.newData;
                          changeType = "gender";
                        } else {
                          newValue = _MyBloodWidgetState.newData;
                          changeType = "blood";
                        }

                        makeChange(changeType, newValue);
                        process() {
                          returnPage == "success"
                              ? Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ProfilePage()),
                                )
                              : (context as Element).reassemble();
                        }

                        print(newValue);
                      },
                      child: Text("Update"),
                      color: Colors.green,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    RaisedButton(
                      onPressed: () {
                        Navigator.of(context, rootNavigator: true)
                            .pop('dialog');
                      },
                      child: Text("No"),
                      color: Colors.red,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//##########################GENDER#####################
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
      items: <String>['None', 'Male', 'Female', 'Transgender']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}

//################BLOOD#####################
class MyBloodWidget extends StatefulWidget {
  MyBloodWidget({Key key}) : super(key: key);

  @override
  _MyBloodWidgetState createState() => _MyBloodWidgetState();
}

class _MyBloodWidgetState extends State<MyBloodWidget> {
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
        'A Positive',
        'B Positive',
        'AB Positive',
        'O Positive ',
        'A negative ',
        'B negative ',
        'AB negative ',
        'O negative '
      ].map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
