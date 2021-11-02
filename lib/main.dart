import 'package:cfip/data/cfi_api.dart';
import 'package:cfip/data/cfimage.dart';
import 'package:flutter/material.dart';

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
    return Center(
      child: FutureBuilder<List<CFImage>>(
        future: getAllImages("accountID", "token"),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text("error!");
          }
          if (!snapshot.hasData) {
            return const Text("Waiting");
          }
          var data = snapshot.data!;
          data.sort((a, b) =>
              b.uploaded.millisecondsSinceEpoch -
              a.uploaded.millisecondsSinceEpoch);
          return GridView.count(
              crossAxisCount: 3,
              children: data
                  .map((e) => Image.network(
                      "https://imagedelivery.net/url/${e.id}/public",
                      fit: BoxFit.cover))
                  .toList());
        },
      ),
    );
  }
}
