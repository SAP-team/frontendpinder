abstract class MainStates {}

class ToHomPage extends MainStates {}

class ToDetilPage extends MainStates {
  ToDetilPage(this.postid);
  final String postid;
}
