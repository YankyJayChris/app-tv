import 'package:equatable/equatable.dart';
import '../../../src/models/article.dart';
import '../../../src/models/category.dart';

abstract class VidCategoriesState extends Equatable {
  const VidCategoriesState();

  @override
  List<Object> get props => [];
}

class VidCategoriesInitial extends VidCategoriesState {}

class VidCategoriesFailure extends VidCategoriesState {}

class VidCategoriesSuccess extends VidCategoriesState {
  final List<Category> categories;

  const VidCategoriesSuccess({
    this.categories,
  });

  VidCategoriesSuccess copyWith({
    List<Article> categories,
  }) {
    return VidCategoriesSuccess(
      categories: categories ?? this.categories,
    );
  }

  @override
  List<Object> get props => [categories];

  @override
  String toString() => 'PostLoaded { categories: ${categories.length},}';
}
