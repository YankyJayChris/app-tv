import 'package:equatable/equatable.dart';

abstract class CategoriesEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class CategoriesFetched extends CategoriesEvent {}
class CategoriesRefresh extends CategoriesEvent {}