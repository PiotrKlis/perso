import 'package:Perso/app/home/widget/perso_account_icon.dart';
import 'package:Perso/app/model/training_category/category_widget.dart';
import 'package:Perso/app/model/training_category/training_category.dart';
import 'package:Perso/app/util/dimens.dart';
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
          leading: const PersoAccountIcon()
        ),
        body: SingleChildScrollView(
          child: Column(children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              PlatformText("Explore"),
              PlatformElevatedButton(child: const Text("For trainers")),
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
