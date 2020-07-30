import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:glitchApp/main.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

class Academic extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: AcademicPage());
  }
}

class AcademicPage extends StatefulWidget {
  var userName;
  var token;

  AcademicPage({this.token, this.userName});

  @override
  _AcademicPageState createState() => _AcademicPageState();
}

class _AcademicPageState extends State<AcademicPage> {
  List myElement;
  var data;
  Future<String> getProfile() async {
    var responser = await http.get(
        "http://www.office-rest.api.glitch-innovations.com/member-profile/fahim0373");
    myElement = json.decode(responser.body.toString());
    data = myElement[0];
    print(data["fullName"]);

    return "Success";
    //_listView();
  }

  /**
   * This is an important note. in here I have tested how to get elements from json array.
   * but now we need to develop the dynamic profile page &
   * than we have to fix this page. because for response delay this page is showing error
   */
/*
  @override
  void initState() {
    this.getProfile();
    super.initState();
  }
*/
  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWeight = MediaQuery.of(context).size.width;
    //var token = LoginPage.token;
    return Scaffold(
        backgroundColor: Colors.lightBlueAccent,
        body: FutureBuilder<String>(
          future: getProfile(), // if you mean this method well return image url
          builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return new ListView.builder(
                  itemCount: myElement.length == null ? 0 : myElement.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      child: Row(
                        children: <Widget>[
                          Text(myElement[index]
                              ["fullName"]) //${myElement[index]["fullName"]}
                        ], //${myElement[index]["userName"]}
                      ),
                    );
                  });
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return Text("loading ...");
            }
          },
        )

        /*new ListView.builder(
          itemCount: myElement.length == null ? 0 : myElement.length,
          itemBuilder: (BuildContext context, int index) {
            return Card(
              child: Row(
                children: <Widget>[
                  Text(myElement[index]
                      ["fullName"]) //${myElement[index]["fullName"]}
                ], //${myElement[index]["userName"]}
              ),
            );
          }),
      */
        /*ListWheelScrollView.useDelegate(
        itemExtent: 200,
        //magnification: 1,
        diameterRatio: .5,
        //useMagnifier: true,
        squeeze: .9,
        renderChildrenOutsideViewport: true,
        clipToSize: false,
        physics: BouncingScrollPhysics(),
        childDelegate: ListWheelChildBuilderDelegate(
          builder: (context, index) => Container(
            color: Colors.blueAccent,
            child: Center(
              child: Text("School$index"),
            ),
          ),
        ),
      ), */
        );
  }
}
