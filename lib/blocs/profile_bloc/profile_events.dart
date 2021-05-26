import 'package:flutter/material.dart';
import 'package:pinder/halpers/models/updatemodel.dart';

abstract class ProfileEvents {}

class GetUserData extends ProfileEvents {}

class ProfileStartup extends ProfileEvents {}

class UpdateProfile extends ProfileEvents {
  final UpdateModel model;
  UpdateProfile({@required this.model});
}
