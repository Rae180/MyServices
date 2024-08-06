part of 'provider_like_bloc.dart';

class ProviderLikeState {}

final class ProviderLikeInitial extends ProviderLikeState {}

final class ProviderLiking extends ProviderLikeState {}

final class ProviderLiked extends ProviderLikeState {
  final String message;

  ProviderLiked({required this.message});
}

class ProviderUnliked extends ProviderLikeState {
  final String message;

  ProviderUnliked({required this.message});
}

final class ProviderErrorLike extends ProviderLikeState {
  final String messege;

  ProviderErrorLike({required this.messege});
}

class FavoriteProvidersLoaded extends ProviderLikeState {
  final List<FavoriteProvideres> favoriteProvider;

  FavoriteProvidersLoaded({required this.favoriteProvider});
}
