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
    return ChangeNotifierProvider(
      create: (context) => ImagesModel.withInit("", ""),
      child: Center(
        child: Consumer<ImagesModel>(
          builder: (context, model, child) {
            if (model.deliveryID.isEmpty || model.images.isEmpty) {
              return Text(
                  model.deliveryID.isEmpty ? "Empty" : model.deliveryID);
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
                  return Image.network(
                      "https://imagedelivery.net/${model.deliveryID}/${model.images[index].id}/public",
                      fit: BoxFit.cover);
                });
          },
        ),
      ),
    );
  }
}
