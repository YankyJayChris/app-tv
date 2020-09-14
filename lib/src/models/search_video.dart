import 'package:newsapp/src/models/video.dart';

class SearchVideoModel {
  String apiStatus;
  String apiVersion;
  List<Video> data;

  SearchVideoModel({this.apiStatus, this.apiVersion, this.data});

  SearchVideoModel.fromJson(Map<String, dynamic> json) {
    apiStatus = json['api_status'];
    apiVersion = json['api_version'];
    if (json['data'] != null) {
      data = new List<Video>();
      json['data'].forEach((v) {
        data.add(new Video.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['api_status'] = this.apiStatus;
    data['api_version'] = this.apiVersion;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}