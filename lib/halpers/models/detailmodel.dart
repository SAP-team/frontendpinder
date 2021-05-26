import 'dart:typed_data';

import 'commentmodel.dart';

class DetailModel {
  String disc, price, telno, username, id;
  Uint8List image, userimage;
  List<CommentModel> comment;
  DetailModel(
      String disc,
      String price,
      String telno,
      Uint8List image,
      List<CommentModel> comment,
      String username,
      Uint8List userimage,
      String id) {
    this.disc = disc;
    this.price = price;
    this.telno = telno;
    this.image = image;
    this.comment = comment;
    this.userimage = userimage;
    this.username = username;
    this.id = id;
  }
}
