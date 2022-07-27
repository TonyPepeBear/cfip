import 'package:flutter/material.dart';

import 'ui/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: MaterialColor(0xFFF5821F, themeColors),
      ),
      home: const MyHomePage(),
    );
  }
}

Map<int, Color> themeColors = {
  50: const Color.fromRGBO(246, 130, 31, .1),
  100: const Color.fromRGBO(246, 130, 31, .2),
  200: const Color.fromRGBO(246, 130, 31, .3),
  300: const Color.fromRGBO(246, 130, 31, .4),
  400: const Color.fromRGBO(246, 130, 31, .5),
  500: const Color.fromRGBO(246, 130, 31, .6),
  600: const Color.fromRGBO(246, 130, 31, .7),
  700: const Color.fromRGBO(246, 130, 31, .8),
  800: const Color.fromRGBO(246, 130, 31, .9),
  900: const Color.fromRGBO(246, 130, 31, 1),
};
