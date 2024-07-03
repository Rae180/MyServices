part of 'mangeorder_bloc.dart';

@immutable
sealed class MangeorderEvent {}


class AcceptorderEvent extends MangeorderEvent {
  final int id;
  AcceptorderEvent({
  required  this.id,
  });
}

class RejectorderEvent extends MangeorderEvent {
  final int id;
  RejectorderEvent({
   required this.id,
  });
}

class RescheduleorderEvent extends MangeorderEvent {
  final int id;
  final DateTime dateTime;
  RescheduleorderEvent({
  required  this.id,
  required this.dateTime
  });
}

class AcceptrescheduleorderEvent extends MangeorderEvent {
  final int id;
  AcceptrescheduleorderEvent({
   required this.id,
  });
}

class RejectrescheduleorderEvent extends MangeorderEvent {
  final int id;
  RejectrescheduleorderEvent({
   required this.id,
  });
}
