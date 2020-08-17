import 'package:newsapp/src/models/video_api_result.dart';

class VideoApi {
  String apiStatus;
  String apiVersion;
  VideoApiResultModel data;

  VideoApi({this.apiStatus, this.apiVersion, this.data});

  VideoApi.fromJson(Map<String, dynamic> json) {
    apiStatus = json['api_status'];
    apiVersion = json['api_version'];
    data = json['data'] != null ? new VideoApiResultModel.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['api_status'] = this.apiStatus;
    data['api_version'] = this.apiVersion;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}