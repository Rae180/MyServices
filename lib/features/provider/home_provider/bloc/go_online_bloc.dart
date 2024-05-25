import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:start/core/api_service/base_Api_service.dart';
import 'package:start/core/api_service/base_repo.dart';
import 'package:start/core/constants/api_constants.dart';
import 'package:start/core/errors/failures.dart';
import 'package:start/core/utils/services/shared_preferences.dart';

part 'go_online_event.dart';
part 'go_online_state.dart';

class GoOnlineBloc extends Bloc<GoOnlineEvent, GoOnlineState> {
  final BaseApiService client;
  GoOnlineBloc({required this.client}) : super(GoOnlineState.empty()) {
    on<GoOnlineEvent>((event, emit) async {
      emit(state.copyWith(providerOnlineState: ProviderOnlineState.loading));

      final data = await BaseRepo.repoRequest(
        request: () async {
          var data = await client.getRequestAuth(
              url: ApiConstants.changestatusprovicer);

          if (data['data']['status'] == 'Offline') {
            PreferenceUtils.setBool('isonline', false);
          } else {
            PreferenceUtils.setBool('isonline', true);
          }
        },
      );

      data.fold((failure) {
        _mapFailureToState(emit, failure);
      },
          (_) => emit(state.copyWith(
                providerOnlineState: ProviderOnlineState.successful,
                isOnline: !state.isOnline,
              )));
    });
  }

  _mapFailureToState(emit, Failure f) {
    switch (f.runtimeType) {
      case OfflineFailure:
        emit(state.copyWith(providerOnlineState: ProviderOnlineState.init));
        break;

      case NetworkErrorFailure:
        emit(state.copyWith(providerOnlineState: ProviderOnlineState.error));
        break;

      default:
        emit(state.copyWith(providerOnlineState: ProviderOnlineState.error));
        break;
    }
  }
}
