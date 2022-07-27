import 'package:cfip/ui/home_fragment.dart';
import 'package:cfip/ui/setting_fragment.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("CFIP"),
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _pageIndex,
          items: navBarItems
              .map((e) => BottomNavigationBarItem(icon: e.icon, label: e.label))
              .toList(),
          onTap: (n) {
            setState(() {
              _pageIndex = n;
            });
          },
        ),
        body: navBarItems[_pageIndex].fragment);
  }
}

List<NavBarItem> navBarItems = [
  NavBarItem(
      icon: const Icon(Icons.home),
      label: "Home",
      fragment: const HomeFragment()),
  NavBarItem(
      icon: const Icon(Icons.settings),
      label: "Settings",
      fragment: const SettingFragment()),
];

class NavBarItem {
  final String label;
  final Icon icon;
  final Widget fragment;

  NavBarItem({required this.label, required this.icon, required this.fragment});
}
