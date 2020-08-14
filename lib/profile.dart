import 'dart:convert';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:flutter_uploader/flutter_uploader.dart';
import 'package:flutter/widgets.dart';
import 'package:glitchApp/main.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:async/async.dart';

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: ProfilePage());
  }
}

class ProfilePage extends StatefulWidget {
  var userName;
  var token;
  var data;
  var img;
  ProfilePage({this.token, this.userName});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  TextEditingController newData = new TextEditingController();
  var picture;
  File _image;
  final picker = ImagePicker();
  Future cameraImg() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);
    /*
    File imageCropper = await ImageCropper.cropImage(
        sourcePath: pickedFile.path,
        aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
        compressQuality: 100,
        maxWidth: 700,
        maxHeight: 700,
        compressFormat: ImageCompressFormat.jpg,
        androidUiSettings: AndroidUiSettings(
            toolbarColor: Colors.blueAccent,
            toolbarTitle: "Crop & Upload",
            backgroundColor: Colors.lightBlue,
            statusBarColor: Colors.lightBlueAccent));
            */
    setState(() {
      //_image = File(pickedFile.path); //imageCropper;
      picture = pickedFile;
      _crop();
    });
  }

  _crop() async {
    File cropped = await ImageCropper.cropImage(
      sourcePath: picture.path,
      aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
      androidUiSettings: AndroidUiSettings(
        toolbarColor: Colors.blueAccent,
        toolbarTitle: "Scale | Rotate | Crop",
        backgroundColor: Colors.lightBlue,
        statusBarColor: Colors.lightBlueAccent,
      ),
    );
    if (cropped != null) {
      setState(() {
        _image = cropped;
        picture = cropped;
      });
    }
  }

  Future gallaryImg() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      //_image = File(pickedFile.path);
      picture = pickedFile;
      _crop();
    });
  }

  editForm(String type, String current) {
    type;
    var currentInfo = current;
    newData.text = currentInfo;
    var newInfo;
    showDialog(
      context: context,
      child: new AlertDialog(
        title: new Text("Change '" + type + "' section ?"),
        content: new Stack(
          children: <Widget>[
            Expanded(
              child: TextField(
                keyboardType: TextInputType.multiline,
                minLines: 1,
                maxLines: 5,
                controller: newData,
                decoration: InputDecoration(
                    hintText: type,
                    counterText: "Current Information:" + currentInfo),
              ),
            )
          ],
        ),
        actions: <Widget>[
          RaisedButton(
            onPressed: () {
              //newInfo = newData.text;
              newData.text = "";
            },
            child: Text("Make it Null"),
            color: Colors.yellowAccent,
          ),
          RaisedButton(
            onPressed: () {
              //newInfo = newData.text;
              this.makeChange(type);
            },
            child: Text("Update"),
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

  var userName = LoginPage.user;
  var token = LoginPage.token;
  var passwd = LoginPage.passwd;
  var baseURL = LoginPage.baseURL;
  /*File _image;
  Future cameraImg() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      _image = image;
    });
  } */
  List myElement;
  var data;

  var _proImg =
      "https://glitch-innovations.com/static/media/gettingUserImage.12cddfbe.svg";

  var name = "Name";
  var title = "Title";
  var currAdd = "Address";
  var perAdd = "Address";
  var about = "About";
  var father = "Parents";
  var mother = "Parents";
  var relation = "Null";
  var religion = "Null";

  Future<String> getProfile() async {
    var responser = await http.get(
        "http://www.office-rest.api.glitch-innovations.com/member-profile/" +
            userName +
            "");
    myElement = json.decode(responser.body.toString());
    data = myElement[0];

    if (myElement.length == null) {
    } else {
      _proImg = data["imgPath"];

      name = data["fullName"];
      title = data["title"];
      currAdd = data["currentLoc"];
      perAdd = data["parmanentLoc"];
      about = data["about"];
      relation = data["relationship"];
      religion = data["religion"];
      father = data["fatherName"];
      mother = data["motherName"];
      print(data);
      print(data["fullName"]);
    }
  }

  Map<String, String> get headers => {
        "Access-Token": token,
        "User-Name": userName,
        "Password": passwd,
      };

  Future<String> makeChange(String type) async {
    var changeInfo = await http.put(
        "http://www.office-rest.api.glitch-innovations.com/update-profile?userName=" +
            userName +
            "&type=" +
            type +
            "&data=" +
            newData.text +
            "",
        headers: headers);
    Navigator.of(context, rootNavigator: true).pop('dialog');
    (context as Element).reassemble();
    print(changeInfo.body);
  }

  _asyncFileUpload() async {
    //create multipart request for POST or PATCH method
    var request = http.MultipartRequest(
        "POST",
        Uri.parse(
            "http://www.office-rest.api.glitch-innovations.com/update-profile-img"));
    //add text fields
    request.fields["userName"] = userName;
    //create multipart using filepath, string or bytes
    var pic = await http.MultipartFile.fromPath("uploadImg", picture.path);
    //add multipart to request
    request.files.add(pic);
    request.headers.addAll(headers);
    var response = await request.send();

    //Get the response from the server
    var responseData = await response.stream.toBytes();
    var responseString = String.fromCharCodes(responseData);
    Navigator.of(context, rootNavigator: true).pop('dialog');
    if (responseString == "success") {
      _image = null;
      (context as Element).reassemble();
    } else if (responseString == "Image file not found !") {
      _image = null;
      (context as Element).reassemble();
      showDialog(
        context: context,
        child: new AlertDialog(
          title: new Text("Something went Wrong"),
          content: new Stack(
            children: <Widget>[
              Container(
                child: Text(
                    "Please,try with another Image.We recommend lite size images.If you are using Device camera the front camera is a good option."),
              )
            ],
          ),
        ),
      );

      print("Try Another Image");
    } else if (responseString == "Invalid Token !") {
      _image = null;
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
    } else {
      _image = null;
      (context as Element).reassemble();
      showDialog(
        context: context,
        child: new AlertDialog(
          title: new Text("Something went Wrong!"),
          content: new Stack(
            children: <Widget>[
              Container(
                child: Text("Please,try again."),
              )
            ],
          ),
        ),
      );
    }

    print(responseString);
  }

  imageUploadNoti() {
    showDialog(
      context: context,
      child: new AlertDialog(
        title: new Text("Uploading..."),
        content: new Stack(
          children: <Widget>[
            Container(
              child: Text("Please,wait.This will take few seconds."),
            )
          ],
        ),
      ),
    );
  }

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
      backgroundColor: Colors.blue,
      body: FutureBuilder<String>(
        future: getProfile(), // if you mean this method well return image url
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Stack(
              children: <Widget>[
                new Container(),
                SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Center(
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 30,
                          //width: 20,
                        ),
                        Container(
                          child: _image == null
                              ? Icon(
                                  Icons.check_circle,
                                  color: Colors.deepPurple,
                                )
                              : AlertDialog(
                                  title: Text(
                                      "Do you want to update this image as your Profile picture?"),
                                  content: Image.file(
                                    _image,
                                    height: 100,
                                  ),
                                  actions: <Widget>[
                                    RaisedButton(
                                      onPressed: () {
                                        _crop();
                                      },
                                      child: Text("Edit"),
                                      color: Colors.yellow,
                                    ),
                                    RaisedButton(
                                      onPressed: () {
                                        imageUploadNoti();
                                        _asyncFileUpload();
                                      },
                                      child: Text("Update"),
                                      color: Colors.green,
                                    ),
                                    RaisedButton(
                                      onPressed: () {
                                        _image = null;
                                        (context as Element).reassemble();
                                      },
                                      child: Text("No"),
                                      color: Colors.red,
                                    ),
                                  ],
                                ),
                        ),
                        Container(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(80),
                            child: Image.network(
                              _proImg,
                              height: screenHeight / 4,
                              width: screenWeight / 2,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                          //width: 20,
                        ),
                        Container(
                          padding: const EdgeInsets.only(left: 50, right: 50.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment
                                .center, //Center Row contents horizontally,
                            crossAxisAlignment: CrossAxisAlignment
                                .center, //Center Row contents vertically,
                            children: <Widget>[
                              Column(
                                children: <Widget>[
                                  Container(
                                    child: Center(
                                      child: Ink(
                                        decoration: ShapeDecoration(
                                            shape: CircleBorder(),
                                            color: Colors.blueGrey),
                                        child: IconButton(
                                          icon: Icon(Icons.image),
                                          color: Colors.white,
                                          onPressed: () {
                                            gallaryImg();
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                //height: 10,
                                width: 20,
                              ),
                              Column(
                                children: <Widget>[
                                  Container(
                                    child: Center(
                                      child: Ink(
                                        decoration: ShapeDecoration(
                                            shape: CircleBorder(),
                                            color: Colors.blueGrey),
                                        child: IconButton(
                                          icon: Icon(Icons.camera),
                                          color: Colors.white,
                                          onPressed: () {
                                            cameraImg();
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 15,
                          //width: 20,
                        ),
                        Stack(
                          children: <Widget>[
                            Container(
                              decoration: BoxDecoration(
                                /*image: DecorationImage(
                              image:
                                  AssetImage("customAsset/images/background.png"),
                              fit: BoxFit.cover,
                            ),*/
                                color: Colors.white38,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(30),
                                  topRight: Radius.circular(30),
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 20,
                                    offset: Offset(0, 10),
                                  ),
                                ],
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(20),
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                      child: ListTile(
                                        title: Text("Full Name:"),
                                        subtitle: Text(name),
                                        leading: Icon(Icons.arrow_right),
                                        trailing: CircleAvatar(
                                            child: Icon(Icons.edit)),
                                        onTap: () {
                                          var type = "fullName";
                                          var current = name;
                                          editForm(type, current);
                                        },
                                      ),
                                    ),
                                    Container(
                                      child: ListTile(
                                        title: Text("Profile Title:"),
                                        subtitle: Text(title),
                                        leading: Icon(Icons.arrow_right),
                                        trailing: CircleAvatar(
                                            child: Icon(Icons.edit)),
                                        onTap: () {
                                          var type = "title";
                                          var current = title;
                                          editForm(type, current);
                                        },
                                      ),
                                    ),
                                    Container(
                                      child: ListTile(
                                        title: Text("Current Address:"),
                                        subtitle: Text(currAdd),
                                        leading: Icon(Icons.arrow_right),
                                        trailing: CircleAvatar(
                                            child: Icon(Icons.edit)),
                                        onTap: () {
                                          var type = "currentLoc";
                                          var current = currAdd;
                                          editForm(type, current);
                                        },
                                      ),
                                    ),
                                    Container(
                                      child: ListTile(
                                        title: Text("Parmanent Address:"),
                                        subtitle: Text(perAdd),
                                        leading: Icon(Icons.arrow_right),
                                        trailing: CircleAvatar(
                                            child: Icon(Icons.edit)),
                                        onTap: () {
                                          var type = "parmanentLoc";
                                          var current = perAdd;
                                          editForm(type, current);
                                        },
                                      ),
                                    ),
                                    Container(
                                      child: ListTile(
                                        title: Text("About:"),
                                        subtitle: Text(about),
                                        leading: Icon(Icons.arrow_right),
                                        trailing: CircleAvatar(
                                            child: Icon(Icons.edit)),
                                        onTap: () {
                                          var type = "about";
                                          var current = about;
                                          editForm(type, current);
                                        },
                                      ),
                                    ),
                                    Container(
                                      child: ListTile(
                                        title: Text("Relationship Status:"),
                                        subtitle: Text(relation),
                                        leading: Icon(Icons.arrow_right),
                                        trailing: CircleAvatar(
                                            child: Icon(Icons.edit)),
                                        onTap: () {
                                          var type = "relationship";
                                          var current = relation;
                                          editForm(type, current);
                                        },
                                      ),
                                    ),
                                    Container(
                                      child: ListTile(
                                        title: Text("Religion:"),
                                        subtitle: Text(religion),
                                        leading: Icon(Icons.arrow_right),
                                        trailing: CircleAvatar(
                                            child: Icon(Icons.edit)),
                                        onTap: () {
                                          var type = "religion";
                                          var current = religion;
                                          editForm(type, current);
                                        },
                                      ),
                                    ),
                                    Container(
                                      child: ListTile(
                                        title: Text("Father's Name:"),
                                        subtitle: Text(father),
                                        leading: Icon(Icons.arrow_right),
                                        trailing: CircleAvatar(
                                            child: Icon(Icons.edit)),
                                        onTap: () {
                                          var type = "fatherName";
                                          var current = father;
                                          editForm(type, current);
                                        },
                                      ),
                                    ),
                                    Container(
                                      child: ListTile(
                                        title: Text("Mother's Name:"),
                                        subtitle: Text(mother),
                                        leading: Icon(Icons.arrow_right),
                                        trailing: CircleAvatar(
                                          child: Icon(Icons.edit),
                                        ),
                                        onTap: () {
                                          var type = "motherName";
                                          var current = mother;
                                          editForm(type, current);
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Center(child: Text("Loading...")),
            );
          }
        },
      ),
    );
  }
}
/*
class Fact {
  int id;
  String fact_id;
  String fact;
  String image;
  String reference;

  Fact(this.id, this.fact_id, this.fact, this.image, this.reference);

  Fact.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        fact_id = json['fullName'],
        fact = json['title'],
        image = json['currentLoc'],
        reference = json['parmanentLoc'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'fact_id': fact_id,
        'fact': fact,
        'image': image,
        'reference': reference,
      };
}
*/
/*

Container(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(80),
                            child: Image.network(
                              "https://www.w3schools.com/tags/img_girl.jpg",
                              height: screenHeight / 4,
                              width: screenWeight / 2,
                            ),
                          ),
                        )

*/
