import 'dart:typed_data';

class FeedModel {
  String id, postname;
  Uint8List image;
  FeedModel(String id, String postname, Uint8List image) {
    this.id = id;
    this.postname = postname;
    this.image = image;
  }
}
