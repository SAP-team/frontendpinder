import 'package:bloc/bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pinder/blocs/addpost_bloc/addpost_events.dart';
import 'package:pinder/blocs/addpost_bloc/addpost_states.dart';

import 'package:pinder/halpers/api.dart';
import 'package:pinder/halpers/models/newpostmodel.dart';

class AddPostBloc extends Bloc<AddPostEvents, AddPostStates> {
  AddPostBloc() : super(MainState());

  @override
  Stream<AddPostStates> mapEventToState(AddPostEvents event) async* {
    if (event is AddPost) {
      yield Loading();
      yield* addpost(event.model);
    }
  }

  Stream<AddPostStates> addpost(NewPostModel model) async* {
    try {
      Api api = new Api();
      final result = await api.addpost(model);
      if (!result["isscuses"]) {
        yield Error();
      } else {
        yield Sucess();
      }
    } on Exception catch (e) {
      print('error is: ${e.toString()}');
      yield Error();
    }
  }
}
