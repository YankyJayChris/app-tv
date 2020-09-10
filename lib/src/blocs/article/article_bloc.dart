import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';
import 'package:newsapp/src/blocs/article/bloc.dart';
import 'package:newsapp/src/models/api_result_model.dart';
import 'package:newsapp/src/models/article.dart';
import 'package:rxdart/rxdart.dart';

import 'package:newsapp/src/resources/strings.dart';

class ArticleBloc extends Bloc<ArticleEvent, ArticleState> {
  final http.Client httpClient;

  ArticleBloc({@required this.httpClient}) : super(ArticleInitial());

  @override
  Stream<Transition<ArticleEvent, ArticleState>> transformEvents(
    Stream<ArticleEvent> events,
    TransitionFunction<ArticleEvent, ArticleState> transitionFn,
  ) {
    return super.transformEvents(
      events.debounceTime(const Duration(milliseconds: 500)),
      transitionFn,
    );
  }

  @override
  Stream<ArticleState> mapEventToState(ArticleEvent event) async* {
    final currentState = state;
    if (event is ArticleFetched && !_hasReachedMax(currentState)) {
      try {
        if (currentState is ArticleInitial) {
          final List articles = await _fetcArticles(0, 5);
          yield ArticleSuccess(
            articles: articles,
            hasReachedMax: false,
          );
          return;
        }
        if (currentState is ArticleSuccess) {
          final articles =
              await _fetcArticles(currentState.articles.length, 10);
          yield articles.isEmpty
              ? currentState.copyWith(hasReachedMax: true)
              : ArticleSuccess(
                  articles: currentState.articles + articles,
                  hasReachedMax: false,
                );
        }
      } catch (_) {
        yield ArticleFailure();
      }
    }
    if (event is ArticleRefresh) {
      print("am refreshing");
      final List articles = await _fetcArticles(0, 5);
      yield ArticleSuccess(
        articles: articles,
        hasReachedMax: false,
      );
      return;
    }
  }

  bool _hasReachedMax(ArticleState state) =>
      state is ArticleSuccess && state.hasReachedMax;

  Future<List> _fetcArticles(int startIndex, int limit) async {
    final response = await httpClient.get(AppStrings.primeURL +
        '?type=fetch_articles&offset$startIndex&limit=$limit');
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      print(data);
      List<Article> articles = ApiResultModel.fromJson(data).data;
      return articles;
    } else {
      throw Exception();
    }
  }
}
