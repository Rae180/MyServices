part of 'mypost_bloc.dart';

@immutable
sealed class MypostState {}

final class MypostInitial extends MypostState {}

class LoadingState extends MypostState {}

class SuccessLoadedPost extends MypostState {
  final List<Post> data;

  SuccessLoadedPost({required this.data});
}

class SuccessAddState extends MypostState{}

class ErrorState extends MypostState {
  final String error;

  ErrorState({required this.error});
}