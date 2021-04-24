abstract class AuthStates {}

class SignInStatusGetting extends AuthStates {}

class SignInStatusSucsess extends AuthStates {}

class ToSignIn extends AuthStates {}

class ToSignUp extends AuthStates {}

class ToMainAuthPage extends AuthStates {}

class SignInStatusFailed extends AuthStates {}
