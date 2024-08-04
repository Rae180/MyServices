import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:start/core/api_service/base_Api_service.dart';
import 'package:start/core/api_service/base_repo.dart';
import 'package:start/core/constants/api_constants.dart';
import 'package:start/core/errors/failures.dart';
import 'package:start/features/provider/order/model/details_order_provider.dart';

part 'managecurrentorder_event.dart';
part 'managecurrentorder_state.dart';

class ManagecurrentorderBloc
    extends Bloc<ManagecurrentorderEvent, ManagecurrentorderState> {
  final BaseApiService client;

  ManagecurrentorderBloc({required this.client})
      : super(ManagecurrentorderInitial()) {
    on<ArriveorderEvent>((event, emit) async {
      emit(LoadingState());
      final data = await BaseRepo.repoRequest(
        request: () async {
          await client.postRequestAuth(
              url: "${ApiConstants.arriveorder}${event.id}", jsonBody: {});
        },
      );

      data.fold((f) {
        emit(_mapFailureToState(f));
      }, (d) {
        emit(DonemanageState());
      });
    });
    on<StartWorkorderEvent>((event, emit) async {
      emit(LoadingState());
      final data = await BaseRepo.repoRequest(
        request: () async {
          await client.postRequestAuth(
              url: "${ApiConstants.startWork}${event.id}", jsonBody: {});
        },
      );

      data.fold((f) {
        emit(_mapFailureToState(f));
      }, (d) {
        emit(DonemanageState());
      });
    });
    on<PaidEvent>((event, emit) async {
      emit(LoadingState());
      final data = await BaseRepo.repoRequest(
        request: () async {
          await client.postRequestAuth(
              url: "${ApiConstants.paid}${event.id}", jsonBody: {});
        },
      );

      data.fold((f) {
        emit(_mapFailureToState(f));
      }, (d) {
        emit(DonemanageState());
      });
    });
    on<AdditemEvent>((event, emit) async {
      emit(LoadingState());
      final data = await BaseRepo.repoRequest(
        request: () async {
          print(event.items.length);
          await client.postRequestAuth(
              url: "${ApiConstants.additem}${event.id}",
              jsonBody: {
                "items": [
                  for (Item e in event.items) e.toJson()
                ]
              });
        },
      );

      data.fold((f) {
        emit(_mapFailureToState(f));
      }, (d) {
        emit(DonemanageState());
      });
    });
    on<PauseWorkorderEvent>((event, emit) async {
      emit(LoadingState2());
      final data = await BaseRepo.repoRequest(
        request: () async {
          await client.postRequestAuth(
              url: "${ApiConstants.pausework}${event.id}", jsonBody: {});
        },
      );

      data.fold((f) {
        emit(_mapFailureToState(f));
      }, (d) {
        emit(DonemanageState());
      });
    });
    on<ResumeWorkorderEvent>((event, emit) async {
      emit(LoadingState());
      final data = await BaseRepo.repoRequest(
        request: () async {
          await client.postRequestAuth(
              url: "${ApiConstants.resumework}${event.id}", jsonBody: {});
        },
      );

      data.fold((f) {
        emit(_mapFailureToState(f));
      }, (d) {
        emit(DonemanageState());
      });
    });
    on<EndWorkorderEvent>((event, emit) async {
      emit(LoadingState());
      final data = await BaseRepo.repoRequest(
        request: () async {
          await client.postRequestAuth(
              url: "${ApiConstants.endwork}${event.id}", jsonBody: {});
        },
      );

      data.fold((f) {
        emit(_mapFailureToState(f));
      }, (d) {
        emit(DonemanageState());
      });
    });
    on<postpomentorderEvent>((event, emit) async {
      emit(LoadingState2());
      final data = await BaseRepo.repoRequest(
        request: () async {
          await client.postRequestAuth(
              url: "${ApiConstants.postpomentorder}${event.id}",
              jsonBody: {"Postponement_date": event.dateTime.toString()});
        },
      );

      data.fold((f) {
        emit(_mapFailureToState(f));
      }, (d) {
        emit(DonemanageState());
      });
    });
  }
  _mapFailureToState(Failure f) {
    switch (f.runtimeType) {
      case OfflineFailure:
        return ErrormanageState(error: 'No internet');

      case NetworkErrorFailure:
        return ErrormanageState(
          error: (f as NetworkErrorFailure).message,
        );

      default:
        return ErrormanageState(
          error: 'Error',
        );
    }
  }
}
