import 'package:cfip/ui/settings.dart';
import 'package:flutter/material.dart';

import 'ui/my_home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _page = 0;

  Widget _getBodyPage() {
    switch (_page) {
      case 0:
        return const MyHomePage();
      case 1:
        return SettingsPage();
    }
    return const MyHomePage();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Cloudflare Images',
        theme: ThemeData(
          primarySwatch: Colors.orange,
        ),
        home: Scaffold(
            appBar: AppBar(
              title: const Text("Cloudflare Images"),
            ),
            drawer: Builder(builder: (context) {
              return Drawer(
                  child: ListView(children: [
                const DrawerHeader(
                  decoration: BoxDecoration(color: Colors.orangeAccent),
                  child: Text(""),
                ),
                ListTile(
                  leading: const Icon(Icons.home),
                  title: const Text("Home"),
                  onTap: () {
                    setState(() {
                      _page = 0;
                    });
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.settings),
                  title: const Text("Settings"),
                  onTap: () {
                    setState(() {
                      _page = 1;
                    });
                    Navigator.pop(context);
                  },
                ),
              ]));
            }),
            body: _getBodyPage()));
  }
}
