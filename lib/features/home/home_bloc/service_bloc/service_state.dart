part of 'service_bloc.dart';

sealed class ServiceState {
  const ServiceState();
  
  @override
  List<Object> get props => [];
}

final class ServiceInitial extends ServiceState {}



final class LoadedServices extends ServiceState {
 final List<ServiceModel> services ;

  LoadedServices({required this.services});
}
final class LoadingServices extends ServiceState {}
final class ErrorGetServices extends ServiceState {

  final String message;

  ErrorGetServices({required this.message});
}

