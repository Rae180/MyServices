part of 'managecurrentorder_bloc.dart';

@immutable
sealed class ManagecurrentorderEvent {}

class ArriveorderEvent extends ManagecurrentorderEvent {
  final int id;
  ArriveorderEvent({
    required this.id,
  });
}

class StartWorkorderEvent extends ManagecurrentorderEvent {
  final int id;
  StartWorkorderEvent({
    required this.id,
  });
}

class PauseWorkorderEvent extends ManagecurrentorderEvent {
  final int id;
  PauseWorkorderEvent({
    required this.id,
  });
}

class ResumeWorkorderEvent extends ManagecurrentorderEvent {
  final int id;
  ResumeWorkorderEvent({
    required this.id,
  });
}

class EndWorkorderEvent extends ManagecurrentorderEvent {
  final int id;
  EndWorkorderEvent({
    required this.id,
  });
}
class PaidEvent extends ManagecurrentorderEvent {
  final int id;
  PaidEvent({
    required this.id,
  });
}

class postpomentorderEvent extends ManagecurrentorderEvent {
  final int id;
  final DateTime dateTime;
  postpomentorderEvent({required this.id, required this.dateTime});
}

class AdditemEvent extends ManagecurrentorderEvent {
  final int id;
  final List<Item> items;
  AdditemEvent({required this.id, required this.items});
}
