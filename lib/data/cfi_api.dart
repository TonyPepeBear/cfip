import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'cfimage.dart';

Future<String> fetchImageJson(
    http.Client client, String accountID, String token, int page) async {
  var url = Uri.parse(
      "https://api.cloudflare.com/client/v4/accounts/$accountID/images/v1?page=$page&per_page=50");
  var resp = await client.get(url, headers: {
    "Authorization": "Bearer $token",
  });
  var json = jsonDecode(resp.body);
  if (json["success"] == false) throw Exception(json["errors"]);
  return jsonEncode(json["result"]["images"]);
}

List<CFImage> convertJsonToImageList(String json) {
  var list = jsonDecode(json) as List;
  return list
      .map((e) => CFImage(
          e["id"], e["filename"], CFImage.formatter.parse(e["uploaded"])))
      .toList();
}

Future<List<CFImage>> getAllImages(String accountID, String token) async {
  List<CFImage> list = [];
  int pageCount = 1;
  var tempList = convertJsonToImageList(
      await fetchImageJson(http.Client(), accountID, token, pageCount));
  while (tempList.isNotEmpty) {
    list.addAll(tempList);
    tempList.clear();
    pageCount++;
    tempList = convertJsonToImageList(
        await fetchImageJson(http.Client(), accountID, token, pageCount));
  }
  return list;
}

Future<String> getDeliveryUrl(
    http.Client client, String accountID, String token) async {
  var url = Uri.parse(
      "https://api.cloudflare.com/client/v4/accounts/$accountID/images/v1?page=1&per_page=1");
  var resp = await client.get(url, headers: {
    "Authorization": "Bearer $token",
  });
  var json = jsonDecode(resp.body);
  if (json["success"] == false) throw Exception(json["errors"]);
  var list = json["result"]["images"] as List;
  RegExp exp = RegExp(r"https:\/\/imagedelivery.net\/(.*)\/(.*)\/(.*)");
  var v = (list[0]["variants"] as List)[0].toString();
  return exp.firstMatch(v)?.group(1) ?? "";
}

Future<bool> testConnection(
    http.Client client, String accountID, String token) async {
  var url = Uri.parse(
      "https://api.cloudflare.com/client/v4/accounts/$accountID/images/v1?page=1&per_page=1");
  var resp = await client.get(url, headers: {
    "Authorization": "Bearer $token",
  });
  var json = jsonDecode(resp.body);
  return json["success"] as bool;
}
