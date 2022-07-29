import 'package:cfip/cloudflare_images.dart';
import 'package:cfip/main_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:settings_ui/settings_ui.dart';

class SettingFragment extends StatefulWidget {
  const SettingFragment({Key? key}) : super(key: key);

  @override
  State<SettingFragment> createState() => _SettingFragmentState();
}

class _SettingFragmentState extends State<SettingFragment> {
  @override
  Widget build(BuildContext context) {
    var mainModel = context.watch<MainModel>();
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
            value:
                Text((mainModel.loggedIn == 1) ? mainModel.accountID : "False"),
            onPressed: (context) {
              String accountID = "";
              String token = "";
              bool ok = false;
              String message = "";
              if (mainModel.loggedIn == 1) {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text("Logout?"),
                        actions: [
                          TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text("Cancel")),
                          TextButton(
                              onPressed: () {
                                mainModel.logout();
                                Navigator.pop(context);
                              },
                              child: const Text("OK"))
                        ],
                      );
                    });
              } else {
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
                              CloudflareImages.validAccount(accountID, token)
                                  .then((v) {
                                setState(() {
                                  if (v) {
                                    ok = true;
                                    message = "Account Valid";
                                  } else {
                                    v = false;
                                    message = "Account Invalid";
                                  }
                                });
                              });
                            },
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text("Cancel"),
                          ),
                          TextButton(
                            onPressed: ok
                                ? () {
                                    mainModel.saveLoginData(accountID, token);
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
                              decoration: const InputDecoration(
                                  label: Text("AccountID")),
                              onChanged: (s) {
                                setState(() {
                                  accountID = s;
                                  ok = false;
                                });
                              },
                            ),
                            TextField(
                              decoration:
                                  const InputDecoration(label: Text("Token")),
                              onChanged: (s) {
                                setState(() {
                                  token = s;
                                  ok = false;
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
              }
            },
          )
        ],
      )
    ]);
  }
}
