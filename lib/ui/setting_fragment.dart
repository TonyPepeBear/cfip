import 'package:flutter/material.dart';
import 'package:settings_ui/settings_ui.dart';

class SettingFragment extends StatefulWidget {
  const SettingFragment({Key? key}) : super(key: key);

  @override
  State<SettingFragment> createState() => _SettingFragmentState();
}

class _SettingFragmentState extends State<SettingFragment> {
  @override
  Widget build(BuildContext context) {
    return SettingsList(sections: [
      SettingsSection(
        title: Text(
          "Common",
          style: Theme.of(context).textTheme.bodyText1,
        ),
        tiles: [
          SettingsTile.navigation(
            leading: const Icon(Icons.login),
            title: const Text("Logged in"),
            value: const Text("False"),
          )
        ],
      )
    ]);
  }
}
