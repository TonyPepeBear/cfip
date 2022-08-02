import 'package:cfip/cloudflare_images.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainModel extends ChangeNotifier {
  final BuildContext context;
  int loggedIn = 0; // -1: not logged in, 0: not define, 1: logged in
  String accountID = "";
  String token = "";
  int currentCount = 0;
  int allowedCount = 0;
  bool isFetchingImages = false;
  List<String> images = [];
  CloudflareImages cfi = CloudflareImages();


  @override
  void notifyListeners() {
    loggedIn = cfi.getIsLogin() ? 1 : -1;
    currentCount = cfi.currentCount;
    allowedCount = cfi.allowedCount;
    if(cfi.getIsLogin()) {
      fetchMoreImages();
    }
    super.notifyListeners();
  }

  MainModel(this.context) {
    cfi.setNotifyListeners(notifyListeners);
    SharedPreferences.getInstance().then((sp) {
      var a = sp.getString("accountID");
      var t = sp.getString("token");
      if (a == null || t == null) {
        loggedIn = -1;
      } else {
        loggedIn = 1;
        accountID = a;
        token = t;
        cfi.login(accountID, token).then((value) => fetchMoreImages());
      }
      notifyListeners();
    });
  }

  void fetchMoreImages() async {
    if (currentCount < images.length || isFetchingImages) return;
    isFetchingImages = true;
    var l = await cfi.getOnePageImage(images.length ~/ 50 + 1);
    images.addAll(l);
    isFetchingImages = false;
    notifyListeners();
  }

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

  String getImageURL(int index) {
    return cfi.getImageURL(images[index], "preview");
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
