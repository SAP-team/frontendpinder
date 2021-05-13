import 'package:bloc/bloc.dart';
import 'package:pinder/detail_bloc/detail_events.dart';
import 'package:pinder/detail_bloc/detail_states.dart';
import 'package:pinder/halpers/api.dart';

class DetailBloc extends Bloc<DetailEvents, DetailStates> {
  DetailBloc() : super(Loading());

  @override
  Stream<DetailStates> mapEventToState(DetailEvents event) async* {
    if (event is GetDetail) yield* getdetail(event.id);
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
}
