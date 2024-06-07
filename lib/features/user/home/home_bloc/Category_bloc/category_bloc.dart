import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:start/core/api_service/base_Api_service.dart';
import 'package:start/core/api_service/base_repo.dart';
import 'package:start/core/constants/api_constants.dart';
import 'package:start/core/errors/failures.dart';
import 'package:start/features/user/home/model/category_model.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final BaseApiService client;
  CategoryBloc({required this.client}) : super(CategoryInitial()) {
    on<GetCategory>((event, emit) async {
      emit(LoadingCategory());
      final data = await BaseRepo.repoRequest(
        request: () async {
          var data = await client.getRequest(url: ApiConstants.getCategory);
          List<CategoryModel> categories = [];
          data['data'].forEach(
              (element) => categories.add(CategoryModel.fromJson(element)));
          return categories;    
        },
      );

      data.fold((f) {
        emit(_mapFailureToState(f));
      }, (data) {
        emit(LoadedCategory(categories: data));
      });
    });
  }

  _mapFailureToState(Failure f) {
    switch (f.runtimeType) {
      case OfflineFailure:
        return ErrorGetCategory(message: 'No internet');

      case NetworkErrorFailure:
        return ErrorGetCategory(
          message: (f as NetworkErrorFailure).message,
        );

      default:
        return ErrorGetCategory(
          message: 'Error',
        );
    }
  }
}
