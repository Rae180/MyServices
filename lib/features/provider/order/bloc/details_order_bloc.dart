import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:start/core/api_service/base_Api_service.dart';
import 'package:start/core/api_service/base_repo.dart';
import 'package:start/core/constants/api_constants.dart';
import 'package:start/core/errors/failures.dart';
import 'package:start/features/provider/order/model/details_order_provider.dart';

part 'details_order_event.dart';
part 'details_order_state.dart';

class DetailsOrderBloc extends Bloc<DetailsOrderEvent, DetailsOrderState> {
  final BaseApiService client;
  DetailsOrderBloc({required this.client}) : super(DetailsOrderInitial()) {
    on<GetDetailsOrderEvent>((event, emit) async {
      emit(LoadingDetailsOrderState());
      final data = await BaseRepo.repoRequest(
        request: () async {
          var data = await client.getRequestAuth(url: "${ApiConstants.getdetailsorder}${event.id}");
          DetailsOrderProvider details =
              DetailsOrderProvider.fromJson(data['data']);
          return details;
        },
      );

      data.fold((f) {
        emit(_mapFailureToState(f));
      }, (data) {
        emit(LoadedDetailsOrderState(data: data));
      });
    });
  }
  _mapFailureToState(Failure f) {
    switch (f.runtimeType) {
      case OfflineFailure:
        return ErrorGetDetailsOrderState(message: 'No internet');

      case NetworkErrorFailure:
        return ErrorGetDetailsOrderState(
          message: (f as NetworkErrorFailure).message,
        );

      default:
        return ErrorGetDetailsOrderState(
          message: 'Error',
        );
    }
  }
}
