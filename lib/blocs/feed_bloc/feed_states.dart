import 'package:pinder/halpers/models/feedmodel.dart';

abstract class FeedStates {}

class Loading extends FeedStates {}

class Error extends FeedStates {
  Error(this.error);
  final String error;
}

class Succses extends FeedStates {
  Succses(this.feed);

  final List<FeedModel> feed;
}
