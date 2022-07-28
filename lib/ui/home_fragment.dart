import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomeFragment extends StatefulWidget {
  const HomeFragment({Key? key}) : super(key: key);

  @override
  State<HomeFragment> createState() => _HomeFragmentState();
}

class _HomeFragmentState extends State<HomeFragment> {
  @override
  Widget build(BuildContext context) {
    var local = AppLocalizations.of(context)!;
    return Center(
      child: Text(local.helloWorld),
    );
  }
}
