import 'dart:typed_data';

class CommentModel {
  String userid, postcomment;
  Uint8List image;
  CommentModel(String userid, String postcomment, Uint8List image) {
    this.userid = userid;
    this.postcomment = postcomment;
    this.image = image;
  }
}
