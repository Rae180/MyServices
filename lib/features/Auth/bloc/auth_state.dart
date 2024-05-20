part of 'auth_bloc.dart';

sealed class AuthState  {
  const AuthState();
  

}

final class AuthInitial extends AuthState {}
