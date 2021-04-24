import 'package:bloc/bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pinder/main_bloc/main_events.dart';
import 'package:pinder/main_bloc/main_states.dart';

import 'main_events.dart';
import 'main_states.dart';

class MainBloc extends Bloc<MainEvents, MainStates> {
  MainBloc() : super(ToHomPage());

  @override
  Stream<MainStates> mapEventToState(MainEvents event) async* {
    if (event is GoToHomPage) {
      yield ToHomPage();
    } else if (event is GoToDetailPage) {
      yield ToDetilPage(event.postid);
    }
  }
}
