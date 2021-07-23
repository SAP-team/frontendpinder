import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pinder/blocs/profile_bloc/profile_bloc.dart';
import 'package:pinder/blocs/profile_bloc/profile_events.dart';
import 'package:pinder/blocs/profile_bloc/profile_states.dart';
import 'package:pinder/halpers/loading.dart';
import 'package:pinder/halpers/models/updatemodel.dart';
import 'package:pinder/halpers/profilemodel.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({Key key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  File pp;
  final picker = ImagePicker();
  TextEditingController name = new TextEditingController(),
      lastname = new TextEditingController(),
      email = new TextEditingController(),
      phonenumber = new TextEditingController(),
      password = new TextEditingController();
  String uploadimage;
  Uint8List iamge;
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

  Widget sucsses(ProfileModel model) {
    if (model.image != "") iamge = base64Decode(model.image.toString());
    print(model.image);
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
                          child: model.image != ""
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(100.0),
                                  child: Image.memory(
                                    iamge,
                                    fit: BoxFit.fill,
                                  ),
                                )
                              : Icon(
                                  Icons.person,
                                  color: Colors.white,
                                  size:
                                      MediaQuery.of(context).size.width * 0.15,
                                ),
                        )),
              SizedBox(
                height: MediaQuery.of(context).size.height * .015,
              ),
              Container(
                width: MediaQuery.of(context).size.width * .9,
                height: MediaQuery.of(context).size.height * .07,
                child: CupertinoTextField(
                  placeholder: "${model.name ?? "İsim"}",
                  controller: name,
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
                  placeholder: "${model.surname ?? "Soy isim"}",
                  controller: lastname,
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
                  placeholder: "${model.email ?? "E-mail"}",
                  controller: email,
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
                  placeholder:
                      "${model.phone == "" ? "Telefon numarası" : model.phone}",
                  controller: phonenumber,
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
                  controller: password,
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
                onTap: () {
                  UpdateModel model = new UpdateModel(
                      email.text.trim() ?? "",
                      password.text.trim() ?? "",
                      name.text.trim() ?? "",
                      lastname.text.trim() ?? "",
                      uploadimage ?? "",
                      phonenumber.text.trim() ?? "");
                  context.read<ProfileBloc>().add(UpdateProfile(model: model));
                },
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

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileStates>(
      builder: (context, state) {
        print(state);
        if (state is GettingProfile || state is UpdatingProfile) {
          return LoadinPage();
        } else if (state is ProfileSucsses) {
          return sucsses(state.model);
        }
      },
    );
  }
}
