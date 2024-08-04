part of 'navigation_bloc.dart';

// enum OrderFilterStateZ {
//   pending,
//   reservations,
//   allCanceled,
//   inProgress,
//   completed,
//   paused
// }


class NavigationState {
  final int currentPage;
  final OrderFilterState selectedChip;

  NavigationState({required this.currentPage, required this.selectedChip});
}
