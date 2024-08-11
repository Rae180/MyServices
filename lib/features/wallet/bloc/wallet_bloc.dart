import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:start/core/api_service/base_Api_service.dart';
import 'package:start/core/api_service/base_repo.dart';
import 'package:start/core/constants/api_constants.dart';
import 'package:start/core/errors/failures.dart';
import 'package:start/features/notification/model/notification_model.dart';
import 'package:start/features/wallet/model/wallet_model.dart';

part 'wallet_event.dart';
part 'wallet_state.dart';

class WalletBloc extends Bloc<WalletEvent, WalletState> {
  final BaseApiService client;

  WalletBloc({required this.client}) : super(WalletInitial()) {
    on<GetWalletEvent>((event, emit) async {
      emit(LoadingState());
      final data = await BaseRepo.repoRequest(
        request: () async {
          var data = await client.getRequestAuth(
            url: ApiConstants.alltransactions,
          );
          
         
          return WalletModel.fromJson(data);
        },
      );

      data.fold((f) {
        emit(_mapFailureToState(f));
      }, (data) {
        emit(SuccessLoadedWallet(data: data));
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
