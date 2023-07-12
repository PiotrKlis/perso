import 'package:Perso/app/utils/colors.dart';
import 'package:Perso/app/utils/dimens.dart';
import 'package:Perso/app/widgets/PersoAppBar.dart';
import 'package:Perso/core/navigation/screen_navigation_key.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({super.key});

  final List<String> _emptySearch = [
    "Best Yoga trainers",
    "Best trainers in your area",
    "Calisthenics",
    "No equipment",
    "Bodybuilding",
    "Best Yoga trainers",
    "Best trainers in your area",
    "Calisthenics",
    "No equipment",
    "Bodybuilding",
    "Best Yoga trainers",
    "Best trainers in your area",
    "Calisthenics",
    "No equipment",
    "Bodybuilding"
  ];

  final TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: PersoColors.lightBlue,
        appBar: const PersoAppBar(title: "Search screen"),
        body: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(
                  top: Dimens.bigMargin,
                  left: Dimens.normalMargin,
                  right: Dimens.normalMargin),
              //TODO: Probably will need to migrate to TextEdit to use onFieldSubmitted
              child: TextField(
                  decoration: InputDecoration(
                    hintText: "Search",
                    filled: true,
                    fillColor: Colors.white,
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(
                            width: 0.2, color: PersoColors.lightGrey)),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide:
                          BorderSide(width: 0.2, color: PersoColors.lightGrey),
                    ),
                  ),
                  onSubmitted: (input) {
                    //no-op
                  }),
            ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(top: Dimens.bigMargin),
                color: Colors.white,
                child: ListView.separated(
                  itemCount: _emptySearch.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                        onTap: () => context.pushNamed(
                            ScreenNavigationKey.searchResults,
                            pathParameters: {"input": _emptySearch[index]}),
                        title: Text(
                          _emptySearch[index],
                        ));
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    // Build your separator widget here
                    return const Divider(
                      color: Colors.grey,
                      thickness: 1.0,
                    );
                  },
                ),
              ),
            ),
          ],
        ));
  }
}
