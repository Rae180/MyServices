part of 'adding_new_suggest_bloc.dart';

class AddingNewSuggestState {}

final class AddingNewSuggestInitial extends AddingNewSuggestState {}

final class AddingnewSuggestLoading extends AddingNewSuggestState {}

final class AddingnewSuggestSuccess extends AddingNewSuggestState {}

final class AddingNewSuggestError extends AddingNewSuggestState {
  final String message;

  AddingNewSuggestError({required this.message});
}
