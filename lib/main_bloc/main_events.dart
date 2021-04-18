import 'package:flutter/cupertino.dart';

abstract class MainEvents {}

class GetSigninStatus extends MainEvents {}

class GotoSigninPage extends MainEvents {}

class GotoSignupPage extends MainEvents {}

class GotoMainAuthPage extends MainEvents {}

class GoToTabsPage extends MainEvents {}

class GoToDetailPage extends MainEvents {
  final String postid;
  GoToDetailPage({@required this.postid}) : assert(postid != null);
}
