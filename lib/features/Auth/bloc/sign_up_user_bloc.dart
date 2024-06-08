import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:start/core/api_service/base_Api_service.dart';
import 'package:start/core/api_service/base_repo.dart';
import 'package:start/core/constants/api_constants.dart';
import 'package:start/core/errors/failures.dart';
import 'package:start/core/utils/services/shared_preferences.dart';

part 'sign_up_user_event.dart';
part 'sign_up_user_state.dart';

class SignUpUserBloc extends Bloc<SignUpUserEvent, SignUpUserState> {
  final BaseApiService client;
  SignUpUserBloc({required this.client}) : super(SignUpUserInitial()) {
    on<SignUpUserevevnt>((event, emit) async {
      emit(LoadingState());
      String? deviceToken =
                      await FirebaseMessaging.instance.getToken();
      final data = await BaseRepo.repoRequest(
        request: () async {
          final data = await client.multipart(
              url: ApiConstants.signupuser,
              jsonBody: {
                "email": event.email,
                "password": event.password,
                'first_name': event.firstName,
                'last_name': event.lastName,
                'c_password': event.cpassword,
                'phone_num': event.phoneNumber,
                'gender': event.gender,
                'main_address': event.address,
                'fcm_device_token': deviceToken
              },
              file: event.image);
          if (data['token'] != null) {
            PreferenceUtils.setString('token', data['token']);
            PreferenceUtils.setBool(
                'provider',false);
          }

          // List<CategoryModel> categories = [];
          // data['data'].forEach(
          //     (element) => categories.add(CategoryModel.fromJson(element)));
        },
      );

      data.fold((f) {
        emit(_mapFailureToState(f));
      }, (data) {
        emit(SuccessSignUpState());
      });
    });

    on<ShowPasswordevent>((event, emit) => emit(ShowPasswordstate()));
    on<ShowRePasswordevent>((event, emit) => emit(ShowRePasswordstate()));
  }
  _mapFailureToState(Failure f) {
    switch (f.runtimeType) {
      case OfflineFailure:
        return ErrorSignUpState(message: 'No internet');

      case NetworkErrorFailure:
        return ErrorSignUpState(
          message: (f as NetworkErrorFailure).message,
        );

      default:
        return ErrorSignUpState(
          message: 'Error',
        );
    }
  }
}
