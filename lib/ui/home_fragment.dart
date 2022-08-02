import 'package:cached_network_image/cached_network_image.dart';
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
    var mainModel = context.watch<MainModel>();
    var imageIDs = mainModel.images;
    var accountID = mainModel.accountID;
    var loggedIn = mainModel.loggedIn;
    if (loggedIn == 0) {
      // Loading
      return const Center(child: CircularProgressIndicator());
    }
    if (loggedIn == -1) {
      // login fail
      return const Center(
        child: Text("Please check your settings"),
      );
    }
    return Center(
      child: GridView.builder(
        itemCount: imageIDs.length,
        controller: listController,
        itemBuilder: (context, index) {
          return CachedNetworkImage(
            imageUrl: mainModel.getImageURL(index),
            placeholder: (context, url) => const CircularProgressIndicator(),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          );
        },
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
      ),
    );
  }
}
