import 'package:bloc/bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pinder/main_bloc/main_events.dart';
import 'package:pinder/main_bloc/main_states.dart';

class MainBloc extends Bloc<MainEvents, MainStates> {
  MainBloc() : super(SignInStatusGetting());

  @override
  Stream<MainStates> mapEventToState(MainEvents event) async* {
    if (event is GetSigninStatus) {
      yield SignInStatusGetting();
      yield* _getsigninstatus();
    } else if (event is GotoSigninPage) {
      yield ToSignIn();
    } else if (event is GotoMainAuthPage) {
      yield ToMainAuthPage();
    } else if (event is GotoSignupPage) {
      yield ToSignUp();
    } else if (event is GoToTabsPage) {
      yield ToTabsPage();
    }
  }

  Stream<MainStates> _getsigninstatus() async* {
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
