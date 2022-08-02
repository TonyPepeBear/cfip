import 'package:cfip/main_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import 'ui/main_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // locale: const Locale('en'),
      title: 'CFIP',
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      theme: ThemeData(
        primarySwatch: MaterialColor(0xFFF5821F, themeColors),
      ),
      home: MultiProvider(
        providers: [
          ChangeNotifierProvider<MainModel>(
            create: (context) => MainModel(context),
          ),
        ],
        child: const MainPage(),
      ),
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
