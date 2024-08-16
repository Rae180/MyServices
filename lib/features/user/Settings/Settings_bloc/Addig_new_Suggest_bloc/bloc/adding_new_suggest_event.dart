part of 'adding_new_suggest_bloc.dart';

class AddingNewSuggestEvent {}

final class AddingNewSugestSend extends AddingNewSuggestEvent {
  final String suggest;

  AddingNewSugestSend({required this.suggest});
}
