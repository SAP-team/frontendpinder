import 'package:flutter/material.dart';

abstract class SignupEvents {}

class Signup extends SignupEvents {
  final String name, surname, email, passwod;
  Signup(
      {@required this.name,
      @required this.surname,
      @required this.email,
      @required this.passwod})
      : assert(name != null, surname != null);
}

class Startup extends SignupEvents {}
