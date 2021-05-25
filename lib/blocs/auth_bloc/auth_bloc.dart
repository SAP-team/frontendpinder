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
    }
  }

  Stream<AuthStates> _getsigninstatus() async* {
    try {
      final box = GetStorage();
      print(box.read("uid"));
      String uid = box.read("uid") ?? "";
      if (uid == "") {
        yield ToMainAuthPage();
      } else {
        yield SignInStatusSucsess();
      }
    } on Exception catch (e) {
      print('error is: ${e.toString()}');
      yield ToMainAuthPage();
    }
  }
}
