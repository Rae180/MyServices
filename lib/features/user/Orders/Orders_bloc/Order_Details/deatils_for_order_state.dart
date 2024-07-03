part of 'deatils_for_order_bloc.dart';

class DeatilsForOrderState {
  const DeatilsForOrderState();
}

final class DeatilsForOrderInitial extends DeatilsForOrderState {}

final class DeatilsForOrderLoading extends DeatilsForOrderState {}

final class DeatilsForOrderLoaded extends DeatilsForOrderState {
  final List<DetailsForOrder> orders;

  DeatilsForOrderLoaded({required this.orders});
}

enum OrderFilterState {
  pending,
  reservations,
  canceled,
  inprogress,
  completed,
  paused
}

final class ChipSelected extends DeatilsForOrderState {
  final List<DetailsForOrder> orders;
  ChipSelected(this.orders);
}

final class DetailsForOrderError extends DeatilsForOrderState {
  final String message;

  DetailsForOrderError({required this.message});
}

class DeatilsForOrderEmpty extends DeatilsForOrderState {}
