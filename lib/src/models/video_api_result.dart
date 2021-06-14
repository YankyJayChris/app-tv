import '../models/video.dart';

class VideoApiResultModel {
  List<Video> featured;
  List<Video> top;
  List<Video> latest;
  List<Video> fav;

  VideoApiResultModel({this.featured, this.top, this.latest, this.fav});

  VideoApiResultModel.fromJson(Map<String, dynamic> json) {
    if (json['featured'] != null) {
      featured = <Video>[];
      json['featured'].forEach((v) {
        featured.add(new Video.fromJson(v));
      });
    }
    if (json['top'] != null) {
      top = <Video>[];
      json['top'].forEach((v) {
        top.add(new Video.fromJson(v));
      });
    }
    if (json['latest'] != null) {
      latest = <Video>[];
      json['latest'].forEach((v) {
        latest.add(new Video.fromJson(v));
      });
    }
    if (json['fav'] != null) {
      fav = <Video>[];
      json['fav'].forEach((v) {
        fav.add(new Video.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.featured != null) {
      data['featured'] = this.featured.map((v) => v.toJson()).toList();
    }
    if (this.top != null) {
      data['top'] = this.top.map((v) => v.toJson()).toList();
    }
    if (this.latest != null) {
      data['latest'] = this.latest.map((v) => v.toJson()).toList();
    }
    if (this.fav != null) {
      data['fav'] = this.fav.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
