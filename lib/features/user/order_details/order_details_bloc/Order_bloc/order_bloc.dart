// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'package:start/core/api_service/base_Api_service.dart';
import 'package:start/core/api_service/base_repo.dart';
import 'package:start/core/constants/api_constants.dart';
import 'package:start/core/errors/failures.dart';

part 'order_event.dart';
part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  final BaseApiService client;
  OrderBloc({
    required this.client,
  }) : super(OrderInitial()) {
    on<OrderPostEvent>((event, emit) async {
      emit(LoadingOrder());
      final data = await BaseRepo.repoRequest(request: () async {
        final data = await client.multipart2(
          url: ApiConstants.PostOrder,
          jsonBody: {
            "provider_id": event.providerId,
            if (event.type != 'instant') "schedule_date": event.dateTime,
            "notes": event.descreption,
            "longitude": event.longtitude,
            "latitude": event.latitude,
            "payment_method": event.payment,
            "address": event.adress,
            "type": event.type,
          },
          attributeName: 'images[]',
          files: event.image,
          //[event.image],
        );
        return data;
      });

      data.fold((f) {
        emit(_mapFailureToState(f));
      }, (data) {
        emit(OrderSucces());
      });
    });
  }
  _mapFailureToState(Failure f) {
    switch (f.runtimeType) {
      case OfflineFailure:
        return OrderError(message: 'No internet');

      case NetworkErrorFailure:
        return OrderError(
          message: (f as NetworkErrorFailure).message,
        );

      default:
        return OrderError(
          message: 'Error',
        );
    }
  }
}
