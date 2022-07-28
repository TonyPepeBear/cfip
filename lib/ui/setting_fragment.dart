import 'package:cfip/cfi_utils.dart';
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
            onPressed: (context) {
              String accountID = "";
              String token = "";
              bool ok = false;
              String message = "";

              showDialog(
                context: context,
                builder: (context) {
                  return StatefulBuilder(builder: (context, setState) {
                    return AlertDialog(
                      title: const Text("Login"),
                      actions: [
                        TextButton(
                          child: const Text("Test"),
                          onPressed: () async {
                            setState(() {
                              message = "Please Wait";
                            });
                            if (await testAccountValid(accountID, token)) {
                              setState(() {
                                ok = true;
                                message = "Account Valid";
                              });
                            } else {
                              setState(() {
                                ok = false;
                                message = "Account Invalid";
                              });
                            }
                          },
                        ),
                        TextButton(
                          onPressed: () {},
                          child: const Text("Cancle"),
                        ),
                        TextButton(
                          onPressed: ok
                              ? () {
                                  Navigator.pop(context);
                                }
                              : null,
                          child: const Text("Save"),
                        ),
                      ],
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextField(
                            decoration:
                                const InputDecoration(label: Text("AccountID")),
                            onChanged: (s) {
                              setState(() {
                                accountID = s;
                              });
                            },
                          ),
                          TextField(
                            decoration:
                                const InputDecoration(label: Text("Token")),
                            onChanged: (s) {
                              setState(() {
                                token = s;
                              });
                            },
                          ),
                          const SizedBox(height: 10),
                          Text(message)
                        ],
                      ),
                    );
                  });
                },
              );
            },
          )
        ],
      )
    ]);
  }
}
