part of 'handling_order_bloc.dart';

class HandlingOrderState {
  const HandlingOrderState();
}

final class HandlingOrderInitial extends HandlingOrderState {}

final class GettingDetailsById extends HandlingOrderState {}

final class SuccessGettingOrderDetailsById extends HandlingOrderState {
  final DetailsForOrder order;

  SuccessGettingOrderDetailsById(this.order);
}

final class ErrorGettingDetailsOrderDetailsById extends HandlingOrderState {
  final String message;

  ErrorGettingDetailsOrderDetailsById(this.message);
}

final class CancelingOrder extends HandlingOrderState {}

final class CanceledOrderSuccesfully extends HandlingOrderState {}

final class OrderCancellationFailure extends HandlingOrderState {
  final String error;

  OrderCancellationFailure(this.error);
}
