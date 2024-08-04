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

final class GettingOrderType extends ProviderServiceState {}

enum ordersState {
  instant,
  schedule,
  online,
  ratings,
  nearby,
}

final class SuccessOrderType extends ProviderServiceState {
  final ordersState selectedOrderType;

  SuccessOrderType({required this.selectedOrderType});
}

final class ErrorGetOrderType extends ProviderServiceState {
  final String message;

  ErrorGetOrderType({required this.message});
}
