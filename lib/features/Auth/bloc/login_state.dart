part of 'login_bloc.dart';

sealed class LoginState {}

final class LoginInitial extends LoginState {}

final class ShowPasswordstate extends LoginState {}

final class LoadingState extends LoginState {}

final class SuccessLoginState extends LoginState {
  final int isprovider;

  SuccessLoginState({required this.isprovider});
}

final class ErrorLogingState extends LoginState {
  final String message;

  ErrorLogingState({required this.message});
}
