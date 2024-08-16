part of 'close_orders_home_bloc_bloc.dart';

class CloseOrdersHomeBlocState {
  const CloseOrdersHomeBlocState();

  @override
  List<Object> get props => [];
}

final class PendingAndInprogressOrdersHomeBlocInitial
    extends CloseOrdersHomeBlocState {}

final class PendingAndInprogressOrdersHomeLoadingOrdersState
    extends CloseOrdersHomeBlocState {}

final class PendingAndInprogressOrdersHomeLoadedState
    extends CloseOrdersHomeBlocState {
  final bool isInPending;
  final bool isInProgress;

  PendingAndInprogressOrdersHomeLoadedState({required this.isInPending, required this.isInProgress});
  // CloseOrdersHomeLoadedState({required this.closers});
}

final class ErrorGetDetails extends CloseOrdersHomeBlocState {
  final String message;

  ErrorGetDetails({required this.message});
}
