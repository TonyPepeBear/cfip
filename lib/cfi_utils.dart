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
