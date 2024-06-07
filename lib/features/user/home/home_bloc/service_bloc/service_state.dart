part of 'service_bloc.dart';

 class ServiceState {
  const ServiceState();
  
  @override
  List<Object> get props => [];
}

 class ServiceInitial extends ServiceState {}



 class LoadedServices extends ServiceState {
 final List<ServiceModel> services ;

  LoadedServices({required this.services});
}
 class LoadingServices extends ServiceState {}
 class ErrorGetServices extends ServiceState {

  final String message;

  ErrorGetServices({required this.message});
}

