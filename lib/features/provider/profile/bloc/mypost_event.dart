part of 'mypost_bloc.dart';

@immutable
sealed class MypostEvent {}

class GetMyPostEvent extends MypostEvent {}
class DeleteMyPostEvent extends MypostEvent {
final int id;

  DeleteMyPostEvent({required this.id});

}

class AddPostEvent extends MypostEvent {
  final String note;
  final List<File> image;

  AddPostEvent({required this.note, required this.image});
}
