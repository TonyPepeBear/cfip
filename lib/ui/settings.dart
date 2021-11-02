import 'package:card_settings/card_settings.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  String _accountIDInput = "";

  String _tokenInput = "";

  @override
  Widget build(BuildContext context) {
    return CardSettings(children: <CardSettingsSection>[
      CardSettingsSection(
        header: CardSettingsHeader(
          label: "Cloudflare Account Settings",
        ),
        children: <CardSettingsWidget>[
          CardSettingsText(
            icon: const Icon(Icons.account_circle),
            label: "Account ID",
            onChanged: (value) {
              _accountIDInput = value;
            },
          ),
          CardSettingsText(
            icon: const Icon(Icons.vpn_key),
            label: "Token",
            onChanged: (value) {
              _tokenInput = value;
            },
          ),
          CardSettingsButton(
              label: "Test Connection",
              onPressed: () {
                print("$_accountIDInput\n$_tokenInput");
              })
        ],
      )
    ]);
  }
}
