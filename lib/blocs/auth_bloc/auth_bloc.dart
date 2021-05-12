import 'package:bloc/bloc.dart';
import 'package:get_storage/get_storage.dart';

import 'package:pinder/halpers/api.dart';

import 'auth_events.dart';
import 'auth_states.dart';

class AuthBloc extends Bloc<AuthEvents, AuthStates> {
  AuthBloc() : super(SignInStatusGetting());

  @override
  Stream<AuthStates> mapEventToState(AuthEvents event) async* {
    if (event is GetSigninStatus) {
      yield SignInStatusGetting();
      yield* _getsigninstatus();
    } else if (event is GotoSigninPage) {
      yield ToSignIn();
    } else if (event is GotoMainAuthPage) {
      yield ToMainAuthPage();
    } else if (event is GotoSignupPage) {
      yield ToSignUp();
    } else if (event is SigninUser) {
      yield* signin(event);
    }
  }

  Stream<AuthStates> signin(SigninUser event) async* {
    Api api = new Api();
    try {
      final result = await api.loginin(event.email, event.passwod);
      print(result);
    } on Exception catch (e) {
      print('error is: ${e.toString()}');
      yield SignInStatusFailed();
    }
  }

  Stream<AuthStates> _getsigninstatus() async* {
    try {
      final box = GetStorage();
      String uid = box.read("uid") ?? "";
      if (uid == "") {
        yield ToMainAuthPage();
      } else {
        yield SignInStatusFailed();
      }
    } on Exception catch (e) {
      print('error is: ${e.toString()}');
      yield SignInStatusFailed();
    }
  }
}
