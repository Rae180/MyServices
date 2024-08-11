part of 'wallet_bloc.dart';

@immutable
sealed class WalletState {}

final class WalletInitial extends WalletState {}

class LoadingState extends WalletState {}

class SuccessLoadedWallet extends WalletState {
  final WalletModel data;

  SuccessLoadedWallet({required this.data});
}

class ErrorState extends WalletState {
  final String error;

  ErrorState({required this.error});
}
