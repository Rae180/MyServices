part of 'profile_bloc.dart';

@immutable
sealed class ProfileState {}

final class ProfileInitial extends ProfileState {}

class LoadingState extends ProfileState {}

class SuccessLoadedProfile extends ProfileState {
  final ProfileModel profileModel;

  SuccessLoadedProfile({required this.profileModel});
}

class ErrorState extends ProfileState {
  final String error;

  ErrorState({required this.error});
}

class SuccessUpdateState extends ProfileState{}
class SuccessdelelteState extends ProfileState{}
