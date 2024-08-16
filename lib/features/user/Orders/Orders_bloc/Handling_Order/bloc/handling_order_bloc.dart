// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'package:start/core/api_service/base_Api_service.dart';
import 'package:start/core/api_service/base_repo.dart';
import 'package:start/core/constants/api_constants.dart';
import 'package:start/core/errors/failures.dart';
import 'package:start/features/user/Orders/model/Details_For_Order.dart';

part 'handling_order_event.dart';
part 'handling_order_state.dart';

class HandlingOrderBloc extends Bloc<HandlingOrderEvent, HandlingOrderState> {
  final BaseApiService client;

  HandlingOrderBloc(
    this.client,
  ) : super(HandlingOrderInitial()) {
    on<CancelOrderRequested>((event, emit) async {
      emit(CancelingOrder());
      try {
        final response = await client.postRequestAuth(
          url: '${ApiConstants.CancelOrder}${event.orderId}',
          jsonBody: {},
        );
        if (response['success']) {
          emit(CanceledOrderSuccesfully());
        } else {
          emit(OrderCancellationFailure('Failed to cancel order.'));
        }
      } catch (e) {
        emit(OrderCancellationFailure('An error occurred: $e'));
      }
    });

    on<FetchOrderDetailsById>(((event, emit) async {
      emit(GettingDetailsById());

      final respnse = await BaseRepo.repoRequest(request: () async {
        var data = await client.getRequestAuth(
            url: '${ApiConstants.getdetailsorder}${event.orderId}');

        DetailsForOrder orderr = DetailsForOrder.fromJson(data['data']);
        return orderr;
        // List<DetailsForOrder> orderr = [];
        // data['data'].forEach(
        //     ((element) => orderr.add(DetailsForOrder.fromJson(element))));
        // return orderr;
      });
      respnse.fold((f) {
        emit(_mapFailureToState(f));
      }, (orderr) {
        emit(SuccessGettingOrderDetailsById(orderr));
      });
    }));
  }

  _mapFailureToState(Failure f) {
    switch (f.runtimeType) {
      case OfflineFailure:
        return ErrorGettingDetailsOrderDetailsById('No internet');

      case NetworkErrorFailure:
        return ErrorGettingDetailsOrderDetailsById(
          (f as NetworkErrorFailure).message,
        );

      default:
        return ErrorGettingDetailsOrderDetailsById(
          'Error',
        );
    }
  }
}
