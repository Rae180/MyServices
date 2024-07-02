part of 'deatils_for_order_bloc.dart';

class DetailsForOrderEvent {
  const DetailsForOrderEvent();
}

class GetOrdersList extends DetailsForOrderEvent {}

class GetDetailsCurrentOrder extends DetailsForOrderEvent {
  // final DetailsForOrder _detailsForOrder;

  // GetDetailsCurrentOrder(this._detailsForOrder);
}

class FilterOrdersByStatus extends DetailsForOrderEvent {
  final String status;

  FilterOrdersByStatus(this.status);
}

class UpdateOrdersEvent extends DetailsForOrderEvent {
  final List<DetailsForOrder> orders;
  UpdateOrdersEvent(this.orders);
}
