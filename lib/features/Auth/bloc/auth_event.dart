part of 'auth_bloc.dart';

 class AuthEvent {
  const AuthEvent();
}

class AppStarted extends AuthEvent {}

class LogOutEvent extends AuthEvent {}
