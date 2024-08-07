import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:start/core/api_service/base_Api_service.dart';
import 'package:start/core/api_service/base_repo.dart';
import 'package:start/core/constants/api_constants.dart';
import 'package:start/core/errors/failures.dart';
import 'package:start/features/provider/profile/model/profile_model.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final BaseApiService client;
  ProfileBloc({required this.client}) : super(ProfileInitial()) {
    on<GetProfileEvent>((event, emit) async {
      emit(LoadingState());
      final data = await BaseRepo.repoRequest(
        request: () async {
          var data = await client.getRequestAuth(
            url: ApiConstants.profile,
          );

          ProfileModel profileModel = ProfileModel.fromJson(data['data']);
          return profileModel;
        },
      );

      data.fold((f) {
        emit(_mapFailureToState(f));
      }, (data) {
        emit(SuccessLoadedProfile(profileModel: data));
      });
    });
    on<UpdateProfileEvent>((event, emit) async {
      emit(LoadingState());
      final data = await BaseRepo.repoRequest(
        request: () async {
          await client.postRequestAuth(
              url: ApiConstants.profile, jsonBody: event.profileModel.toJson());
        },
      );

      data.fold((f) {
        emit(_mapFailureToState(f));
      }, (data) {
        emit(SuccessUpdateState());
      });
    });
    on<UpdateimageEvent>((event, emit) async {
      emit(LoadingState());
      final data = await BaseRepo.repoRequest(
        request: () async {
          await client.multipart2(
              url: ApiConstants.profile,
              jsonBody: {},
              attributeName: 'image',
              files: [event.file]);
        },
      );

      data.fold((f) {
        emit(_mapFailureToState(f));
      }, (data) {
        emit(SuccessUpdateState());
      });
    });
    on<DeleteAccountEvent>((event, emit) async {
      emit(LoadingState());
      final data = await BaseRepo.repoRequest(
        request: () async {
          await client.delete(
              url: ApiConstants.profile,
              );
        },
      );

      data.fold((f) {
        emit(_mapFailureToState(f));
      }, (data) {
        emit(SuccessdelelteState());
        
      });
    });
  }

  _mapFailureToState(Failure f) {
    switch (f.runtimeType) {
      case OfflineFailure:
        return ErrorState(error: 'No internet');

      case NetworkErrorFailure:
        return ErrorState(
          error: (f as NetworkErrorFailure).message,
        );

      default:
        return ErrorState(
          error: 'Error',
        );
    }
  }
}
