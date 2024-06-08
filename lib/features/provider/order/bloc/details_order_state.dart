part of 'details_order_bloc.dart';

@immutable
sealed class DetailsOrderState {}

final class DetailsOrderInitial extends DetailsOrderState {}

class LoadedDetailsOrderState extends DetailsOrderState {
  final DetailsOrderProvider data;
  LoadedDetailsOrderState({required this.data});
}

class LoadingDetailsOrderState extends DetailsOrderState {}

class ErrorGetDetailsOrderState extends DetailsOrderState {
  final String message;

  ErrorGetDetailsOrderState({required this.message});
}
