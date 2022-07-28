import 'package:cfip/main_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class HomeFragment extends StatefulWidget {
  const HomeFragment({Key? key}) : super(key: key);

  @override
  State<HomeFragment> createState() => _HomeFragmentState();
}

class _HomeFragmentState extends State<HomeFragment> {
  @override
  Widget build(BuildContext context) {
    var local = AppLocalizations.of(context)!;
    var images = context.watch<MainModel>().images;
    var accountID = context.watch<MainModel>().accountID;
    var homeMessage = context.watch<MainModel>().homeMessage;
    return Center(
      child: ListView.builder(
        itemCount: images.length + 1,
        itemBuilder: (context, index) {
          if (index == 0) return Text("Logged in as $accountID\n$homeMessage");
          return Text(images[index]);
        },
      ),
    );
  }
}
