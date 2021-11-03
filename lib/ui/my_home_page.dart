import 'package:animations/animations.dart';
import 'package:cfip/data/images_model.dart';
import 'package:cfip/data/settings_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SettingsModel settingsModel = Provider.of<SettingsModel>(context);
    ImagesModel imagesModel = Provider.of<ImagesModel>(context);
    settingsModel.addListener(() {
      imagesModel.reloadAll(settingsModel.accountID, settingsModel.token);
    });
    return Center(
      child: Consumer<ImagesModel>(
        builder: (context, model, child) {
          if (model.deliveryID.isEmpty || model.images.isEmpty) {
            return Text(model.deliveryID.isEmpty ? "Empty" : model.deliveryID);
          }
          return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3),
              itemCount: model.images.length + 1,
              itemBuilder: (context, index) {
                if (index >= model.images.length) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text("Total"),
                      Text(model.images.length.toString())
                    ],
                  );
                }
                return OpenContainer(
                  closedBuilder: (context, _) {
                    return Image.network(
                        "https://imagedelivery.net/${model.deliveryID}/${model.images[index].id}/public",
                        fit: BoxFit.cover);
                  },
                  openBuilder: (context, _) {
                    return Scaffold(
                      appBar: AppBar(title: const Text("Cloudflare Images")),
                      body: Center(
                        child: Column(
                          children: [
                            Image.network(
                                "https://imagedelivery.net/${model.deliveryID}/${model.images[index].id}/public",
                                fit: BoxFit.contain),
                          ],
                        ),
                      ),
                    );
                  },
                );
              });
        },
      ),
    );
  }
}
