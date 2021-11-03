import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsModel extends ChangeNotifier {
  static const String preferencesAccountID = "accountID";
  static const String preferencesToken = "token";

  String _accountID = "";
  String _token = "";

  String get accountID => _accountID;

  String get token => _token;

  SettingsModel() {
    getDataFromSharedPreferences();
  }

  void getDataFromSharedPreferences() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    _accountID = preferences.getString(preferencesAccountID) ?? "";
    _token = preferences.getString(preferencesToken) ?? "";
    notifyListeners();
  }

  void updateAccountSettings(String accountID, String token) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString(preferencesAccountID, accountID);
    preferences.setString(preferencesToken, token);
    _accountID = accountID;
    _token = token;
    notifyListeners();
  }

  void clearSettings() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString(preferencesAccountID, "");
    preferences.setString(preferencesToken, "");
    _accountID = "";
    _token = "";
    notifyListeners();
  }
}
