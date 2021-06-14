import '../models/video.dart';

class VideosCat {
  String apiStatus;
  String apiVersion;
  List<Video> videos;

  VideosCat({this.apiStatus, this.apiVersion, this.videos});

  VideosCat.fromJson(Map<String, dynamic> json) {
    apiStatus = json['api_status'];
    apiVersion = json['api_version'];
    if (json['data'] != null) {
      videos = <Video>[];
      json['data'].forEach((v) {
        videos.add(new Video.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['api_status'] = this.apiStatus;
    data['api_version'] = this.apiVersion;
    if (this.videos != null) {
      data['data'] = this.videos.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
