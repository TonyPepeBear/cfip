import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'data/images_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Cloudflare Images',
        theme: ThemeData(
          primarySwatch: Colors.orange,
        ),
        home: Scaffold(
            appBar: AppBar(
              title: const Text("Cloudflare Images"),
            ),
            drawer: Drawer(
                child: ListView(
              children: List.generate(
                  3,
                  (index) => ListTile(
                        title: Text(index.toString()),
                      )),
            )),
            body: const MyHomePage()));
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Provider.of<ImagesModel>(context, listen: false).reloadAllImages("1db38a9bdb2d1b51b647a83a8fe53fdc", "qg97Kmed-UpeHzRYLw5mhog4g7WEZJ8Cd-W-c2pn");
    // Provider.of<ImagesModel>(context, listen: false).reloadDeliverID("1db38a9bdb2d1b51b647a83a8fe53fdc", "qg97Kmed-UpeHzRYLw5mhog4g7WEZJ8Cd-W-c2pn");
    return ChangeNotifierProvider(
      create: (context) => ImagesModel.withInit("", ""),
      child: Center(
        child: Consumer<ImagesModel>(
          builder: (context, model, child) {
            if (model.deliveryID.isEmpty || model.images.isEmpty) {
              return Text(
                  model.deliveryID.isEmpty ? "Empty" : model.deliveryID);
            }
            return GridView.count(
                crossAxisCount: 3,
                children: model.images
                    .map(
                      (e) => Image.network(
                          "https://imagedelivery.net/${model.deliveryID}/${e.id}/public",
                          fit: BoxFit.cover),
                    )
                    .toList());
          },
        ),
      ),
    );
  }
}
