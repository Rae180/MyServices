part of 'deatils_for_order_bloc.dart';

class DeatilsForOrderState {
  const DeatilsForOrderState();
}

final class DeatilsForOrderInitial extends DeatilsForOrderState {}

final class DeatilsForOrderLoading extends DeatilsForOrderState {}

final class DeatilsForOrderLoaded extends DeatilsForOrderState {
  final List<DetailsForOrder> orders;
  final OrderFilterState selectedFilter;

  DeatilsForOrderLoaded({required this.orders, required this.selectedFilter});
}

enum OrderFilterState {
  pending,
  reservations,
  allCanceled,
  inProgress,
  completed,
  paused
}

String getStatusStringForChips(OrderFilterState state,BuildContext context) {
  switch (state) {
    case OrderFilterState.pending:
      return AppLocalizations.of(context)!.pending;
    case OrderFilterState.reservations:
      return AppLocalizations.of(context)!.reservations;
    case OrderFilterState.allCanceled:
      return AppLocalizations.of(context)!.allCanceled;
    case OrderFilterState.inProgress:
      return AppLocalizations.of(context)!.inprogress;
    case OrderFilterState.completed:
      return AppLocalizations.of(context)!.completed;
    case OrderFilterState.paused:
      return AppLocalizations.of(context)!.paused;
    default:
      return '';
  }
}

String getStatusString(OrderFilterState state) {
  switch (state) {
    case OrderFilterState.pending:
      return 'pending';
    case OrderFilterState.reservations:
      return 'reservations';
    case OrderFilterState.allCanceled:
      return 'All canceled';
    case OrderFilterState.inProgress:
      return 'in progress';
    case OrderFilterState.completed:
      return 'completed';
    case OrderFilterState.paused:
      return 'pause';
    default:
      return '';
  }
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
