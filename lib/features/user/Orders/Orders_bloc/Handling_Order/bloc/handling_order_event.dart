part of 'handling_order_bloc.dart';

class HandlingOrderEvent {}

final class CancelOrderRequested extends HandlingOrderEvent {
  final String orderId;

  CancelOrderRequested(this.orderId);
}

final class CancelOrderConfirmed extends HandlingOrderEvent {
  final String orderId;

  CancelOrderConfirmed(this.orderId);
}

final class CancelOrderFailed extends HandlingOrderEvent {
  final String orderId;
  final String error;

  CancelOrderFailed(this.orderId, this.error);
}

final class FetchOrderDetailsById extends HandlingOrderEvent {
  final int? orderId;

  FetchOrderDetailsById(this.orderId);
}
