part of 'my_profile_bloc.dart';

class MyProfileState {}

final class ProfileInitial extends MyProfileState {}

class LoadingState extends MyProfileState {}

class SuccessLoadedProfile extends MyProfileState {
  final MyProfile profileModel;

  SuccessLoadedProfile({required this.profileModel});
}

class ErrorState extends MyProfileState {
  final String error;

  ErrorState({required this.error});
}

class SuccessUpdateState extends MyProfileState{}
class SuccessdelelteState extends MyProfileState{}
