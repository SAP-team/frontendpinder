import 'package:flutter/material.dart';

abstract class SigninEvents {}

class Signin extends SigninEvents {
  final String email, passwod;
  Signin({@required this.email, @required this.passwod})
      : assert(email != null, passwod != null);
}

class Startup extends SigninEvents {}
