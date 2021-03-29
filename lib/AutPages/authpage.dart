import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:pinder/main_bloc/main_bloc.dart';
import 'package:provider/provider.dart';

import '../main_bloc/main_events.dart';

class AuthMainPage extends StatefulWidget {
  AuthMainPage({Key key}) : super(key: key);

  @override
  _AuthMainPageState createState() => _AuthMainPageState();
}

class _AuthMainPageState extends State<AuthMainPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * .3,
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
            height: MediaQuery.of(context).size.height * .2,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
                onTap: () {
                  context.read<MainBloc>().add(GotoSigninPage());
                },
                child: Container(
                  width: MediaQuery.of(context).size.width * .4,
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
              GestureDetector(
                onTap: () {
                  context.read<MainBloc>().add(GotoSignupPage());
                },
                child: Container(
                  width: MediaQuery.of(context).size.width * .4,
                  height: MediaQuery.of(context).size.height * .07,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: Color.fromRGBO(216, 146, 22, 100)),
                  child: Center(
                    child: AutoSizeText(
                      "Üye ol",
                      minFontSize: 1,
                      maxLines: 1,
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                ),
              )
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * .025,
          ),
          GestureDetector(
            onTap: () {
              context.read<MainBloc>().add(GoToTabsPage());
            },
            child: Container(
              width: MediaQuery.of(context).size.width * .4,
              height: MediaQuery.of(context).size.height * .07,
              child: Center(
                child: AutoSizeText(
                  "Kayıt olmadan devam et",
                  minFontSize: 1,
                  maxLines: 1,
                  style: TextStyle(color: Colors.white, fontSize: 60),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
