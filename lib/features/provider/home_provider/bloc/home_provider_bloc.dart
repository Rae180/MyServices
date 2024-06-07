import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'home_provider_event.dart';
part 'home_provider_state.dart';

class HomeProviderBloc extends Bloc<HomeProviderEvent, HomeProviderState> {
  HomeProviderBloc() : super(HomeProviderInitial()) {
    on<Changeindexbuttonbar>((event, emit) {
      emit(ChangeindexbuttonbarState(index: event.index));
    });
  }
}
