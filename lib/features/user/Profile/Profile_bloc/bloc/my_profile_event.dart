part of 'my_profile_bloc.dart';

 class MyProfileEvent {}

 class GetProfileEvent extends MyProfileEvent {}

class UpdateimageEvent extends MyProfileEvent {
  final File file;

  UpdateimageEvent({required this.file});
}

class UpdateProfileEvent extends MyProfileEvent {
  final MyProfile profileModel;

  UpdateProfileEvent({required this.profileModel});
}


class DeleteAccountEvent extends MyProfileEvent{}
