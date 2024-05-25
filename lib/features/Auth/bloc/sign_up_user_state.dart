part of 'sign_up_user_bloc.dart';

 class SignUpUserState {
  const SignUpUserState();

 
}

 class SignUpUserInitial extends SignUpUserState {}

 class ShowPasswordstate extends SignUpUserState {} 
 class ShowRePasswordstate extends SignUpUserState {} 

 class LoadingState extends SignUpUserState {}

 class SuccessSignUpState extends SignUpUserState {
}

 class ErrorSignUpState extends SignUpUserState {
  final String message;

  ErrorSignUpState({required this.message});
}

