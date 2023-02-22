import 'package:Perso/app/model/training_category/category_widget.dart';
import 'package:Perso/app/model/training_category/training_category.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

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
        Column(
            children: categoriesShortList
                .map((category) =>
                    CategoryWidget(picture: category.icon, text: category.text))
                .toList()),
        Container(
          height: 320,
          width: 300,
          child: PageView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 2,
              pageSnapping: true,
              itemBuilder: (context, pagePosition) {
                return Container(
                    margin: EdgeInsets.all(10),
                    child: Image.network(images[pagePosition]));
              }),
        )
      ])),
    );
  }
}

List<String> images = [
  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQTIZccfNPnqalhrWev-Xo7uBhkor57_rKbkw&usqp=CAU",
  "https://wallpaperaccess.com/full/2637581.jpg"
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
