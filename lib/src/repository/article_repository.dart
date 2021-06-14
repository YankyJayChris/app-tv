import '../models/api_result_model.dart';
import '../models/article.dart';
import "../resources/strings.dart";
import 'package:http/http.dart' as http;
import 'dart:convert';

abstract class ArticleRepository {
  Future<List<Article>> getArticles(int startIndex, int limit);
  Future<List<Article>> searchArticles(String query, int startIndex, int limit);
  Future<List<Article>> categoryArticles(int index, int startIndex, int limit);
}

class ArticleRepositoryImpl implements ArticleRepository {
  @override
  Future<List<Article>> getArticles(int startIndex, int limit) async {
    print("insdex is $startIndex");
    var response = await http.get(AppStrings.primeURL +
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

  @override
  Future<List<Article>> searchArticles(
      String query, int startIndex, int limit) async {
    var response = await http.get(AppStrings.primeURL +
        '?type=fetch_articles&keyword=$query&offset=$startIndex&limit=$limit');
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      List<Article> articles = ApiResultModel.fromJson(data).data;
      return articles;
    } else {
      throw Exception();
    }
  }

  @override
  Future<List<Article>> categoryArticles(
      int index, int startIndex, int limit) async {
    print("$index");
    var response = await http.get(AppStrings.newsUrl +
        '?type=fetch_articles&category_id=$index&offset=$startIndex&limit=$limit');
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      List<Article> articles = ApiResultModel.fromJson(data).data;
      return articles;
    } else {
      throw Exception();
    }
  }
}
