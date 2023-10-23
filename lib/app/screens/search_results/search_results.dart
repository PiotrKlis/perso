import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:perso/app/styleguide/styleguide.dart';
import 'package:perso/app/utils/extension/context_extensions.dart';
import 'package:perso/app/widgets/perso_app_bar.dart';
import 'package:perso/app/widgets/trainers_list/perso_trainers_list.dart';
import 'package:perso/app/widgets/trainers_search_carousel/perso_trainers_search_carousel.dart';
import 'package:perso/core/navigation/screen_navigation_key.dart';

class SearchResultsScreen extends StatelessWidget {
  const SearchResultsScreen({super.key, String? input = ""}) : _input = input;
  final String? _input;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: PersoColors.lightBlue,
        appBar: PersoAppBar(
          title: context.strings.search_results,
          actionIcon: Icons.filter_list,
          onActionIconClick: onActionClick,
        ),
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // TODO: Show 10 trainers, then load another 10 more on scroll
                Container(
                  margin: const EdgeInsets.only(
                      top: Dimens.mMargin, left: Dimens.mMargin),
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
                    margin: const EdgeInsets.only(top: Dimens.mMargin),
                    child: const PersoTrainersList()),
                Container(
                  margin: const EdgeInsets.only(
                      top: Dimens.mMargin, left: Dimens.mMargin),
                  child: Text(
                    context.strings.similar_trainers,
                    style: ThemeText.mediumTitleBold,
                  ),
                ),
                Container(
                    margin: const EdgeInsets.only(top: Dimens.mMargin),
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
