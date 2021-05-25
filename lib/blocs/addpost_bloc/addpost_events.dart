import 'package:flutter/cupertino.dart';
import 'package:pinder/halpers/models/newpostmodel.dart';

abstract class AddPostEvents {}

class AddPostStartUp extends AddPostEvents {}

class AddPost extends AddPostEvents {
  final NewPostModel model;
  AddPost({@required this.model}) : assert(model != null);
}
