import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pinder/blocs/addpost_bloc/addpost_bloc.dart';
import 'package:pinder/blocs/addpost_bloc/addpost_events.dart';
import 'package:pinder/blocs/addpost_bloc/addpost_states.dart';
import 'package:pinder/halpers/loading.dart';
import 'package:pinder/halpers/models/newpostmodel.dart';

class AddPage extends StatefulWidget {
  AddPage({Key key}) : super(key: key);
  @override
  _AddPageState createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  File pp;
  final picker = ImagePicker();
  bool firstcheckbox = false, secondcheckbox = false;
  TextEditingController explain = new TextEditingController(),
      price = new TextEditingController();
  String image, number;
  String uploadimage;

  getfromgalery() async {
    final pickedfile = await picker.getImage(source: ImageSource.gallery);
    if (pickedfile != null) {
      File compressedFile = await FlutterNativeImage.compressImage(
          pickedfile.path,
          quality: 90,
          targetWidth: 400,
          targetHeight: 300,
          percentage: 90);
      compressedFile.readAsBytes().then((value) {
        uploadimage = base64Encode(value);
      });

      setState(() {
        pp = File(pickedfile.path);
      });
    }
  }

  getfromcamera() async {
    final pickedfile = await picker.getImage(source: ImageSource.camera);
    if (pickedfile != null) {
      File compressedFile = await FlutterNativeImage.compressImage(
          pickedfile.path,
          quality: 90,
          targetWidth: 400,
          targetHeight: 300,
          percentage: 90);
      compressedFile.readAsBytes().then((value) {
        uploadimage = base64Encode(value);
      });
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
  void initState() {
    final box = GetStorage();
    super.initState();
    setState(() {
      number = box.read("number") ?? "";
    });
  }

  Widget home() {
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
              controller: explain,
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
            height: MediaQuery.of(context).size.height * .09,
            child: CupertinoTextField(
              controller: price,
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
          Visibility(
            visible: number != "",
            child: Row(
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
                    "Gönderi sözleşmesini kabul ediyorum",
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
            onTap: () {
              context.read<AddPostBloc>().add(AddPost(
                  model: new NewPostModel(
                      explain.text.trim(),
                      price.text.trim(),
                      firstcheckbox ? number : "",
                      uploadimage)));
            },
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

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddPostBloc, AddPostStates>(
        builder: (BuildContext context, AddPostStates state) {
      if (state is Loading) {
        return LoadinPage();
      } else {
        return home();
      }
    });
  }
}
