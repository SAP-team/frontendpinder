import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pinder/blocs/siginup_bloc/signup_events.dart';
import 'package:pinder/blocs/signin_bloc/signin_events.dart';
import 'package:pinder/blocs/signin_bloc/signin_states.dart';
import 'package:pinder/halpers/api.dart';

class SigninBloc extends Bloc<SigninEvents, SigninStates> {
  SigninBloc() : super(Idle());

  @override
  Stream<SigninStates> mapEventToState(SigninEvents event) async* {
    if (event is Signin) {
      yield Signingin();
      yield* signin(event);
    }
  }

  Stream<SigninStates> signin(Signin event) async* {
    Api api = new Api();
    try {
      final result = await api.loginin(event.email, event.passwod);
      if (!result["isscuses"]) {
        yield Error(result["result"]);
      } else {
        final box = GetStorage();
        box.write("uid", result["result"]);
        yield Sucsses();
      }
    } on Exception catch (e) {
      yield Error("");
    }
  }
}
