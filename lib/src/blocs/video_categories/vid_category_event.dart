import 'package:equatable/equatable.dart';

abstract class VidCategoriesEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class VidCategoriesFetched extends VidCategoriesEvent {}
class VidCategoriesRefresh extends VidCategoriesEvent {}