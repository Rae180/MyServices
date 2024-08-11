import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:start/core/api_service/base_Api_service.dart';
import 'package:start/core/api_service/base_repo.dart';
import 'package:start/core/constants/api_constants.dart';
import 'package:start/core/errors/failures.dart';
import 'package:start/features/user/home/model/Search_Results_model.dart';

part 'search_screen_event.dart';
part 'search_screen_state.dart';

class SearchScreenBloc extends Bloc<SearchScreenEvent, SearchScreenState> {
  final BaseApiService client;

  SearchScreenBloc({required this.client}) : super(SearchScreenInitial()) {
    on<SearchTextChanged>((event, emit) async {
      if (event.query.isEmpty) {
        emit(SearchScreenInitial());
        return;
      }
      emit(SearchScreenLoading());
      final data = await BaseRepo.repoRequest(request: () async {
        var response = await client.getRequest2(
          url: ApiConstants.searchquery,
          parameters: {'value': event.query},
        );
        List<SearchResults> results = [];
        response['data'].forEach((element) {
          results.add(SearchResults.fromJson(element));
        });
        return results;
      });
      data.fold((f) {
        emit(_mapFailureToState(f));
      }, (data) {
        emit(SearchScreenLoaded(results: data));
      });
    });
  }

  SearchScreenState _mapFailureToState(Failure f) {
    switch (f.runtimeType) {
      case OfflineFailure:
        return SearchError(message: 'No internet');

      case NetworkErrorFailure:
        return SearchError(
          message: (f as NetworkErrorFailure).message,
        );

      default:
        return SearchError(
          message: 'Error',
        );
    }
  }
}
