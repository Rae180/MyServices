part of 'auth_bloc.dart';

 class AuthState {
  const AuthState();
}

 class AuthInitial extends AuthState {}

class UnauthenticatedState extends AuthState {}

class UnactiveAccount extends AuthState {}

class AuthenticatedUserState extends AuthState {}

class AuthenticatedProviderState extends AuthState {}
