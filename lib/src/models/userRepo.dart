import 'package:newsapp/src/models/user.dart';

class UserRespoModel {
  String apiStatus;
  String apiVersion;
  String successType;
  Data data;
  UserModel userData;

  UserRespoModel(
      {this.apiStatus,
      this.apiVersion,
      this.successType,
      this.data,
      this.userData});

  UserRespoModel.fromJson(Map<String, dynamic> json) {
    apiStatus = json['api_status'];
    apiVersion = json['api_version'];
    successType = json['success_type'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    userData = json['user_data'] != null
        ? new UserModel.fromJson(json['user_data'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['api_status'] = this.apiStatus;
    data['api_version'] = this.apiVersion;
    data['success_type'] = this.successType;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    if (this.userData != null) {
      data['user_data'] = this.userData.toJson();
    }
    return data;
  }
}

class Data {
  String sessionId;
  String message;
  int userId;
  String cookie;

  Data({this.sessionId, this.message, this.userId, this.cookie});

  Data.fromJson(Map<String, dynamic> json) {
    sessionId = json['session_id'];
    message = json['message'];
    userId = json['user_id'];
    cookie = json['cookie'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['session_id'] = this.sessionId;
    data['message'] = this.message;
    data['user_id'] = this.userId;
    data['cookie'] = this.cookie;
    return data;
  }
}