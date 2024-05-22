import 'package:bloc/bloc.dart';
import 'package:start/core/api_service/base_Api_service.dart';
import 'package:start/core/api_service/base_repo.dart';
import 'package:start/core/constants/api_constants.dart';
import 'package:start/core/errors/failures.dart';
import 'package:start/core/utils/services/shared_preferences.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final BaseApiService client;
  LoginBloc({required this.client}) : super(LoginInitial()) {
    on<Loginevent>((event, emit) async {
      emit(LoadingState());
      final data = await BaseRepo.repoRequest(
        request: () async {
          var data =
              await client.postRequest(url: ApiConstants.login, jsonBody: {
            "email": event.email,
            "password": event.password,
            "fcm_device_token": "vnfngkdjkfjek"
          });
          // List<CategoryModel> categories = [];
          // data['data'].forEach(
          //     (element) => categories.add(CategoryModel.fromJson(element)));
          if (data['token'] != null) {
            PreferenceUtils.setString('token', data['token']);
          }
          return data['user']['is_provider'];
        },
      );

      data.fold((f) {
        emit(_mapFailureToState(f));
      }, (data) {
        emit(SuccessLoginState(isprovider: data));
      });
    });
    on<ShowPasswordevent>((event, emit) {
      emit(ShowPasswordstate());
    });
  }

  _mapFailureToState(Failure f) {
    switch (f.runtimeType) {
      case OfflineFailure:
        return ErrorLogingState(message: 'No internet');

      case NetworkErrorFailure:
        return ErrorLogingState(
          message: (f as NetworkErrorFailure).message,
        );

      default:
        return ErrorLogingState(
          message: 'Error',
        );
    }
  }
}
