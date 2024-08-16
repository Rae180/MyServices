part of 'service_bloc.dart';

 class ServiceEvent  {
  const ServiceEvent();

  @override
  List<Object> get props => [];
}

class GetServices extends ServiceEvent {
  final int id;

  GetServices({required this.id});
}
