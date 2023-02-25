import 'package:Perso/app/home/widget/perso_account_icon.dart';
import 'package:Perso/app/model/training_category/category_widget.dart';
import 'package:Perso/app/model/training_category/training_category.dart';
import 'package:Perso/app/utils/dimens.dart';
import 'package:Perso/app/utils/theme_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
            elevation: Dimens.noElevation,
            backgroundColor: Colors.white,
            leading: const PersoAccountIcon()),
        body: SingleChildScrollView(
          child: Column(children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Container(
                  margin: const EdgeInsets.only(left: Dimens.normalMargin),
                  child: Text("Explore", style: ThemeText.largerTitleBold)),
              Container(
                  margin: const EdgeInsets.only(right: Dimens.normalMargin),
                  width: 128,
                  height: 50,
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(48.0))),
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(shape: const StadiumBorder(), backgroundColor: Colors.black),
                      onPressed: () {},
                      child: Text(
                        "For trainers",
                        style: ThemeText.bodyBoldWhiteText,
                      ))),
            ]),
            PlatformTextField(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [Text("Categories"), Text("See All")],
            ),
            Column(
                children: categoriesShortList
                    .map((category) => CategoryWidget(
                        picture: category.icon, text: category.text))
                    .toList()),
            SizedBox(
              height: 300,
              child: PageView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 3,
                  padEnds: false,
                  controller: PageController(viewportFraction: 0.8),
                  pageSnapping: true,
                  itemBuilder: (context, pagePosition) {
                    return Container(
                        width: 320,
                        margin: getPageViewCardMargin(pagePosition),
                        child: Card(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: const [
                              Image(
                                  image: AssetImage(
                                      'assets/dummy_category_2.png')),
                              Text("YOGA TRAINERS"),
                            ],
                          ),
                        ));
                  }),
            )
          ]),
        ));
  }
}

//     Image(
//                           image: AssetImage('assets/dummy_category_1.png')),

EdgeInsets getPageViewCardMargin(int position) {
  if (position == images.length - 1) {
    return const EdgeInsets.only(left: 8.0, right: 8.0);
  } else {
    return const EdgeInsets.only(left: 8.0);
  }
}

List<String> images = [
  "assets/dummy_category_image.png",
  "assets/dummy_category_image.png",
  "assets/dummy_category_image.png"
];

class MySearchDelegate extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    // TODO: implement buildActions
    throw UnimplementedError();
  }

  @override
  Widget? buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    throw UnimplementedError();
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    throw UnimplementedError();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions
    throw UnimplementedError();
  }
}
