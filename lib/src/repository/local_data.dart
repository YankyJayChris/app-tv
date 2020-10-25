import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class LocalData {
  final String authToken = "session";
  final String userData = "userData";
  final String subNot = "subNot";
  final String subNotNumber = "subNotNumber";
  final String welcom = "welcom";
  final String payData = "paydata";

//set data into shared preferences like this
  Future<void> setAuthToken(String token) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(this.authToken, token);
  }

//get value from shared preferences
  Future<String> getAuthToken() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    String authToken;
    authToken = pref.getString(this.authToken) ?? null;
    return authToken;
  }

  //set data userdata in sharedpreference
  Future<void> setuserData(String data) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(this.userData, data);
  }

//get data userdata in sharedpreference
  Future<String> getuserData() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    String myUser;
    myUser = pref.getString(this.userData) ?? "";
    return myUser;
  }

  //set data userdata in sharedpreference
  Future<void> setsubNot(bool data) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(this.subNot, data);
  }

//get data userdata in sharedpreference
  Future<bool> getsubNot() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    bool subtonot;
    subtonot = pref.getBool(this.subNot) ?? true;
    return subtonot;
  }

  //set data userdata in sharedpreference
  Future<void> setsubNotNumber(int data) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt(this.subNotNumber, data);
  }

//get data userdata in sharedpreference
  Future<int> getsubNotNumber() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    int subtonot;
    subtonot = pref.getInt(this.subNotNumber) ?? 0;
    return subtonot;
  }

  //set data userdata in sharedpreference
  Future<void> setWelcom(bool data) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(this.welcom, data);
  }

  //get data userdata in sharedpreference
  Future<bool> getWelcom() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    bool subtonot;
    subtonot = pref.getBool(this.welcom) ?? false;
    return subtonot;
  }

  //set data Payata in sharedpreference
  Future<void> setPayData(String data) async {
    print("am here in set payments");
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(this.payData, data);
  }

  //get data Paydata in sharedpreference
  Future<String> getPayData() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    String subtonot;
    subtonot = pref.getString(this.payData) ?? "";
    return subtonot;
  }
}
