import 'dart:collection';

import 'package:cfip/data/cfi_api.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'cfimage.dart';

class ImagesModel extends ChangeNotifier {
  final List<CFImage> _images = [];

  UnmodifiableListView<CFImage> get images => UnmodifiableListView(_images);

  ImagesModel();

  ImagesModel.withInit(String accountID, String token) {
    reloadAllImages(accountID, token);
    reloadDeliverID(accountID, token);
  }

  String deliveryID = "";

  void reloadAllImages(String accountID, String token) async {
    List<CFImage> images = await getAllImages(accountID, token);
    _images.clear();
    _images.addAll(images);
    notifyListeners();
  }

  void reloadDeliverID(String accountID, String token) async {
    deliveryID = await getDeliveryUrl(http.Client(), accountID, token);
    await Future.delayed(const Duration(seconds: 3));
    notifyListeners();
  }
}
