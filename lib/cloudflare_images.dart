import 'dart:convert';

import 'package:http/http.dart' as http;

class CloudflareImages {
  String _accountID = "";
  String _token = "";
  String _accountHash = "";
  bool _isLogin = false;
  int _currentCount = -1;
  int _allowedCount = -1;
  Function()? __notifyListeners;

  static Future<bool> validAccount(String accountID, String token) async {
    var url = Uri.parse(
        "https://api.cloudflare.com/client/v4/accounts/$accountID/images/v1/stats");
    var res = await http.get(url, headers: {"Authorization": "Bearer $token"});
    try {
      var json = jsonDecode(res.body);
      return json["success"];
    } catch (e) {}
    return false;
  }

  void login(String accountID, String token) async {
    var url = Uri.parse(
        "https://api.cloudflare.com/client/v4/accounts/$accountID/images/v1/stats");
    var res = await http.get(url, headers: {"Authorization": "Bearer $token"});
    var json = jsonDecode(res.body);
    try {
      if (json["success"]) {
        _accountID = accountID;
        _token = token;
        _isLogin = true;
        _currentCount = json["result"]["count"]["current"];
        _allowedCount = json["result"]["count"]["allowed"];
        __notifyListeners;
      }
    } catch (e) {
      _isLogin = false;
    }
    _notifyListeners();
  }

  void setNotifyListeners(Function() f) {
    __notifyListeners = f;
  }

  bool getIsLogin() {
    return _isLogin;
  }

  void _notifyListeners() {
    if (__notifyListeners != null) {
      __notifyListeners!();
    }
  }

  String convert2ImageURL(String imageID, String accountHash, String variant) {
    return "https://imagedelivery.net/$accountHash/$imageID/$variant";
  }

  Future<List<String>> getOnePageImage(int page) async {
    var url = Uri.parse(
        "https://api.cloudflare.com/client/v4/accounts/$_accountID/images/v1?page=$page&per_page=100");
    var res = await http.get(url, headers: {"Authorization": "Bearer $_token"});
    var json = jsonDecode(res.body);
    try {
      List<dynamic> l = json["result"]["images"];
      return l.map((e) => e["id"].toString()).toList();
    } catch (e) {}
    return List.empty();
  }
}
