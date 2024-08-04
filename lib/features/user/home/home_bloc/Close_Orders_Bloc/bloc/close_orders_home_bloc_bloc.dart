import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:start/core/api_service/base_Api_service.dart';
import 'package:start/core/api_service/base_repo.dart';
import 'package:start/core/constants/api_constants.dart';
import 'package:start/features/user/Orders/model/Details_For_Order.dart';

part 'close_orders_home_bloc_event.dart';
part 'close_orders_home_bloc_state.dart';

class CloseOrdersHomeBlocBloc
    extends Bloc<CloseOrdersHomeBlocEvent, CloseOrdersHomeBlocState> {
  final BaseApiService client;

  CloseOrdersHomeBlocBloc({required this.client})
      : super(PendingAndInprogressOrdersHomeBlocInitial()) {
    on<FetchPendingAndInprogressOrders>((event, emit) async {
      emit(PendingAndInprogressOrdersHomeLoadingOrdersState());
      try {
        final pendingOrders = await BaseRepo.repoRequest(request: () async {
          var response = await client.getRequestAuth(
              url: '${ApiConstants.GetOrderDetails}/pending');
          List<DetailsForOrder> orders = [];
          response['data'].forEach((element) {
            orders.add(DetailsForOrder.fromJson(element));
          });
          return orders;
        });

        final inProgressOrders = await BaseRepo.repoRequest(request: () async {
          var response = await client.getRequestAuth(
              url: '${ApiConstants.GetOrderDetails}/in progress');
          List<DetailsForOrder> ordersA = [];
          response['data'].forEach((element) {
            ordersA.add(DetailsForOrder.fromJson(element));
          });
          return ordersA;
        });

        // bool hasInPending = false;
        // print('the 1 list is : ${pendingOrders}');
        // if (pendingOrders != null) {
        //   print('isPeding is true');
        //   hasInPending = true;
        // }

        // bool hasInProgress = false;
        //  print('the 2 list is : ${inProgressOrders}');
        // if (inProgressOrders != null) {
        //   print('is inProgrss true');
        //   hasInProgress = true;
        // }
        bool hasInPending = false;
        bool hasInProgress = false;

        pendingOrders.fold(
          (failure) => print('Failed to fetch pending orders: $failure'),
          (pendingOrders) {
            if (pendingOrders != null && pendingOrders.isNotEmpty) {
              print('true1');
              hasInPending = true;
            }
          },
        );

        inProgressOrders.fold(
          (failure) => print('Failed to fetch in-progress orders: $failure'),
          (inProgressOrders) {
            if (inProgressOrders != null && inProgressOrders.isNotEmpty) {
              print('true2');
              hasInProgress = true;
            }
          },
        );
        print(hasInProgress);
        print(hasInPending);
        emit(PendingAndInprogressOrdersHomeLoadedState(
          isInPending: hasInPending,
          isInProgress: hasInProgress,
        ));
      } catch (e) {
        emit(ErrorGetDetails(message: e.toString()));
      }
    });
  }
}
