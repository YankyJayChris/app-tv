import 'package:newsapp/src/models/article.dart';

class ApiResultModel {
  String apiStatus;
  String apiVersion;
  String successType;
  List<Article> data;

  ApiResultModel(
      {this.apiStatus, this.apiVersion, this.successType, this.data});

  ApiResultModel.fromJson(Map<String, dynamic> json) {
    apiStatus = json['api_status'];
    apiVersion = json['api_version'];
    successType = json['success_type'];
    if (json['data'] != null) {
      data = new List<Article>();
      json['data'].forEach((v) {
        data.add(new Article.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['api_status'] = this.apiStatus;
    data['api_version'] = this.apiVersion;
    data['success_type'] = this.successType;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}