import 'package:bloc/bloc.dart';
import 'package:start/core/api_service/base_Api_service.dart';
import 'package:start/core/api_service/base_repo.dart';
import 'package:start/core/constants/api_constants.dart';
import 'package:start/core/errors/failures.dart';
import 'package:start/features/home/model/service_model.dart';

part 'service_event.dart';
part 'service_state.dart';

class ServiceBloc extends Bloc<ServiceEvent, ServiceState> {
  final BaseApiService client;
  ServiceBloc({required this.client}) : super(ServiceInitial()) {
    on<GetServices>((event, emit) async {
      emit(LoadingServices());
      final data = await BaseRepo.repoRequest(
        request: () async {
          var data = await client.getRequest(
              url: '${ApiConstants.getServices}${event.id}');
          List<ServiceModel> categories = [];
          data['data'].forEach(
              (element) => categories.add(ServiceModel.fromJson(element)));
          return categories;
        },
      );

      data.fold((f) {
        emit(_mapFailureToState(f));
      }, (data) {
        emit(LoadedServices(services: data));
      });
    });
  }
  _mapFailureToState(Failure f) {
    switch (f.runtimeType) {
      case OfflineFailure:
        return ErrorGetServices(message: 'No internet');

      case NetworkErrorFailure:
        return ErrorGetServices(
          message: (f as NetworkErrorFailure).message,
        );

      default:
        return ErrorGetServices(
          message: 'Error',
        );
    }
  }
}
