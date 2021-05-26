import 'package:bloc/bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pinder/blocs/profile_bloc/profile_events.dart';
import 'package:pinder/blocs/profile_bloc/profile_states.dart';
import 'package:pinder/halpers/api.dart';
import 'package:pinder/halpers/models/updatemodel.dart';

class ProfileBloc extends Bloc<ProfileEvents, ProfileStates> {
  ProfileBloc() : super(ProfileIdle());

  @override
  Stream<ProfileStates> mapEventToState(ProfileEvents event) async* {
    if (event is GetUserData) {
      yield GettingProfile();
      yield* signin();
    }
    if (event is UpdateProfile) {
      yield UpdatingProfile();
      yield* updateprofile(event.model);
    }
  }

  Stream<ProfileStates> signin() async* {
    Api api = new Api();
    try {
      final box = GetStorage();

      final result = await api.getuserdata(box.read("uid"));
      if (!result["isscuses"]) {
        yield ProfileError(result["result"]);
      } else {
        yield ProfileSucsses(result["result"]);
      }
    } on Exception catch (e) {
      yield ProfileError("");
    }
  }

  Stream<ProfileStates> updateprofile(UpdateModel model) async* {
    Api api = new Api();
    try {
      final result = await api.updateuser(model);
      print(result);
      if (!result["isscuses"]) {
        yield ProfileError(result["result"]);
      } else {
        yield* signin();
      }
    } on Exception catch (e) {
      print(e);
      yield ProfileError("");
    }
  }
}
