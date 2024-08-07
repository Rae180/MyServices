import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:start/core/api_service/base_Api_service.dart';
import 'package:start/core/api_service/base_repo.dart';
import 'package:start/core/constants/api_constants.dart';
import 'package:start/core/errors/failures.dart';
import 'package:start/features/user/Providers/model/Provider_Details.dart';
import 'package:start/features/user/Providers/model/favorite_provider.dart';

part 'favorites_event.dart';
part 'favorites_state.dart';

class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  final BaseApiService client;

  FavoritesBloc({required this.client}) : super(FavoritesInitial()) {
    on<GetFavorites>((event, emit) async {
      emit(FavoritesLoading());
      final data = await BaseRepo.repoRequest(request: () async {
        var data = await client.getRequestAuth(url: ApiConstants.faves);
        return (data['data'] as List)
            .map((provider) => FavoriteProvideres.fromJson(provider))
            .toList();
      });
      data.fold((f) {
        emit(_mapFailureToState(f));
      }, (data) {
        emit(FavoritesLoaded(favoriteproviders: data));
      });
    });

    on<LikingProvider>((event, emit) async {
      emit(FavoritesLoading());
      final data = await BaseRepo.repoRequest(request: () async {
        var response = await client.postRequestAuth(
            jsonBody: {}, url: '${ApiConstants.like}${event.providerId}');
        return FavoriteProvideres.fromJson(response['data']);
      });
      data.fold((f) {
        emit(_mapFailureToState(f));
      }, (provider) async {
        emit(FavoritingProvider(favProvider: provider));
        // Fetch updated favorites list
        final updatedFavorites =
            await client.getRequestAuth(url: ApiConstants.faves);
        emit(FavoritesLoaded(
            favoriteproviders: (updatedFavorites['data'] as List)
                .map((provider) => FavoriteProvideres.fromJson(provider))
                .toList()));
      });
    });

    on<UnLikingProvider>((event, emit) async {
      emit(FavoritesLoading());
      print('Unliking provider with ID: ${event.providerId}');
      final data = await BaseRepo.repoRequest(request: () async {
        var response = await client.delete(
            url: '${ApiConstants.like}${event.providerId}');
        print('API response: $response');
        return FavoriteProvideres.fromJson(response['data']);
      });
      data.fold((f) {
        emit(_mapFailureToState(f));
      }, (provider) async {
        emit(UnFavoriteProvider(favProvider: provider));
        // Fetch updated favorites list
        final updatedFavorites =
            await client.getRequestAuth(url: ApiConstants.faves);
        emit(FavoritesLoaded(
            favoriteproviders: (updatedFavorites['data'] as List)
                .map((provider) => FavoriteProvideres.fromJson(provider))
                .toList()));
      });
    });
  }

  FavoritesState _mapFailureToState(Failure f) {
    switch (f.runtimeType) {
      case OfflineFailure:
        return ErrorFavorites(message: 'No internet');
      case NetworkErrorFailure:
        return ErrorFavorites(
          message: (f as NetworkErrorFailure).message,
        );
      default:
        return ErrorFavorites(message: 'Unexpected error');
    }
  }
}
