import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinder/blocs/siginup_bloc/signup_events.dart';
import 'package:pinder/halpers/api.dart';

import 'singup_states.dart';

class SignUpBloc extends Bloc<SignupEvents, SignupStates> {
  SignUpBloc() : super(Idle());

  @override
  Stream<SignupStates> mapEventToState(SignupEvents event) async* {
    if (event is Signup) {
      yield Signingup();
      yield* signup(event);
    }
  }

  Stream<SignupStates> signup(Signup event) async* {
    Api api = new Api();
    try {
      final result = await api.createuser(
          event.name, event.surname, event.email, event.passwod);
      if (!result["isscuses"]) {
        yield Error(result["result"]);
      }
    } on Exception catch (e) {
      print('error is: ${e.toString()}');
      yield Error("");
    }
  }
}
