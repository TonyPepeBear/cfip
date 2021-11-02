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
    return Padding(
      padding: const EdgeInsets.all(30),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              decoration: const InputDecoration(
                  labelText: "Account ID", icon: Icon(Icons.account_circle)),
              onChanged: (value) {
                _accountIDInput = value;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              decoration: const InputDecoration(
                  labelText: "Token", icon: Icon(Icons.vpn_key)),
              onChanged: (value) {
                _tokenInput = value;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
                onPressed: () {
                  // Todo test connection
                },
                child: const Text("Test Connection")),
          ),
        ],
      ),
    );
  }
}
