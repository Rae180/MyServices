part of 'close_orders_home_bloc_bloc.dart';

class CloseOrdersHomeBlocState {
  const CloseOrdersHomeBlocState();

  @override
  List<Object> get props => [];
}

final class CloseOrdersHomeBlocInitial extends CloseOrdersHomeBlocState {}

final class CloseOrdersHomeLoadingOrdersState
    extends CloseOrdersHomeBlocState {}

final class CloseOrdersHomeLoadedState extends CloseOrdersHomeBlocState {
  // final List<ClosedOrderHomeModel> closers;

  // CloseOrdersHomeLoadedState({required this.closers});
}

final class ErrorGetDetails extends CloseOrdersHomeBlocState {
  final String message;

  ErrorGetDetails({required this.message});
}
