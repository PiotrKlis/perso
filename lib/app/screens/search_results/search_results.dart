import 'package:Perso/app/utils/colors.dart';
import 'package:Perso/app/utils/dimens.dart';
import 'package:Perso/app/utils/theme_text.dart';
import 'package:Perso/app/widgets/PersoAppBar.dart';
import 'package:Perso/app/widgets/trainers_list/perso_trainers_list.dart';
import 'package:Perso/app/widgets/trainers_search_carousel/perso_trainers_search_carousel.dart';
import 'package:Perso/core/navigation/screen_navigation_key.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SearchResultsScreen extends StatelessWidget {
  const SearchResultsScreen({super.key, String? input = ""}) : _input = input;
  final String? _input;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: PersoColors.lightBlue,
        appBar: PersoAppBar(
          title: "Search results",
          actionIcon: Icons.filter_list,
          onActionIconClick: onActionClick,
        ),
        body: SingleChildScrollView(
          child: Container(
            // margin: EdgeInsets.all(Dimens.normalMargin),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // TODO: Show 10 trainers, then load another 10 more on scroll
                Container(
                  margin: const EdgeInsets.only(
                      top: Dimens.normalMargin, left: Dimens.normalMargin),
                  child: Row(
                    children: [
                      Expanded(
                        child: RichText(
                          text: TextSpan(
                              text: "\"$_input\"",
                              style: ThemeText.mediumTitleBold,
                              children: [
                                TextSpan(
                                  text: " (1)",
                                  style: ThemeText.mediumTitleRegular,
                                )
                              ]),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                    margin: const EdgeInsets.only(top: Dimens.normalMargin),
                    child: const PersoTrainersList()),
                Container(
                  margin: const EdgeInsets.only(
                      top: Dimens.normalMargin, left: Dimens.normalMargin),
                  child: Text(
                    "Similar trainers",
                    style: ThemeText.mediumTitleBold,
                  ),
                ),
                Container(
                    margin: const EdgeInsets.only(top: Dimens.normalMargin),
                    child: PersoTrainersSearchCarousel())
              ],
            ),
          ),
        ));
  }

  void onActionClick(BuildContext context) {
    context.pushNamed(ScreenNavigationKey.searchFilter,
        pathParameters: {"input": _input ?? ""});
  }
}
