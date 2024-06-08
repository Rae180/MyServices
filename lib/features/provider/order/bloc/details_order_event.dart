part of 'details_order_bloc.dart';

@immutable
sealed class DetailsOrderEvent {}

class GetDetailsOrderEvent extends DetailsOrderEvent {
  final int id;

  GetDetailsOrderEvent({required this.id});
}
