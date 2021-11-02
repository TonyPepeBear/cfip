import 'package:cfip/data/images_model.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                return Image.network(
                    "https://imagedelivery.net/${model.deliveryID}/${model.images[index].id}/public",
                    fit: BoxFit.cover);
              });
        },
      ),
    );
  }
}
