part of 'category_bloc.dart';

 class CategoryState {
  const CategoryState();
  
}

 class CategoryInitial extends CategoryState {}
 class LoadedCategory extends CategoryState {
  List<CategoryModel> categories ;

  LoadedCategory({required this.categories});
}
 class LoadingCategory extends CategoryState {}
 class ErrorGetCategory extends CategoryState {

  final String message;

  ErrorGetCategory({required this.message});
}

