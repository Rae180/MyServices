import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:start/core/api_service/base_Api_service.dart';
import 'package:start/core/api_service/base_repo.dart';
import 'package:start/core/constants/api_constants.dart';
import 'package:start/core/errors/failures.dart';
import 'package:start/features/user/profile/model/my_profile.dart';

part 'my_profile_event.dart';
part 'my_profile_state.dart';

class MyProfileBloc extends Bloc<MyProfileEvent, MyProfileState> {
  final BaseApiService client;

  MyProfileBloc({required this.client}) : super(LoadingMyProfile()) {
    on<FetchProfile>(((event, emit) async {
      emit(LoadingMyProfile());
      final data = await BaseRepo.repoRequest(request: () async {
        var data = await client.getRequestAuth(
          url: ApiConstants.profiley,
        );
        return MyProfile.fromJson(data['data']);
      });

      data.fold((failure) {
        emit(_mapFailureToState(failure));
      }, (profile) {
        emit(LoadedMyProfile(profile: profile));
      });
    }));
  }

  MyProfileState _mapFailureToState(Failure failure) {
    switch (failure.runtimeType) {
      case OfflineFailure:
        return ErrorMyProfile(message: 'No internet connection');
      case NetworkErrorFailure:
        return ErrorMyProfile(
            message: (failure as NetworkErrorFailure).message);
      default:
        return ErrorMyProfile(message: 'An unexpected error occurred');
    }
  }
}
