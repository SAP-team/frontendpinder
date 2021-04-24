import 'package:flutter/cupertino.dart';

abstract class MainEvents {}

class GotoMainAuthPage extends MainEvents {}

class GoToHomPage extends MainEvents {}

class GoToDetailPage extends MainEvents {
  final String postid;
  GoToDetailPage({@required this.postid}) : assert(postid != null);
}
