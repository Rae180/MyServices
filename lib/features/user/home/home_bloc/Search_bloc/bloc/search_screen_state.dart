part of 'search_screen_bloc.dart';

class SearchScreenState {}

final class SearchScreenInitial extends SearchScreenState {}

final class SearchScreenLoading extends SearchScreenState {}

final class SearchScreenLoaded extends SearchScreenState {
  final List<SearchResults> results;

  SearchScreenLoaded({required this.results});
}

final class SearchError extends SearchScreenState {
  final String message;

  SearchError({required this.message});
}
