part of 'my_profile_bloc.dart';

class MyProfileState {}


final class LoadingMyProfile extends MyProfileState {}

final class LoadedMyProfile extends MyProfileState {
  final MyProfile profile;

  LoadedMyProfile({required this.profile});
}

final class ErrorMyProfile extends MyProfileState {
  final String message;

  ErrorMyProfile({required this.message});
}
