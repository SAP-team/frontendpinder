abstract class AddPostStates {}

class Loading extends AddPostStates {}

class Error extends AddPostStates {
  Error(this.error);
  final String error;
}

class Sucess extends AddPostStates {}

class MainState extends AddPostStates {}
