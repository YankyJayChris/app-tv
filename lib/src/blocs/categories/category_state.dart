import 'package:equatable/equatable.dart';
import 'package:newsapp/src/models/article.dart';
import 'package:newsapp/src/models/category.dart';


abstract class CategoriesState extends Equatable {
  const CategoriesState();

  @override
  List<Object> get props => [];
}

class CategoriesInitial extends CategoriesState {}

class CategoriesFailure extends CategoriesState {}

class CategoriesSuccess extends CategoriesState {
  final List<Category> categories;

  const CategoriesSuccess({
    this.categories,
  });

  CategoriesSuccess copyWith({
    List<Article> categories,
  }) {
    return CategoriesSuccess(
      categories: categories ?? this.categories,
    );
  }

  @override
  List<Object> get props => [categories];

  @override
  String toString() =>
      'PostLoaded { categories: ${categories.length},}';
}
