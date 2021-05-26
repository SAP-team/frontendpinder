import 'package:bloc/bloc.dart';

import 'package:pinder/halpers/api.dart';
import 'package:pinder/halpers/models/newcommentmode.dart';

import 'detail_events.dart';
import 'detail_states.dart';

class DetailBloc extends Bloc<DetailEvents, DetailStates> {
  DetailBloc() : super(Loading());

  @override
  Stream<DetailStates> mapEventToState(DetailEvents event) async* {
    if (event is GetDetail) {
      yield Loading();
      yield* getdetail(event.id);
    }
    if (event is AddComment) {
      yield Loading();
      yield* addcoment(event.model);
    }
  }

  Stream<DetailStates> getdetail(String id) async* {
    try {
      Api api = new Api();
      final result = await api.getdetail(id);
      if (!result["isscuses"]) {
        yield Error(result["result"]);
      } else {
        yield Succses(result["result"]);
      }
    } on Exception catch (e) {
      print('error is: ${e.toString()}');
      yield Error("");
    }
  }

  Stream<DetailStates> addcoment(NewCommentModel model) async* {
    try {
      Api api = new Api();
      final result = await api.addcoments(model);
      if (!result["isscuses"]) {
        yield Error(result["result"]);
      } else {
        yield* getdetail(result["result"]);
      }
    } on Exception catch (e) {
      print('error is: ${e.toString()}');
      yield Error("");
    }
  }
}
