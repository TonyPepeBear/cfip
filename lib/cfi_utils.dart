import 'dart:convert';

import 'package:http/http.dart' as http;

Future<bool> testAccountValid(String accountID, String token) async {
  var url = Uri.parse(
      "https://api.cloudflare.com/client/v4/accounts/$accountID/images/v1?page=1&per_page=1");
  var res = await http.get(url, headers: {"Authorization": "Bearer $token"});
  var json = jsonDecode(res.body);
  try {
    return json["success"];
  } catch (e) {}
  return false;
}

Future<List<String>> getAllImagesID(String accountID, String token) async {
  if (!(await testAccountValid(accountID, token))) {
    return List.empty();
  }
  int page = 1;
  var tempImages = await getOnePageImage(accountID, token, page);
  List<String> allImages = [];
  while (tempImages.isNotEmpty) {
    allImages.addAll(tempImages);
    page++;
    tempImages = await getOnePageImage(accountID, token, page);
  }
  return allImages;
}

Future<List<String>> getOnePageImage(
    String accountID, String token, int page) async {
  var url = Uri.parse(
      "https://api.cloudflare.com/client/v4/accounts/$accountID/images/v1?page=$page&per_page=100");
  var res = await http.get(url, headers: {"Authorization": "Bearer $token"});
  var json = jsonDecode(res.body);
  try {
    List<dynamic> l = json["result"]["images"];
    return l.map((e) => e["id"].toString()).toList();
  } catch (e) {}
  return List.empty();
}
