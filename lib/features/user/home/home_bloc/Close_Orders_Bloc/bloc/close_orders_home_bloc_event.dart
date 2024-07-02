part of 'close_orders_home_bloc_bloc.dart';

class CloseOrdersHomeBlocEvent {
  const CloseOrdersHomeBlocEvent();

  @override
  List<Object> get props => [];
}

class GetCloseOrders extends CloseOrdersHomeBlocEvent {
  final int id;

  GetCloseOrders({required this.id});
}
