import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:start/core/api_service/base_Api_service.dart';
import 'package:start/core/api_service/base_repo.dart';
import 'package:start/core/constants/api_constants.dart';
import 'package:start/core/errors/failures.dart';
import 'package:start/features/provider/profile/model/Post_model.dart';
import 'package:start/features/provider/profile/model/profile_model.dart';

part 'mypost_event.dart';
part 'mypost_state.dart';

class MypostBloc extends Bloc<MypostEvent, MypostState> {
  final BaseApiService client;

  MypostBloc({required this.client}) : super(MypostInitial()) {
    on<GetMyPostEvent>((event, emit) async {
      emit(LoadingState());
      final data = await BaseRepo.repoRequest(
        request: () async {
          var data = await client.getRequestAuth(
            url: ApiConstants.post,
          );
          List<Post> Myposts = [];
          data['data']
              .forEach((element) => Myposts.add(Post.fromJson(element)));
          return Myposts;
        },
      );

      data.fold((f) {
        emit(_mapFailureToState(f));
      }, (data) {
        emit(SuccessLoadedPost(data: data));
      });
    });
    on<AddPostEvent>((event, emit) async {
      emit(LoadingState());
      final data = await BaseRepo.repoRequest(
        request: () async {
          await client.multipart2(
              url: ApiConstants.post,
              jsonBody: {"description": event.note},
              attributeName: "images[]",
              files: event.image);
        },
      );

      data.fold((f) {
        emit(_mapFailureToState(f));
      }, (data) {
        emit(SuccessAddState());
      });
    });
    on<DeleteMyPostEvent>((event, emit) async {
      emit(LoadingState());
      final data = await BaseRepo.repoRequest(
        request: () async {
          await client.delete(
              url: "${ApiConstants.post}/${event.id}",
             
              );
        },
      );

      data.fold((f) {
        emit(_mapFailureToState(f));
      }, (data) {
        emit(SuccessAddState());
      });
    });
  }
  _mapFailureToState(Failure f) {
    switch (f.runtimeType) {
      case OfflineFailure:
        return ErrorState(error: 'No internet');

      case NetworkErrorFailure:
        return ErrorState(
          error: (f as NetworkErrorFailure).message,
        );

      default:
        return ErrorState(
          error: 'Error',
        );
    }
  }
}
