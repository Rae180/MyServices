// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'package:start/core/api_service/base_Api_service.dart';
import 'package:start/core/api_service/base_repo.dart';
import 'package:start/core/constants/api_constants.dart';
import 'package:start/core/errors/failures.dart';
import 'package:start/features/user/Providers/model/Provider_Details.dart';
import 'package:start/features/user/Providers/model/favorite_provider.dart';

part 'provider_like_event.dart';
part 'provider_like_state.dart';

class ProviderLikeBloc extends Bloc<ProviderLikeEvent, ProviderLikeState> {
  final BaseApiService client;
  final List<FavoriteProvideres> likedProviders = [];

  ProviderLikeBloc({
    required this.client,
  }) : super(ProviderLikeInitial()) {
    on<LikeProvider>((event, emit) async {
      final data = await BaseRepo.repoRequest(request: () async {
        var response = await client.postRequestAuth(
          url: '${ApiConstants.like}${event.providerId}',
          jsonBody: {},
        );
        return response['message'];
      });
      data.fold((f) {
        emit(_mapFailureToState(f));
      }, (message) {
        likedProviders.add(FavoriteProvideres(providerId: event.providerId));
        emit(
          ProviderLiked(message: message),
        );
        emit(FavoriteProvidersLoaded(favoriteProvider: likedProviders));
      });
    });

    on<UnlikeProvider>((event, emit) async {
      emit(ProviderLiking());
      final data = await BaseRepo.repoRequest(request: () async {
        var response = await client.delete(
          url: '${ApiConstants.like}${event.providerId}',
        );
        return response['message'];
        //   return {'message': 'Removed from your favorites successfully!'};
      });
      data.fold((f) {
        emit(_mapFailureToState(f));
      }, (message) {
        likedProviders
            .removeWhere((provider) => provider.providerId == event.providerId);
        emit(FavoriteProvidersLoaded(favoriteProvider: likedProviders));
        emit(ProviderUnliked(message: message));
      });
    });

    on<FetchFavoriteProviders>((event, emit) async {
      emit(ProviderLiking());
      final data = await BaseRepo.repoRequest(request: () async {
        final response = await client.getRequestAuth(url: ApiConstants.faves);
        return response['data']; // Return the list directly
      });
      data.fold((f) {
        emit(_mapFailureToState(f));
      }, (favorites) {
        List<FavoriteProvideres> favoriteProviders = (favorites as List)
            .map((provider) => FavoriteProvideres.fromJson(provider))
            .toList();
        likedProviders.clear();
        likedProviders.addAll(favoriteProviders);
        emit(FavoriteProvidersLoaded(favoriteProvider: favoriteProviders));
      });
    });
  }

  _mapFailureToState(Failure f) {
    switch (f.runtimeType) {
      case OfflineFailure:
        return ProviderErrorLike(messege: 'No internet');

      case NetworkErrorFailure:
        return ProviderErrorLike(
          messege: (f as NetworkErrorFailure).message,
        );

      default:
        return ProviderErrorLike(
          messege: 'Error',
        );
    }
  }
}
