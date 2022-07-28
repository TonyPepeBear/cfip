import 'package:flutter/material.dart';

class MainModel extends ChangeNotifier {
  final BuildContext context;

  String homeMessage = "Please wait...";

  MainModel(this.context) {}

  List<String> imagesID = [];
}
