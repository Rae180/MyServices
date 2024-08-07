part of 'favorites_bloc.dart';

class FavoritesEvent {}

class LikingProvider extends FavoritesEvent {
  final int providerId;

  LikingProvider(this.providerId);
}

class UnLikingProvider extends FavoritesEvent {
  final int providerId;

  UnLikingProvider(this.providerId);

}

class GetFavorites extends FavoritesEvent{}
