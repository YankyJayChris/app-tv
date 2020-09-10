import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {

  static final UserPreferences _instance = UserPreferences._ctor();
  factory UserPreferences() {
    return _instance;
  }

  UserPreferences._ctor();

  SharedPreferences _prefs;

  init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  get userData {
    return _prefs.getString('userata') ?? ' ';
  }

  set userData(String value) {
    _prefs.setString('userdata', value);
  }

  get sesionData {
    return _prefs.getString('sesionData') ?? '';
  }

  set sesionData(String value) {
    _prefs.setString('sesionData', value);
  }

  get authData {
    return _prefs.getString('authData') ?? '';
  }

  set authData(String value) {
    _prefs.setString('authData', value);
  }

  get onBoarding {
    return _prefs.getBool('onBoarding') ?? false;
  }

  set onBoarding(bool value) {
    _prefs.setBool('onBoarding', value);
  }
  get notNumber {
    return _prefs.getBool('notNumber') ?? false;
  }

  set notNumber(bool value) {
    _prefs.setBool('notNumber', value);
  }
}