part of 'order_bloc.dart';

class OrderEvent {
  const OrderEvent();
}

class OrderPostEvent extends OrderEvent {
  final int providerId;
  final String type;
  final File image;
  final String descreption;
  final DateTime dateTime;
  final String longtitude;
  final String adress;
  final String latitude;
  final String payment;

  OrderPostEvent(
      {required this.providerId,
      this.type = 'instant',
      required this.image,
      required this.adress,
      required this.descreption,
      required this.dateTime,
      required this.longtitude,
      required this.latitude,
      required this.payment});
}
