part of 'category_bloc.dart';

sealed class CategoryState {
  const CategoryState();
  
}

final class CategoryInitial extends CategoryState {}
final class LoadedCategory extends CategoryState {
 final List<CategoryModel> categories ;

  LoadedCategory({required this.categories});
}
final class LoadingCategory extends CategoryState {}
final class ErrorGetCategory extends CategoryState {

  final String message;

  ErrorGetCategory({required this.message});
}

