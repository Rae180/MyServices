import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:start/core/api_service/base_Api_service.dart';
import 'package:start/core/api_service/base_repo.dart';
import 'package:start/core/constants/api_constants.dart';
import 'package:start/core/errors/failures.dart';
import 'package:start/features/user/Orders/model/Details_For_Order.dart';

part 'deatils_for_order_event.dart';
part 'deatils_for_order_state.dart';

class DeatilsForOrderBloc
    extends Bloc<DetailsForOrderEvent, DeatilsForOrderState> {
  final BaseApiService client;
  DeatilsForOrderBloc({required this.client})
      : super(DeatilsForOrderInitial()) {
    on<FilterOrdersByStatus>(((event, emit) async {
      emit(DeatilsForOrderLoading());
      final data = await BaseRepo.repoRequest(request: () async {
        var data = await client.getRequestAuth(
          url: '${ApiConstants.GetOrderDetails}/${getStatusString(event.status)}',
        );
        List<DetailsForOrder> detailes = [];
        data['data'].forEach(
            (element) => detailes.add(DetailsForOrder.fromJson(element)));

        return detailes;
      });

      data.fold((f) {
        print('first');
        print(data);
        emit(_mapFailureToState(f));
      }, (data) {
        print('second');
        if (data.isEmpty) {
          emit(DeatilsForOrderEmpty());
        } else {
          emit(DeatilsForOrderLoaded(orders: data,selectedFilter: event.status));
        }
      });
    }));
  }
  _mapFailureToState(Failure f) {
    switch (f.runtimeType) {
      case OfflineFailure:
        return DetailsForOrderError(message: 'No internet');

      case NetworkErrorFailure:
        return DetailsForOrderError(
          message: (f as NetworkErrorFailure).message,
        );

      default:
        return DetailsForOrderError(
          message: 'Error',
        );
    }
  }
}