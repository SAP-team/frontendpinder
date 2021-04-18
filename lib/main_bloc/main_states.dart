abstract class MainStates {}

class SignInStatusGetting extends MainStates {}

class SignInStatusSucsess extends MainStates {}

class ToSignIn extends MainStates {}

class ToSignUp extends MainStates {}

class ToMainAuthPage extends MainStates {}

class ToTabsPage extends MainStates {}

class SignInStatusFailed extends MainStates {}

class ToDetilPage extends MainStates {
  ToDetilPage(this.postid);
  final String postid;
}
