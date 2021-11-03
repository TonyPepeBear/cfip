import 'package:cfip/data/cfi_api.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  String _accountIDInput = "";
  String _tokenInput = "";
  bool _testSuccess = false;

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
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Testing Connection")));
                  testConnection(http.Client(), _accountIDInput, _tokenInput)
                      .then((value) {
                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(value ? "Success" : "Connection Fail")));
                    if (value) {
                      setState(() {
                        _testSuccess = value;
                      });
                    }
                  });
                },
                child: const Text("Test Connection")),
          ),
          Visibility(
            visible: _testSuccess,
            child: Padding(
                padding: const EdgeInsets.all(16),
                child: ElevatedButton(
                  child: const Text("Apply"),
                  onPressed: () {
                    // TODO Apply
                  },
                )),
          ),
        ],
      ),
    );
  }
}
