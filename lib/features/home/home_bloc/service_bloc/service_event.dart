part of 'service_bloc.dart';

sealed class ServiceEvent  {
  const ServiceEvent();

  @override
  List<Object> get props => [];
}

class GetServices extends ServiceEvent {
  final int id;

  GetServices({required this.id});
}
