part of 'order_bloc.dart';

class OrderEvent {
  const OrderEvent();
}

class OrderPostEvent extends OrderEvent {
  final int providerId;
  final String type;
  final List<File>? image;
  final String descreption;
  final DateTime dateTime;
  final String longtitude;
  final String adress;
  final String latitude;
  final String payment;

  OrderPostEvent(
      {required this.providerId,
      required this.type,
      required this.image,
      required this.adress,
      required this.descreption,
      required this.dateTime,
      required this.longtitude,
      required this.latitude,
      required this.payment});
}
