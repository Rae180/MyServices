import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:start/core/api_service/base_Api_service.dart';
import 'package:start/core/api_service/base_repo.dart';
import 'package:start/core/constants/api_constants.dart';
import 'package:start/core/errors/failures.dart';

part 'mangeorder_event.dart';
part 'mangeorder_state.dart';

class MangeorderBloc extends Bloc<MangeorderEvent, MangeorderState> {
  final BaseApiService client;
  MangeorderBloc({required this.client}) : super(MangeorderInitial()) {
    on<AcceptorderEvent>((event, emit) async {
      emit(LoadingState());
      final data = await BaseRepo.repoRequest(
        request: () async {
          await client.postRequestAuth(
              url: "${ApiConstants.acceptorder}${event.id}", jsonBody: {});
        },
      );

      data.fold((f) {
        emit(_mapFailureToState(f));
      }, (d) {
        emit(DonemanageState());
      });
    });
    on<RejectorderEvent>((event, emit) async {
      emit(LoadingState());
      final data = await BaseRepo.repoRequest(
        request: () async {
          await client.postRequestAuth(
              url: "${ApiConstants.rejectorder}${event.id}", jsonBody: {});
        },
      );

      data.fold((f) {
        emit(_mapFailureToState(f));
      }, (d) {
        emit(DonemanageState());
      });
    });
    on<AcceptrescheduleorderEvent>((event, emit) async {
      emit(LoadingState());
      final data = await BaseRepo.repoRequest(
        request: () async {
          await client.postRequestAuth(
              url: "${ApiConstants.acceptrescgeduleorder}${event.id}",
              jsonBody: {});
        },
      );

      data.fold((f) {
        emit(_mapFailureToState(f));
      }, (d) {
        emit(DonemanageState());
      });
    });
    on<RejectrescheduleorderEvent>((event, emit) async {
      emit(LoadingState());
      final data = await BaseRepo.repoRequest(
        request: () async {
          await client.postRequestAuth(
              url: "${ApiConstants.rejectorder}${event.id}", jsonBody: {});
        },
      );

      data.fold((f) {
        emit(_mapFailureToState(f));
      }, (d) {
        emit(DonemanageState());
      });
    });
    on<RescheduleorderEvent>((event, emit) async {
      emit(LoadingState());
      final data = await BaseRepo.repoRequest(
        request: () async {
          await client.postRequestAuth(
              url: "${ApiConstants.rescheduleorder}${event.id}",
              jsonBody: {"new_schedule_date": event.dateTime.toString()});
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
