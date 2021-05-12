import 'package:flutter/material.dart';

abstract class AuthEvents {}

class GetSigninStatus extends AuthEvents {}

class GotoSigninPage extends AuthEvents {}

class GotoSignupPage extends AuthEvents {}

class SigninUser extends AuthEvents {
  final String email, passwod;
  SigninUser({@required this.email, @required this.passwod})
      : assert(email != null, passwod != null);
}

class GotoMainAuthPage extends AuthEvents {}
