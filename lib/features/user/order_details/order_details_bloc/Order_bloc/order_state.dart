// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'order_bloc.dart';

class OrderState {
  const OrderState();
}

class OrderInitial extends OrderState {}

class LoadingOrder extends OrderState {}

class OrderSucces extends OrderState {}

class OrderError extends OrderState {
  final String message;
  OrderError({
    required this.message,
  });
  
}
