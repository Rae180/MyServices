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

enum ProviderStatus {
  online,
  highest_rated,
  the_closest,
}

String getStatusStringForChips(ProviderStatus state, BuildContext context) {
  switch (state) {
    case ProviderStatus.online:
      return AppLocalizations.of(context)!.onlineState;
    case ProviderStatus.highest_rated:
      return AppLocalizations.of(context)!.highestRate;
    case ProviderStatus.the_closest:
      return AppLocalizations.of(context)!.closest;
    default:
      return '';
  }
}

String getStatusString(ProviderStatus state) {
  switch (state) {
    case ProviderStatus.online:
      return 'online';
    case ProviderStatus.highest_rated:
      return 'highest_rated';
    case ProviderStatus.the_closest:
      return 'the_closest';
    default:
      return '';
  }
}

final class SuccessOrderType extends ProviderServiceState {
  final ProviderStatus selectedOrderType;

  SuccessOrderType({required this.selectedOrderType});
}

final class ErrorGetOrderType extends ProviderServiceState {
  final String message;

  ErrorGetOrderType({required this.message});
}
