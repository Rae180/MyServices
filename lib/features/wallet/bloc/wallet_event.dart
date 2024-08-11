part of 'wallet_bloc.dart';

@immutable
sealed class WalletEvent {}


class GetWalletEvent extends WalletEvent{}