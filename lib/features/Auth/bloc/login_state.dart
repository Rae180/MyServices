part of 'login_bloc.dart';

 class LoginState {}

 class LoginInitial extends LoginState {}

 class ShowPasswordstate extends LoginState {}

 class LoadingState extends LoginState {}

 class SuccessLoginState extends LoginState {
  final int isprovider;

  SuccessLoginState({required this.isprovider});
}

 class ErrorLogingState extends LoginState {
  final String message;

  ErrorLogingState({required this.message});
}
