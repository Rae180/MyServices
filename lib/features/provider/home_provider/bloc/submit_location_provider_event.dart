part of 'submit_location_provider_bloc.dart';

abstract class SubmitLocationProviderEvent  {
  const SubmitLocationProviderEvent();


}
class StartSubmittingLocation extends SubmitLocationProviderEvent{

}
class StopSubmittingLocation extends SubmitLocationProviderEvent{}
