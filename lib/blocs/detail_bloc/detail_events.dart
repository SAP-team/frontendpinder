import 'package:flutter/material.dart';
import 'package:pinder/halpers/models/newcommentmode.dart';

abstract class DetailEvents {}

class GetDetail extends DetailEvents {
  final String id;
  GetDetail({@required this.id}) : assert(id != null);
}

class AddComment extends DetailEvents {
  final NewCommentModel model;
  AddComment({@required this.model}) : assert(model != null);
}

class StatrupfotDetail extends DetailEvents {}
