import 'package:pinder/halpers/models/detailmodel.dart';

abstract class DetailStates {}

class Loading extends DetailStates {}

class Error extends DetailStates {
  Error(this.error);
  final String error;
}

class Succses extends DetailStates {
  Succses(this.model);
  final DetailModel model;
}
