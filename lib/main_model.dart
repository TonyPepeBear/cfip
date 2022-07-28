import 'package:cfip/cfi_utils.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainModel extends ChangeNotifier {
  final BuildContext context;
  int loggedIn = 0; // -1: not logged in, 0: not define, 1: logged in
  String accountID = "";
  String token = "";

  String homeMessage = "Please wait...";

  MainModel(this.context) {
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
        reloadAllImages();
      }
      notifyListeners();
    });
  }

  List<String> images = [];

  void saveLoginData(String accountID, String token) {
    this.accountID = accountID;
    this.token = token;
    notifyListeners();
    reloadAllImages();
    SharedPreferences.getInstance().then((sp) {
      sp.setString("accountID", accountID);
      sp.setString("token", token);
    });
  }

  void reloadAllImages() {
    homeMessage = "Loading Images";
    notifyListeners();
    getAllImagesID(accountID, token).then((value) {
      images = value;
      homeMessage = "Total ${value.length}";
      notifyListeners();
    });
  }
}
