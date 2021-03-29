import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../main_bloc/main_bloc.dart';
import '../main_bloc/main_events.dart';

class SignUpPage extends StatefulWidget {
  SignUpPage({Key key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  margin: EdgeInsets.only(left: 10),
                  child: IconButton(
                      icon: Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        context.read<MainBloc>().add(GotoMainAuthPage());
                      }),
                )
              ],
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * .2,
              padding: EdgeInsets.all(20),
              child: Center(
                child: AutoSizeText(
                  "Pinder",
                  minFontSize: 1,
                  maxLines: 1,
                  style: TextStyle(color: Colors.white, fontSize: 60),
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * .1,
            ),
            Container(
              width: MediaQuery.of(context).size.width * .9,
              height: MediaQuery.of(context).size.height * .07,
              child: CupertinoTextField(
                placeholder: "İsim",
                style: TextStyle(color: Colors.white),
                placeholderStyle: TextStyle(color: Colors.white.withAlpha(60)),
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
                placeholderStyle: TextStyle(color: Colors.white.withAlpha(60)),
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
                placeholderStyle: TextStyle(color: Colors.white.withAlpha(60)),
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
                placeholderStyle: TextStyle(color: Colors.white.withAlpha(60)),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color.fromRGBO(47, 48, 60, 100)),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * .05,
            ),
            GestureDetector(
              onTap: () {
                context.read<MainBloc>().add(GotoSigninPage());
              },
              child: Container(
                width: MediaQuery.of(context).size.width * .6,
                height: MediaQuery.of(context).size.height * .07,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: Color.fromRGBO(216, 146, 22, 100)),
                child: Center(
                  child: AutoSizeText(
                    "Giriş yap",
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
    );
  }
}
