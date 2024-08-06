import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:start/core/api_service/network_api_service_http.dart';
import 'package:start/core/ui/loading_widget.dart';
import 'package:start/features/user/Favorites/Favorites_bloc/bloc/favorites_bloc.dart';
import 'package:start/features/user/Favorites/view/widgets/Favorite_Tile.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          FavoritesBloc(client: NetworkApiServiceHttp())..add(GetFavorites()),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(
              Icons.arrow_back_ios_new_outlined,
            ),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Text(AppLocalizations.of(context)!.favorites),
        ),
        body: BlocBuilder<FavoritesBloc, FavoritesState>(
          builder: (context, state) {
            if (state is FavoritesLoading) {
              return const Center(child: LoadingWidget());
            } else if (state is FavoritesLoaded) {
              if (state.favoriteproviders.isEmpty) {
                return Center(child: Text('No favorites found.'));
              }
              return ListView.builder(
                itemBuilder: (context, index) {
                  bool isLiked = state.favoriteproviders.any((fav) =>
                      fav.providerId ==
                      state.favoriteproviders[index].providerId);
                  return FavoriteTile(
                    status: state.favoriteproviders[index].status!,
                    hourleyrate: state.favoriteproviders[index].hourlyRate,
                    image: state.favoriteproviders[index].providerImage,
                    name: state.favoriteproviders[index].providerFirstName!,
                    providerId: state.favoriteproviders[index].providerId,
                    isLiked: isLiked,
                    onLike: () {
                      context.read<FavoritesBloc>().add(LikingProvider(
                          state.favoriteproviders[index].providerId!));
                    },
                    onUnlike: () {
                      context.read<FavoritesBloc>().add(UnLikingProvider(
                          state.favoriteproviders[index].providerId!));
                    },
                  );
                },
                itemCount: state.favoriteproviders.length,
              );
            } else if (state is ErrorFavorites) {
              return Center(child: Text(state.message));
            } else {
              return Center(child: Text('No favorites found.'));
            }
          },
        ),
      ),
    );
  }
}
