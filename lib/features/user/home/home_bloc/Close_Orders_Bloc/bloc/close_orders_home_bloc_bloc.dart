// import 'package:bloc/bloc.dart';
// import 'package:meta/meta.dart';
// import 'package:start/core/api_service/base_Api_service.dart';
// import 'package:start/core/api_service/base_repo.dart';
// import 'package:start/core/constants/api_constants.dart';

// part 'close_orders_home_bloc_event.dart';
// part 'close_orders_home_bloc_state.dart';

// class CloseOrdersHomeBlocBloc
//     extends Bloc<CloseOrdersHomeBlocEvent, CloseOrdersHomeBlocState> {
//   final BaseApiService client;
//   CloseOrdersHomeBlocBloc({required this.client})
//       : super(CloseOrdersHomeBlocInitial()) {
//     on<GetCloseOrders>((event, emit) async {
//       emit(CloseOrdersHomeLoadingOrdersState());
//       final data = await BaseRepo.repoRequest(request: () async {
//         var data = await client.getRequest(url: ApiConstants.baseAppUrl);
//         List<Model> closers = [];
//         data['data'].foreach((element) => closers.add(Model.fromjson(element)));
//         return closers;
//       });
//     });
//   }
// }
