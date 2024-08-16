part of 'login_bloc.dart';

 class LoginEvent {
}

class Loginevent extends LoginEvent {
  final String email;
  final String password;

  Loginevent({required this.email, required this.password});
}

class ShowPasswordevent extends LoginEvent{}