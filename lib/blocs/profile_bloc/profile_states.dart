import 'package:pinder/halpers/profilemodel.dart';

abstract class ProfileStates {}

class ProfileError extends ProfileStates {
  ProfileError(this.error);
  final String error;
}

class GettingProfile extends ProfileStates {}

class ProfileSucsses extends ProfileStates {
  ProfileSucsses(this.model);
  final ProfileModel model;
}

class ProfileIdle extends ProfileStates {}

class UpdatingProfile extends ProfileStates {}

class UpdateSucsses extends ProfileStates {}

class UpdateFail extends ProfileStates {
  UpdateFail(this.error);
  final String error;
}
