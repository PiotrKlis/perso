import 'package:Perso/app/home/widgets/perso_account_icon.dart';
import 'package:Perso/app/utils/constants.dart';
import 'package:Perso/app/utils/dimens.dart';
import 'package:Perso/app/widgets/perso_big_header.dart';
import 'package:Perso/app/widgets/perso_button.dart';
import 'package:Perso/app/widgets/perso_clickable_text.dart';
import 'package:Perso/app/widgets/perso_header.dart';
import 'package:Perso/app/widgets/perso_search.dart';
import 'package:Perso/app/widgets/perso_training_category_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(children: [
          const PersoAccountIcon(),
          Container(
            margin: const EdgeInsets.only(
                top: Dimens.normalMargin,
                left: Dimens.normalMargin,
                right: Dimens.normalMargin),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  PersoBigHeader(
                    title: AppLocalizations.of(context)!.home_main_header,
                  ),
                  PersoButton(
                      title:
                          AppLocalizations.of(context)!.trainers_section_button,
                      width: Dimens.smallButtonWidth)
                ]),
          ),
          Container(
              margin: const EdgeInsets.only(
                  left: Dimens.normalMargin,
                  top: Dimens.normalMargin,
                  right: Dimens.normalMargin),
              child: const PersoSearch()),
          Container(
            margin: const EdgeInsets.only(
                top: Dimens.bigMargin,
                left: Dimens.normalMargin,
                right: Dimens.normalMargin),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                PersoHeader(
                    title: AppLocalizations.of(context).category_header),
                PersoClickableText(
                    title: AppLocalizations.of(context).see_all_categories)
              ],
            ),
          ),
          Container(
              margin: const EdgeInsets.only(left: Dimens.normalMargin),
              child: const PersoTrainingCategoryList(rowNumber: Constants.trainingCategoryShortListNumber)),
          SizedBox(
            height: 300,
            child: PageView.builder(
                itemCount: 3,
                padEnds: false,
                controller: PageController(viewportFraction: 0.8),
                itemBuilder: (context, pagePosition) {
                  return Container(
                      width: 320,
                      margin: getPageViewCardMargin(pagePosition),
                      child: Card(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: const [
                            Image(
                                image:
                                    AssetImage('assets/dummy_category_2.png')),
                            Text("YOGA TRAINERS"),
                          ],
                        ),
                      ));
                }),
          ),
        ]),
      ),
    );
  }
}

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
