part of 'navigation_bloc.dart';

 class NavigationEvent {}

class NavigateToPage extends NavigationEvent {
  final int pageIndex;
  NavigateToPage(this.pageIndex);
}

