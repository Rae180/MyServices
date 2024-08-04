part of 'managecurrentorder_bloc.dart';

@immutable
sealed class ManagecurrentorderState {}

final class ManagecurrentorderInitial extends ManagecurrentorderState {}

class LoadingState extends ManagecurrentorderState {}

class LoadingState2 extends ManagecurrentorderState {}

class ErrormanageState extends ManagecurrentorderState {
  final String error;
  ErrormanageState({
    required this.error,
  });
}

class DonemanageState extends ManagecurrentorderState{}