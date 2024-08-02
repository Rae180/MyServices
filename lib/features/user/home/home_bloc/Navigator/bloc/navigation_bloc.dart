import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:start/features/user/Orders/Orders_bloc/Order_Details/deatils_for_order_bloc.dart';

part 'navigation_event.dart';
part 'navigation_state.dart';

class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  NavigationBloc() : super(NavigationState(currentPage: 0, selectedChip: OrderFilterState.pending)) {
    on<NavigateToPage>((event, emit) {
      print('NavigateToPage event: ${event.pageIndex}');
      emit(NavigationState(
          currentPage: event.pageIndex, selectedChip: state.selectedChip));
      print('emit');
    });
    on<SelectFilterChip>((event, emit) {
        print('SelectFilterChip event: ${event.chipIndex}');
      emit(NavigationState(
          currentPage: state.currentPage, selectedChip: event.chipIndex));
    });
  }
}
