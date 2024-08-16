part of 'home_provider_bloc.dart';

@immutable
 class HomeProviderEvent {}

class Changeindexbuttonbar extends HomeProviderEvent {
  final int index;

  Changeindexbuttonbar({required this.index});
}
