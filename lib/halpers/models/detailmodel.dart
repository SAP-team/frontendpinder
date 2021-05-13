import 'dart:typed_data';

class DetailModel {
  String disc, price, telno;
  Uint8List image;
  DetailModel(String disc, String price, String telno, Uint8List image) {
    this.disc = disc;
    this.price = price;
    this.telno = telno;
    this.image = image;
  }
}
