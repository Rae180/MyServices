part of 'provider_details_bloc.dart';

class ProviderDetailsEvent {}

class FetchProviderDetails extends ProviderDetailsEvent {
  final int? providerId;

  FetchProviderDetails(this.providerId);
}