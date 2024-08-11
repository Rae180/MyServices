part of 'notification_bloc.dart';

@immutable
sealed class NotificationState {}

final class NotificationInitial extends NotificationState {}

class LoadingState extends NotificationState {}

class SuccessLoadednotifications extends NotificationState {
  final List<NotifictionModel> data;

  SuccessLoadednotifications({required this.data});
}

class ErrorState extends NotificationState {
  final String error;

  ErrorState({required this.error});
}
