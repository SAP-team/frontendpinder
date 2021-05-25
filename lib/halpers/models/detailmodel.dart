import 'dart:typed_data';

import 'commentmodel.dart';

class DetailModel {
  String disc, price, telno;
  Uint8List image;
  List<CommentModel> comment;
  DetailModel(String disc, String price, String telno, Uint8List image,
      List<CommentModel> comment) {
    this.disc = disc;
    this.price = price;
    this.telno = telno;
    this.image = image;
    this.comment = comment;
  }
}
