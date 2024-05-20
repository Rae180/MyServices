part of 'sign_up_user_bloc.dart';

sealed class SignUpUserState {
  const SignUpUserState();

 
}

final class SignUpUserInitial extends SignUpUserState {}

final class ShowPasswordstate extends SignUpUserState {} 
final class ShowRePasswordstate extends SignUpUserState {} 

final class LoadingState extends SignUpUserState {}

final class SuccessSignUpState extends SignUpUserState {
}

final class ErrorSignUpState extends SignUpUserState {
  final String message;

  ErrorSignUpState({required this.message});
}

