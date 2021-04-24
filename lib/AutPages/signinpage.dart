import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pinder/auth_bloc/auth_bloc.dart';
import 'package:pinder/auth_bloc/auth_events.dart';
import 'package:provider/provider.dart';

class SignInPage extends StatefulWidget {
  SignInPage({Key key}) : super(key: key);

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
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
                        context.read<AuthBloc>().add(GotoMainAuthPage());
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
                context.read<AuthBloc>().add(GotoSigninPage());
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
