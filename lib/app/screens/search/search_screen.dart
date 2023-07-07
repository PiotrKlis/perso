import 'package:Perso/app/utils/colors.dart';
import 'package:Perso/app/utils/dimens.dart';
import 'package:Perso/app/utils/theme_text.dart';
import 'package:Perso/app/widgets/PersoAppBar.dart';
import 'package:Perso/app/widgets/perso_divider.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: PersoColors.lightBlue,
        appBar: PersoAppBar(title: "Search screen"),
        body: Column(
          children: [
            Container(
                margin: EdgeInsets.only(
                    top: Dimens.bigMargin,
                    left: Dimens.normalMargin,
                    right: Dimens.normalMargin),
                child: SearchBar()),
            Container(
                margin: EdgeInsets.only(top: Dimens.bigMargin),
                child: Divider()),
            Expanded(
              child: ListView.separated(
                itemCount: 3,
                itemBuilder: (BuildContext context, int index) {
                  // Build your list item widget here
                  return ListTile(
                      title: Text(
                    "[$index])",
                    // Other ListTile properties...
                  ));
                },
                separatorBuilder: (BuildContext context, int index) {
                  // Build your separator widget here
                  return Divider(
                    color: Colors.grey,
                    thickness: 1.0,
                  );
                },
              ),
            )
          ],
        ));
  }
}
