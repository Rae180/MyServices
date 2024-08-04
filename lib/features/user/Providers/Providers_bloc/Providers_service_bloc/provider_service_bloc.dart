import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:start/core/api_service/base_Api_service.dart';
import 'package:start/core/api_service/base_repo.dart';
import 'package:start/core/constants/api_constants.dart';
import 'package:start/core/errors/failures.dart';
import 'package:start/features/user/Providers/model/Provider_Service.dart';
import 'package:start/features/user/home/home_bloc/service_bloc/service_bloc.dart';

part 'provider_service_event.dart';
part 'provider_service_state.dart';

class ProviderServiceBloc
    extends Bloc<ProviderServiceEvent, ProviderServiceState> {
  final BaseApiService client;
  ProviderServiceBloc({required this.client})
      : super(ProviderServiceInitial()) {
    on<GetProvoiders>((event, emit) async {
      emit(LoadingProvidersService());
      final data = await BaseRepo.repoRequest(request: () async {
        var data = await client.getRequest(
            url: '${ApiConstants.getProvidersService}${event.id}');
        List<ProviderService> providers = [];
        data['data'].forEach(
            (element) => providers.add(ProviderService.fromJson(element)));
        return providers;
      });

      data.fold((f) {
        emit(_mapFailureToState(f));
      }, (data) {
        emit(LoadedProvidersService(providers: data));
      });
    });
  }
  _mapFailureToState(Failure f) {
    switch (f.runtimeType) {
      case OfflineFailure:
        return ErrorGetProvidersService(messsage: 'No internet');

      case NetworkErrorFailure:
        return ErrorGetProvidersService(
          messsage: (f as NetworkErrorFailure).message,
        );
    }
    ;
  }
}
