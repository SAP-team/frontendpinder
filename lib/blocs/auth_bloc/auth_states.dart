abstract class AuthStates {}

class SignInStatusGetting extends AuthStates {}

class SignInStatusSucsess extends AuthStates {}

class ToSignIn extends AuthStates {}

class ToSignUp extends AuthStates {}

class ToMainAuthPage extends AuthStates {}

class Loading extends AuthStates {}

class Error extends AuthStates {
  Error(this.error);
  final String error;
}

class SignInStatusFailed extends AuthStates {}
