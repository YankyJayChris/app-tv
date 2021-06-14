import '../models/live.dart';

class Live_data {
  String apiStatus;
  String apiVersion;
  String successType;
  List<Live> data;

  Live_data({this.apiStatus, this.apiVersion, this.successType, this.data});

  Live_data.fromJson(Map<String, dynamic> json) {
    apiStatus = json['api_status'];
    apiVersion = json['api_version'];
    successType = json['success_type'];
    if (json['data'] != null) {
      data = <Live>[];
      json['data'].forEach((v) {
        data.add(new Live.fromJson(v));
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
