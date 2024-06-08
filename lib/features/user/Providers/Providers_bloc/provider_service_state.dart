part of 'provider_service_bloc.dart';

@immutable
sealed class ProviderServiceState {}

final class ProviderServiceInitial extends ProviderServiceState {}

final class LoadedProvidersService extends ProviderServiceState {
  final List<ProviderService> providers;

  LoadedProvidersService({required this.providers});
}

final class LoadingProvidersService extends ProviderServiceState {}

final class ErrorGetProvidersService extends ProviderServiceState {
  final String messsage;

  ErrorGetProvidersService({required this.messsage});
}
