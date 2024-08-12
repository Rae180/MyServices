import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:start/core/api_service/base_Api_service.dart';
import 'package:start/core/api_service/base_repo.dart';
import 'package:start/core/constants/api_constants.dart';
import 'package:start/core/errors/failures.dart';
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
      final url = _buildFilterUrl(event.orderType);
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

String _buildFilterUrl(ProviderStatus status) {
  final baseUrl = 'http://127.0.0.1:8000/api/filter';
  final params = {
    'online': status == ProviderStatus.online ? 'true' : 'false',
    'highest_rated': status == ProviderStatus.highest_rated ? 'true' : 'false',
    'the_closest': status == ProviderStatus.the_closest ? 'true' : 'false',
    'latitude': '40.7570',
    'longitude': '-73.9755',
  };
  final queryString =
      params.entries.map((e) => '${e.key}=${e.value}').join('&');
  return '$baseUrl?$queryString';
}
