part of 'provider_like_bloc.dart';

class ProviderLikeEvent {}

class LikeProvider extends ProviderLikeEvent {
  final int? providerId;

  LikeProvider({required this.providerId});
}

class UnlikeProvider extends ProviderLikeEvent {
  final int? providerId;

  UnlikeProvider({required this.providerId});
}

class FetchFavoriteProviders extends ProviderLikeEvent {}
