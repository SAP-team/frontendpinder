import 'dart:typed_data';

class ProfileModel {
  String name, surname, email, phone;
  Uint8List image;
  ProfileModel(String name, String surname, String email, String phone,
      Uint8List image) {
    this.name = name;
    this.surname = surname;
    this.email = email;
    this.image = image;
    this.phone = phone;
  }
}
