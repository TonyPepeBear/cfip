import 'package:cfip/cloudflare_images.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainModel extends ChangeNotifier {
  final BuildContext context;
  int loggedIn = 0; // -1: not logged in, 0: not define, 1: logged in
  String accountID = "";
  String token = "";
  CloudflareImages cfi = CloudflareImages();

  String homeMessage = "Please wait...";

  @override
  void notifyListeners() {
    loggedIn = cfi.getIsLogin() ? 1 : -1;
    super.notifyListeners();
  }

  MainModel(this.context) {
    cfi.setNotifyListeners(notifyListeners);
    SharedPreferences.getInstance().then((sp) {
      var a = sp.getString("accountID");
      var t = sp.getString("token");
      if (a == null || t == null) {
        loggedIn = -1;
        homeMessage = "Check settings!";
      } else {
        loggedIn = 1;
        accountID = a;
        token = t;
        cfi.login(accountID, token);
      }
      notifyListeners();
    });
  }

  List<String> images = [];

  void saveLoginData(String accountID, String token) {
    this.accountID = accountID;
    this.token = token;
    cfi.login(accountID, token);
    notifyListeners();
    SharedPreferences.getInstance().then((sp) {
      sp.setString("accountID", accountID);
      sp.setString("token", token);
    });
  }

  void logout() {
    cfi = CloudflareImages();
    cfi.setNotifyListeners(notifyListeners);
    accountID = "";
    token = "";
    loggedIn = 0;
    notifyListeners();
  }
}
