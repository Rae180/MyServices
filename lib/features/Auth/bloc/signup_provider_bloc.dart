import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:start/core/api_service/base_Api_service.dart';
import 'package:start/core/api_service/base_repo.dart';
import 'package:start/core/constants/api_constants.dart';
import 'package:start/core/errors/failures.dart';
import 'package:start/core/utils/helpers/form_submission_state.dart';
import 'package:start/core/utils/services/shared_preferences.dart';
import 'package:start/features/home/model/category_model.dart';
import 'package:start/features/home/model/service_model.dart';

part 'signup_provider_event.dart';
part 'signup_provider_state.dart';

class SignupProviderBloc
    extends Bloc<SignupProviderEvent, SignupProviderState> {
  final BaseApiService client;

  SignupProviderBloc({required this.client})
      : super(SignupProviderState.empty()) {
    on<AddCategoriesevent>((event, emit) {
      emit(state.copyWith(
          categories: event.categories,
          formSubmissionState: const InitialFormState()));
    });
    on<AddServicesevent>((event, emit) {
      emit(state.copyWith(
          services: event.services,
          formSubmissionState: const InitialFormState()));
    });
    on<SelectCategoryevent>((event, emit) {
      print('saaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa${event.category.name}');
      emit(state.copyWith(
          selectCategory: event.category,
          formSubmissionState: SelectCategory()));
    });
    on<SelectServiceevent>((event, emit) {
      emit(state.copyWith(
          selectService: event.service,
          formSubmissionState: const InitialFormState()));
    });

    on<SelectGenderevent>((event, emit) {
      emit(state.copyWith(
          gender: event.gender, formSubmissionState: const InitialFormState()));
    });
    on<Selectbirthdayevent>((event, emit) {
      emit(state.copyWith(
          birthdaydate: event.birthday,
          formSubmissionState: const InitialFormState()));
    });

    on<ShowPasswordevent>((event, emit) => emit(state.copyWith(
        showPassword: event.value,
        formSubmissionState: const InitialFormState())));
    on<ShowRePasswordevent>((event, emit) => emit(state.copyWith(
        showPassword1: event.value,
        formSubmissionState: const InitialFormState())));

    on<SubmitSignupProviderevent>((event, emit) async {
      emit(state.copyWith(formSubmissionState: FormSubmittingState()));
      final data = await BaseRepo.repoRequest(
        request: () async {
       final data =    await client.multipart(
              url: ApiConstants.signupprovider,
              jsonBody: {
                "email": event.email,
                "password": event.password,
                'first_name': event.firstName,
                'last_name': event.lastName,
                'c_password': event.REpassword,
                'phone_num': event.phoneNumber,
                'gender': state.gender == '0' ? 'male' :'female',
                'main_address': event.address,
                'birth_date': state.birthdaydate,
                'service_id': state.selectService!.id,
                'job_description': event.job,
                'hourly_rate': event.hourly
              },
              file: event.userimageFile);
              PreferenceUtils.setString('token', data['token']);
          // List<CategoryModel> categories = [];
          // data['data'].forEach(
          //     (element) => categories.add(CategoryModel.fromJson(element)));
        },
      );

      data.fold((f) {
        emit(state.copyWith(formSubmissionState: _mapFailureToState(f)));
      }, (data) {
        emit(state.copyWith(formSubmissionState: FormSuccesfulState()));
      });
    });
  }

  FormSubmissionState _mapFailureToState(Failure f) {
    switch (f.runtimeType) {
      case OfflineFailure:
        return FormNoInternetState();

      case NetworkErrorFailure:
        return FormNetworkErrorState(
          message: (f as NetworkErrorFailure).message,
        );

      default:
        return const FormNetworkErrorState(
          message: 'Error',
        );
    }
  }
}
