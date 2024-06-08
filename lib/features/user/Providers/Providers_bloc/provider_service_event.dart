part of 'provider_service_bloc.dart';

class ProviderServiceEvent {
  const ProviderServiceEvent();

  @override
  List<Object> get props => [];
}

class GetProvoiders extends ProviderServiceEvent {
  final int id;

  GetProvoiders({required this.id});
}
