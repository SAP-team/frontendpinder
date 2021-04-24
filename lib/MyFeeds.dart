import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddPage extends StatefulWidget {
  AddPage({Key key}) : super(key: key);
  @override
  _AddPageState createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  File pp;
  final picker = ImagePicker();
  bool firstcheckbox = false, secondcheckbox = false;

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
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              showpopup();
            },
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * .2,
              child: pp == null
                  ? Center(
                      child: AutoSizeText(
                        "Resim Ekle",
                        style: TextStyle(color: Colors.white, fontSize: 40),
                      ),
                    )
                  : Image.file(pp),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 1,
            color: Color.fromRGBO(80, 81, 87, 100),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * .025,
          ),
          Container(
            width: MediaQuery.of(context).size.width * .8,
            height: MediaQuery.of(context).size.height * .2,
            child: CupertinoTextField(
              placeholder: "Açıklama",
              textAlign: TextAlign.left,
              padding: EdgeInsets.all(20),
              minLines: 1,
              maxLines: 10,
              style: TextStyle(color: Colors.white),
              cursorColor: Colors.grey[600],
              placeholderStyle: TextStyle(color: Colors.grey[600]),
              textAlignVertical: TextAlignVertical.top,
              decoration: BoxDecoration(
                color: Color.fromRGBO(40, 41, 50, 100),
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * .05,
          ),
          Container(
            width: MediaQuery.of(context).size.width * .8,
            height: MediaQuery.of(context).size.height * .07,
            child: CupertinoTextField(
              placeholder: "Ödül",
              textAlign: TextAlign.center,
              padding: EdgeInsets.all(20),
              minLines: 1,
              maxLines: 1,
              style: TextStyle(color: Colors.white),
              cursorColor: Colors.grey[600],
              placeholderStyle: TextStyle(color: Colors.grey[600]),
              decoration: BoxDecoration(
                  color: Color.fromRGBO(40, 41, 50, 100),
                  borderRadius: BorderRadius.circular(20)),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * .05,
          ),
          Row(
            children: [
              SizedBox(width: MediaQuery.of(context).size.width * .1),
              GestureDetector(
                onTap: () {
                  setState(() {
                    firstcheckbox = !firstcheckbox;
                  });
                },
                child: Container(
                  width: MediaQuery.of(context).size.width * .1,
                  height: MediaQuery.of(context).size.width * .1,
                  decoration:
                      BoxDecoration(border: Border.all(color: Colors.white)),
                  child: firstcheckbox
                      ? Icon(
                          Icons.check,
                          color: Colors.white,
                        )
                      : SizedBox(),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * .6,
                height: MediaQuery.of(context).size.width * .1,
                child: Center(
                  child: AutoSizeText(
                    "Ilan icin beni arasınlar",
                    maxLines: 1,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              )
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * .025,
          ),
          Row(
            children: [
              SizedBox(width: MediaQuery.of(context).size.width * .1),
              GestureDetector(
                onTap: () {
                  setState(() {
                    secondcheckbox = !secondcheckbox;
                  });
                },
                child: Container(
                  width: MediaQuery.of(context).size.width * .1,
                  height: MediaQuery.of(context).size.width * .1,
                  decoration:
                      BoxDecoration(border: Border.all(color: Colors.white)),
                  child: secondcheckbox
                      ? Icon(
                          Icons.check,
                          color: Colors.white,
                        )
                      : SizedBox(),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * .6,
                height: MediaQuery.of(context).size.width * .1,
                child: Center(
                  child: AutoSizeText(
                    "Gonderi sozlesmini kabul ediyorum",
                    maxLines: 1,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              )
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * .05,
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
                  "Paylaş",
                  minFontSize: 1,
                  maxLines: 1,
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
