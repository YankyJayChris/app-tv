import 'package:equatable/equatable.dart';

abstract class ArticleEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class ArticleFetched extends ArticleEvent {}