part of 'favorites_bloc.dart';

class FavoritesState {}

final class FavoritesInitial extends FavoritesState {}

final class FavoritesLoading extends FavoritesState {}

final class FavoritesLoaded extends FavoritesState {
  final List<FavoriteProvideres> favoriteproviders;

  FavoritesLoaded({required this.favoriteproviders});
}

final class ErrorFavorites extends FavoritesState {
  final String message;

  ErrorFavorites({required this.message});
}

final class FavoritingProvider extends FavoritesState {
  final FavoriteProvideres favProvider;

  FavoritingProvider({required this.favProvider});
}

final class UnFavoriteProvider extends FavoritesState {
  final FavoriteProvideres favProvider;

  UnFavoriteProvider({required this.favProvider});
}
