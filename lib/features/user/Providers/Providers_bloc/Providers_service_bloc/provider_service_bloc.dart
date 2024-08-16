import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:start/core/api_service/base_Api_service.dart';
import 'package:start/core/api_service/base_repo.dart';
import 'package:start/core/constants/api_constants.dart';
import 'package:start/core/errors/failures.dart';
import 'package:start/core/utils/services/location_service.dart';
import 'package:start/features/user/Providers/model/Provider_Service.dart';
import 'package:start/features/user/home/home_bloc/service_bloc/service_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
        var data = await client.getRequestAuth(
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
    on<SelectOrderType>((event, emit) async {
      emit(LoadingProvidersService());
      final url = await _buildFilterUrl(event.orderType);
      final data = await BaseRepo.repoRequest(request: () async {
        var data = await client.getRequestAuth(url: url);
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

Future<String> _buildFilterUrl(Set<ProviderStatus> statuses) async {
  final baseUrl = 'http://10.0.2.2:8000/api/filter';
  final params = <String, String>{};
  GeoLoc? location = await LocationService.getLocationCoords();

  if (statuses.contains(ProviderStatus.online)) {
    params['online'] = 'true';
  }
  if (statuses.contains(ProviderStatus.highest_rated)) {
    params['highest_rated'] = 'true';
  }
  if (statuses.contains(ProviderStatus.the_closest)) {
    params['the_closest'] = 'true';
    params['latitude'] = location!.lat.toString();
    params['longitude'] = location.lng.toString();
  }

  final queryString =
      params.entries.map((e) => '${e.key}=${e.value}').join('&');
  return '$baseUrl?$queryString';
}
