import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({Key key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  File pp;
  final picker = ImagePicker();

  getfromgalery() async {
    final pickedfile = await picker.getImage(source: ImageSource.gallery);
    if (pickedfile != null) {
      setState(() {
        pp = File(pickedfile.path);
      });
      setState(() {
        pp = File(pickedfile.path);
      });
    }
  }

  getfromcamera() async {
    final pickedfile = await picker.getImage(source: ImageSource.camera);
    if (pickedfile != null) {
      setState(() {
        pp = File(pickedfile.path);
      });
    }
  }

  void showpopup() {
    showCupertinoModalPopup(
        context: context,
        builder: (cxt) {
          return CupertinoActionSheet(
            actions: [
              CupertinoActionSheetAction(
                child: Text(
                  "Kamera",
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
                onPressed: () {
                  getfromcamera();
                  Navigator.pop(context);
                },
              ),
              CupertinoActionSheetAction(
                child: Text(
                  "Galeri",
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
                onPressed: () {
                  getfromgalery();
                  Navigator.pop(context);
                },
              ),
            ],
            cancelButton: CupertinoActionSheetAction(
              child: Text(
                "iptal",
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (OverscrollIndicatorNotification overscroll) {
          overscroll.disallowGlow();
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * .1,
                padding: EdgeInsets.all(20),
                child: Center(
                  child: AutoSizeText(
                    "Profil",
                    minFontSize: 1,
                    maxLines: 1,
                    style: TextStyle(color: Colors.white, fontSize: 60),
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 1,
                color: Color.fromRGBO(80, 81, 87, 100),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * .015,
              ),
              GestureDetector(
                  onTap: () {
                    showpopup();
                  },
                  child: pp != null
                      ? CircleAvatar(
                          radius: MediaQuery.of(context).size.width * 0.15,
                          backgroundColor: Colors.transparent,
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(100.0),
                              child: Image.file(
                                pp,
                                width: MediaQuery.of(context).size.width * 0.3,
                                height: MediaQuery.of(context).size.width * 0.3,
                                fit: BoxFit.fill,
                              )),
                        )
                      : Container(
                          width: MediaQuery.of(context).size.width * 0.3,
                          height: MediaQuery.of(context).size.width * 0.3,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white),
                          ),
                          child: Icon(
                            Icons.person,
                            color: Colors.white,
                            size: MediaQuery.of(context).size.width * 0.15,
                          ),
                        )),
              SizedBox(
                height: MediaQuery.of(context).size.height * .015,
              ),
              Container(
                width: MediaQuery.of(context).size.width * .9,
                height: MediaQuery.of(context).size.height * .07,
                child: CupertinoTextField(
                  placeholder: "İsim",
                  style: TextStyle(color: Colors.white),
                  placeholderStyle:
                      TextStyle(color: Colors.white.withAlpha(60)),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Color.fromRGBO(47, 48, 60, 100)),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * .025,
              ),
              Container(
                width: MediaQuery.of(context).size.width * .9,
                height: MediaQuery.of(context).size.height * .07,
                child: CupertinoTextField(
                  placeholder: "Soy isim",
                  style: TextStyle(color: Colors.white),
                  placeholderStyle:
                      TextStyle(color: Colors.white.withAlpha(60)),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Color.fromRGBO(47, 48, 60, 100)),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * .025,
              ),
              Container(
                width: MediaQuery.of(context).size.width * .9,
                height: MediaQuery.of(context).size.height * .07,
                child: CupertinoTextField(
                  placeholder: "E-mail",
                  style: TextStyle(color: Colors.white),
                  placeholderStyle:
                      TextStyle(color: Colors.white.withAlpha(60)),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Color.fromRGBO(47, 48, 60, 100)),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * .025,
              ),
              Container(
                width: MediaQuery.of(context).size.width * .9,
                height: MediaQuery.of(context).size.height * .07,
                child: CupertinoTextField(
                  placeholder: "Şifre",
                  style: TextStyle(color: Colors.white),
                  placeholderStyle:
                      TextStyle(color: Colors.white.withAlpha(60)),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Color.fromRGBO(47, 48, 60, 100)),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * .025,
              ),
              Container(
                width: MediaQuery.of(context).size.width * .9,
                height: MediaQuery.of(context).size.height * .07,
                child: CupertinoTextField(
                  placeholder: "Şifre 2",
                  style: TextStyle(color: Colors.white),
                  placeholderStyle:
                      TextStyle(color: Colors.white.withAlpha(60)),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Color.fromRGBO(47, 48, 60, 100)),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * .025,
              ),
              GestureDetector(
                onTap: () {},
                child: Container(
                  width: MediaQuery.of(context).size.width * .6,
                  height: MediaQuery.of(context).size.height * .07,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: Color.fromRGBO(216, 146, 22, 100)),
                  child: Center(
                    child: AutoSizeText(
                      "Güncelle",
                      minFontSize: 1,
                      maxLines: 1,
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
