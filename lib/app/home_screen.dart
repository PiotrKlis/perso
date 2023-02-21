import 'package:Perso/app/training_category.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SafeArea(
          child: Column(children: [
        Row(
          children: const [
            Padding(
              padding: EdgeInsets.only(left: 16.0, top: 32.0),
              child: Icon(
                Icons.account_circle_rounded,
                size: 40.0,
              ),
            ),
          ],
        ),
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          PlatformText("Explore"),
          PlatformElevatedButton(child: const Text("For trainers")),
        ]),
        PlatformTextField(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [Text("Categories"), Text("See All")],
        ),
        ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),            padding: const EdgeInsets.all(8),
            itemCount: categoriesShortList.length,
            itemBuilder: (BuildContext context, int index) {
              return Row(
                children: [
                  categoriesShortList[index].icon,
                  categoriesShortList[index].name
                ],
              );
            })
      ])),
    );
  }
}

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
