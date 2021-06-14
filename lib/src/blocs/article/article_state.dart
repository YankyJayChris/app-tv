import 'package:equatable/equatable.dart';
import '../../../src/models/article.dart';

abstract class ArticleState extends Equatable {
  const ArticleState();

  @override
  List<Object> get props => [];
}

class ArticleInitial extends ArticleState {}

class ArticleFailure extends ArticleState {}

class ArticleSuccess extends ArticleState {
  final List<Article> articles;
  final bool hasReachedMax;

  const ArticleSuccess({
    this.articles,
    this.hasReachedMax,
  });

  ArticleSuccess copyWith({
    List<Article> articles,
    bool hasReachedMax,
  }) {
    return ArticleSuccess(
      articles: articles ?? this.articles,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object> get props => [articles, hasReachedMax];

  @override
  String toString() =>
      'PostLoaded { videos: ${articles.length}, hasReachedMax: $hasReachedMax }';
}
