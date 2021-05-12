import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:pinder/AutPages/signinpage.dart';
import 'package:pinder/AutPages/signup.dart';
import 'package:pinder/blocs/auth_bloc/auth_bloc.dart';
import 'package:pinder/blocs/auth_bloc/auth_states.dart';
import 'package:pinder/tabspage.dart';

import '../DetailPostPage.dart';
import 'authpage.dart';

class MainAuthState extends StatefulWidget {
  MainAuthState({Key key}) : super(key: key);

  @override
  _MainAuthStateState createState() => _MainAuthStateState();
}

class _MainAuthStateState extends State<MainAuthState> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(40, 41, 50, 100),
      body: BlocBuilder<AuthBloc, AuthStates>(
          builder: (BuildContext context, AuthStates state) {
        if (state is ToMainAuthPage) {
          return AuthMainPage();
        } else if (state is ToSignIn) {
          return SignInPage();
        } else if (state is ToSignUp) {
          return SignUpPage();
        }
      }),
    );
  }
}
