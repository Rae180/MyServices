import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:start/core/api_service/base_Api_service.dart';
import 'package:start/core/api_service/base_repo.dart';
import 'package:start/core/constants/api_constants.dart';
import 'package:start/core/errors/failures.dart';
import 'package:start/features/user/Providers/model/Provider_Details.dart';

part 'provider_details_event.dart';
part 'provider_details_state.dart';

class ProviderDetailsBloc
    extends Bloc<ProviderDetailsEvent, ProviderDetailsState> {
  final BaseApiService client;

  ProviderDetailsBloc({required this.client})
      : super(ProviderDetailsInitial()) {
    on<FetchProviderDetails>((event, emit) async {
      emit(ProviderDetailsLoading());
      final data = await BaseRepo.repoRequest(request: () async {
        var data = await client.getRequestAuth(
            url: '${ApiConstants.ProviderDetails}${event.providerId}');
        return ProviderDetails.fromJson(data['data']);
      });
      data.fold((f) {
        emit(_mapFailureToState(f));
      }, (data) {
        emit(ProviderDetailsLoaded(providerDetails: data));
      });
    });
  }

  ProviderDetailsState _mapFailureToState(Failure f) {
    switch (f.runtimeType) {
      case OfflineFailure:
        return ProviderDetailsError(message: 'No internet');
      case NetworkErrorFailure:
        return ProviderDetailsError(
          message: (f as NetworkErrorFailure).message,
        );
      default:
        return ProviderDetailsError(message: 'Unexpected error');
    }
  }
}
