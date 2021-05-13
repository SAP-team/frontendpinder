abstract class SigninStates {}

class Error extends SigninStates {
  Error(this.error);
  final String error;
}

class Signingin extends SigninStates {}

class Sucsses extends SigninStates {}

class Idle extends SigninStates {}
