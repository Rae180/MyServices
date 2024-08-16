part of 'profile_bloc.dart';

@immutable
sealed class ProfileEvent {}

class GetProfileEvent extends ProfileEvent {}

class UpdateimageEvent extends ProfileEvent {
  final File file;

  UpdateimageEvent({required this.file});
}

class UpdateProfileEvent extends ProfileEvent {
  final ProfileModel profileModel;

  UpdateProfileEvent({required this.profileModel});
}


class DeleteAccountEvent extends ProfileEvent{}