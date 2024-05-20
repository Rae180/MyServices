part of 'sign_up_user_bloc.dart';

sealed class SignUpUserEvent  {
  const SignUpUserEvent();

}

class SignUpUserevevnt extends SignUpUserEvent {
  final File image;
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? phoneNumber;
  final String? password;
  final String? cpassword;
  final String? gender;
  final String? address;

  SignUpUserevevnt(
      {required this.image,
      required this.firstName,
      required this.lastName,
      required this.email,
      required this.phoneNumber,
      required this.password,
      required this.gender,
      required this.cpassword,
      required this.address});
}


class ShowPasswordevent extends SignUpUserEvent{}
class ShowRePasswordevent extends SignUpUserEvent{}