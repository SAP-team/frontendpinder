abstract class SignupStates {}

class Error extends SignupStates {
  Error(this.error);
  final String error;
}

class Signingup extends SignupStates {}

class Idle extends SignupStates {}
