import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;

import 'package:newsapp/src/models/userRepo.dart';
import 'package:newsapp/src/repository/local_data.dart';
import 'package:newsapp/src/repository/user_preferences.dart';
import 'package:newsapp/src/resources/strings.dart';

class UserRepository {
  final FirebaseAuth _firebaseAuth;

  UserRepository({FirebaseAuth firebaseAuth})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  Future<void> sendOtp(
      String phoneNumber,
      Duration timeOut,
      phoneVerificationFailed,
      phoneVerificationCompleted,
      phoneCodeSent,
      phoneCodeAutoRetrievalTimeout) async {
    _firebaseAuth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        timeout: timeOut,
        verificationCompleted: phoneVerificationCompleted,
        verificationFailed: phoneVerificationFailed,
        codeSent: phoneCodeSent,
        codeAutoRetrievalTimeout: phoneCodeAutoRetrievalTimeout);
  }

  Future<AuthResult> verifyAndLogin(
      String verificationId, String smsCode) async {
    AuthCredential authCredential = PhoneAuthProvider.getCredential(
        verificationId: verificationId, smsCode: smsCode);

    return _firebaseAuth.signInWithCredential(authCredential);
  }

  Future<FirebaseUser> getUser() async {
    var user = await _firebaseAuth.currentUser();
    return user;
  }

  static Future<UserRespoModel> loginOnBackend(
      {String phoneNumber, String password}) async {
    print("am here now");
    var body = {
      'phone_number': phoneNumber,
      'password': password,
    };
    final res = await http.post(
      AppStrings.primeURL + '?type=phone_login',
      body: body,
    );
    if (res.statusCode == 200) {
      print("====== am here now we go =======");
      LocalData prefs =  LocalData();
      var myRes = json.decode(res.body);
      UserRespoModel userData = UserRespoModel.fromJson(myRes);
      prefs.setAuthToken(jsonEncode(userData.data.sessionId));
      prefs.setuserData(jsonEncode(userData));
      return userData;
    } else {
      throw Exception('Failed to get user data');
    }
  }
}
