import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:start/core/api_service/base_Api_service.dart';
import 'package:start/core/api_service/base_repo.dart';
import 'package:start/core/constants/api_constants.dart';
import 'package:start/core/errors/failures.dart';
import 'package:start/features/notification/model/notification_model.dart';

part 'notification_event.dart';
part 'notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  final BaseApiService client;

  NotificationBloc({required this.client}) : super(NotificationInitial()) {
    on<GetNotificationEvent>((event, emit) async {
      emit(LoadingState());
      final data = await BaseRepo.repoRequest(
        request: () async {
          var data = await client.getRequestAuth(
            url: ApiConstants.notifications,
          );
          List<NotifictionModel> notificatos = [];
          data['data'].forEach(
              (element) => notificatos.add(NotifictionModel.fromJson(element)));
          return notificatos;
        },
      );

      data.fold((f) {
        emit(_mapFailureToState(f));
      }, (data) {
        emit(SuccessLoadednotifications(data: data));
      });
    });
  }
  _mapFailureToState(Failure f) {
    switch (f.runtimeType) {
      case OfflineFailure:
        return ErrorState(error: 'No internet');

      case NetworkErrorFailure:
        return ErrorState(
          error: (f as NetworkErrorFailure).message,
        );

      default:
        return ErrorState(
          error: 'Error',
        );
    }
  }
}
