// Dart imports:
import 'dart:async';

// Package imports:
import 'package:finneasy/resources/strings.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Project imports:

class SharedPreferenceHelper {
  // shared pref instance
  late SharedPreferences _sharedPreference;

  // Auth Token: ----------------------------------------------------------
  Future<String> get authToken async {
    _sharedPreference = await SharedPreferences.getInstance();
    return _sharedPreference.getString(Strings.AUTH_TOKEN) ?? "";
  }

  Future<bool> saveAuthToken(String authToken) async {
    _sharedPreference = await SharedPreferences.getInstance();
    return _sharedPreference.setString(Strings.AUTH_TOKEN, authToken);
  }

  Future<bool> removeAuthToken() async {
    _sharedPreference = await SharedPreferences.getInstance();
    return _sharedPreference.remove(Strings.AUTH_TOKEN);
  }

  // Firebase UID: ----------------------------------------------------------
  Future<String> get uid async {
    _sharedPreference = await SharedPreferences.getInstance();
    return _sharedPreference.getString(Strings.UID) ?? "";
  }

  Future<bool> saveUid(String uid) async {
    _sharedPreference = await SharedPreferences.getInstance();
    return _sharedPreference.setString(Strings.UID, uid);
  }

  Future<bool> removeUid() async {
    _sharedPreference = await SharedPreferences.getInstance();
    return _sharedPreference.remove(Strings.UID);
  }

  // Login:---------------------------------------------------------------------
  Future<bool> get isLoggedIn async {
    _sharedPreference = await SharedPreferences.getInstance();
    return _sharedPreference.getBool(Strings.IS_LOGGED_IN) ?? false;
  }

  Future<bool> saveIsLoggedIn(bool value) async {
    _sharedPreference = await SharedPreferences.getInstance();
    return _sharedPreference.setBool(Strings.IS_LOGGED_IN, value);
  }

  // Theme:------------------------------------------------------
  Future<bool> get isDarkMode async{
    _sharedPreference = await SharedPreferences.getInstance();
    return _sharedPreference.getBool(Strings.IS_DARK_MODE) ?? false;
  }

  Future<void> changeBrightnessToDark(bool value) async{
    _sharedPreference = await SharedPreferences.getInstance();
    _sharedPreference.setBool(Strings.IS_DARK_MODE, value);
  }

}
