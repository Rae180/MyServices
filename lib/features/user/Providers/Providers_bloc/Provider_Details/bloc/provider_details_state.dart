part of 'provider_details_bloc.dart';

class ProviderDetailsState {}

class ProviderDetailsInitial extends ProviderDetailsState {}

class ProviderDetailsLoading extends ProviderDetailsState {}

class ProviderDetailsLoaded extends ProviderDetailsState {
  final ProviderDetails providerDetails;

  ProviderDetailsLoaded({required this.providerDetails});
}

class ProviderDetailsError extends ProviderDetailsState {
  final String message;

  ProviderDetailsError({required this.message});
}
