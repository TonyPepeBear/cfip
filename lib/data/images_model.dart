import 'dart:collection';

import 'package:cfip/data/cfi_api.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'cfimage.dart';

class ImagesModel extends ChangeNotifier {
  final List<CFImage> _images = [];

  UnmodifiableListView<CFImage> get images => UnmodifiableListView(_images);

  String _deliveryID = "";

  String get deliveryID => _deliveryID;

  ImagesModel();

  void reloadAll(String accountID, String token) {
    if (accountID.isEmpty || token.isEmpty) {
      _images.clear();
      _deliveryID = "";
      notifyListeners();
    }
    reloadAllImages(accountID, token);
    reloadDeliverID(accountID, token);
  }

  void reloadAllImages(String accountID, String token) async {
    if (accountID.isEmpty || token.isEmpty) {
      _images.clear();
      notifyListeners();
    }
    List<CFImage> images = await getAllImages(accountID, token);
    images.sort((a, b) =>
        b.uploaded.millisecondsSinceEpoch - a.uploaded.millisecondsSinceEpoch);
    _images.clear();
    _images.addAll(images);
    notifyListeners();
  }

  void reloadDeliverID(String accountID, String token) async {
    if (accountID.isEmpty || token.isEmpty) {
      _deliveryID = "";
      notifyListeners();
    }

    _deliveryID = await getDeliveryUrl(http.Client(), accountID, token);
    await Future.delayed(const Duration(seconds: 3));
    notifyListeners();
  }
}
