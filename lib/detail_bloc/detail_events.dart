import 'package:flutter/material.dart';

abstract class DetailEvents {}

class GetDetail extends DetailEvents {
  final String id;
  GetDetail({@required this.id}) : assert(id != null);
}

class StatrupfotDetail extends DetailEvents {}
