part of 'mangeorder_bloc.dart';

@immutable
sealed class MangeorderState {}

final class MangeorderInitial extends MangeorderState {}

class LoadingState extends MangeorderState {}

class ErrormanageState extends MangeorderState {
  final String error;
  ErrormanageState({
    required this.error,
  });
}

class DonemanageState extends MangeorderState{}