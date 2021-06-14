import '../models/article.dart';

class ArticleApi {
  String apiStatus;
  String apiVersion;
  String successType;
  Article data;

  ArticleApi({this.apiStatus, this.apiVersion, this.successType, this.data});

  ArticleApi.fromJson(Map<String, dynamic> json) {
    apiStatus = json['api_status'];
    apiVersion = json['api_version'];
    successType = json['success_type'];
    data = json['data'] != null ? new Article.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['api_status'] = this.apiStatus;
    data['api_version'] = this.apiVersion;
    data['success_type'] = this.successType;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}
