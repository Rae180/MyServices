import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:start/core/api_service/base_Api_service.dart';
import 'package:start/core/api_service/base_repo.dart';
import 'package:start/core/constants/api_constants.dart';
import 'package:start/core/errors/failures.dart';

part 'adding_new_suggest_event.dart';
part 'adding_new_suggest_state.dart';

class AddingNewSuggestBloc
    extends Bloc<AddingNewSuggestEvent, AddingNewSuggestState> {
  final BaseApiService client;
  AddingNewSuggestBloc({required this.client})
      : super(AddingNewSuggestInitial()) {
    on<AddingNewSugestSend>((event, emit) async {
      emit(AddingnewSuggestLoading());
      final data = await BaseRepo.repoRequest(request: () async {
        final data = await client.postRequestAuth(
          url: ApiConstants.addSugest,
          jsonBody: {
            "suggest": event.suggest,
          },
        );
        return data;
      });
      data.fold((f) {
        emit(_mapFailureToState(f));
      }, (data) {
        emit(AddingnewSuggestSuccess());
      });
    });
  }
  _mapFailureToState(Failure f) {
    switch (f.runtimeType) {
      case OfflineFailure:
        return AddingNewSuggestError(message: 'No internet');

      case NetworkErrorFailure:
        return AddingNewSuggestError(
          message: (f as NetworkErrorFailure).message,
        );

      default:
        return AddingNewSuggestError(
          message: 'Error',
        );
    }
  }
}
