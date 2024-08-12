import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:start/core/api_service/network_api_service_http.dart';
import 'package:start/features/user/home/home_bloc/Search_bloc/bloc/search_screen_bloc.dart';
import 'package:start/features/user/home/view/widgets/Search_Result_Tile.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SearchScreen extends StatelessWidget {
  static const String routeName = 'Search_Screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.search),
      ),
      body: BlocProvider(
        create: (context) => SearchScreenBloc(client: NetworkApiServiceHttp()),
        child: SearchForm(),
      ),
    );
  }
}

class SearchForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: TextFormField(
            decoration: InputDecoration(
              labelText: AppLocalizations.of(context)!.search,
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.search),
            ),
            onChanged: (query) {
              context
                  .read<SearchScreenBloc>()
                  .add(SearchTextChanged(query: query));
            },
          ),
        ),
        Expanded(
          child: BlocBuilder<SearchScreenBloc, SearchScreenState>(
            builder: (context, state) {
              if (state is SearchScreenLoading) {
                return Center(child: CircularProgressIndicator());
              } else if (state is SearchScreenLoaded) {
                return ListView.builder(
                  itemCount: state.results.length,
                  itemBuilder: (context, index) {
                    final result = state.results[index];
                    return SearchResultTile(
                      id: result.providerId!,
                      firstName: result.firstName!,
                      lastName: result.lastName!,
                      status: result.status!,
                      hourlyRate: result.hourlyRate!,
                      service: result.service!,
                      imageUrl: result.image!,
                      averageRating: result.averageRating!,
                    );
                  },
                );
              } else if (state is SearchError) {
                return Center(child: Text(state.message));
              }
              return Container();
            },
          ),
        ),
      ],
    );
  }
}
