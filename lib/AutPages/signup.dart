import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinder/blocs/auth_bloc/auth_bloc.dart';
import 'package:pinder/blocs/auth_bloc/auth_events.dart';
import 'package:pinder/blocs/siginup_bloc/signup_bloc.dart';
import 'package:pinder/blocs/siginup_bloc/signup_events.dart';
import 'package:pinder/blocs/siginup_bloc/singup_states.dart';

import 'package:provider/provider.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class SignUpPage extends StatefulWidget {
  SignUpPage({Key key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController name = new TextEditingController(),
      surname = new TextEditingController(),
      email = new TextEditingController(),
      password = new TextEditingController();
  final RoundedLoadingButtonController _btnController =
      RoundedLoadingButtonController();
  String text = "Üye ol";
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocListener<SignUpBloc, SignupStates>(
        listener: (context, state) {
          print(state);
          if (state is Error) {
            print(state.error);
            if (state.error == "")
              context.read<AuthBloc>().add(GotoSigninPage());

            setState(() {
              text = state.error.replaceAll('"', "");
              _btnController.reset();
              loading = false;
            });
          } else if (state is Signingup) {
            setState(() {
              loading = true;
            });
          } else if (state is Sucsses) {
            context.read<AuthBloc>().add(GetSigninStatus());

            setState(() {
              loading = false;
            });
          }
        },
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
                  placeholder: "İsim",
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
                  placeholder: "Soy isim",
                  controller: surname,
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
                height: MediaQuery.of(context).size.height * .05,
              ),
              Container(
                width: MediaQuery.of(context).size.width * .6,
                height: MediaQuery.of(context).size.height * .07,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: RoundedLoadingButton(
                  color: Color.fromRGBO(216, 146, 22, 100),
                  controller: _btnController,
                  onPressed: () {
                    if (email.text.trim() != "" &&
                        password.text.trim() != "" &&
                        surname.text.trim() != "" &&
                        name.text.trim() != "")
                      context.read<SignUpBloc>().add(Signup(
                          surname: surname.text.trim(),
                          name: name.text.trim(),
                          email: email.text.trim(),
                          passwod: password.text.trim()));
                    else {
                      setState(() {
                        text = "Alanlar Boş Bırakılamaz";
                        _btnController.reset();
                      });
                    }
                  },
                  child: Center(
                    child: AutoSizeText(
                      text,
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
