part of 'search_screen_bloc.dart';

class SearchScreenEvent {}

class SearchTextChanged extends SearchScreenEvent {
  final String query;

  SearchTextChanged({required this.query});
}
