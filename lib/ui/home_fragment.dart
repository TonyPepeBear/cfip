import 'package:cfip/main_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class HomeFragment extends StatefulWidget {
  const HomeFragment({Key? key}) : super(key: key);

  @override
  State<HomeFragment> createState() => _HomeFragmentState();
}

class _HomeFragmentState extends State<HomeFragment> {
  var listController = ScrollController();
  int allowCount = 0;
  void Function()? fetchMoreImages;

  @override
  void initState() {
    listController.addListener(() {
      if (listController.position.pixels >=
          listController.position.maxScrollExtent) {
        if (fetchMoreImages != null) {
          print("get Image");
          fetchMoreImages!();
        }
        ;
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    listController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    allowCount = context.watch<MainModel>().allowedCount;
    fetchMoreImages = context.watch<MainModel>().fetchMoreImages;
    var local = AppLocalizations.of(context)!;
    var images = context.watch<MainModel>().images;
    var accountID = context.watch<MainModel>().accountID;
    var homeMessage = context.watch<MainModel>().homeMessage;
    return Center(
      child: GridView.builder(
        itemCount: images.length,
        controller: listController,
        itemBuilder: (context, index) {
          return Image.network(context.read<MainModel>().getImageURL(index));
        },
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
      ),
    );
  }
}
