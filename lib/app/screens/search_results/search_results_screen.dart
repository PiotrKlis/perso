import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:perso/app/styleguide/styleguide.dart';
import 'package:perso/app/widgets/app_bar/icon_action.dart';
import 'package:perso/app/widgets/app_bar/perso_app_bar.dart';
import 'package:perso/app/widgets/search/trainers/bloc/search_trainers_bloc.dart';
import 'package:perso/app/widgets/search/trainers/perso_trainers_search.dart';
import 'package:perso/app/widgets/trainers_list/perso_trainers_list.dart';
import 'package:perso/app/widgets/trainers_search_carousel/perso_trainers_search_carousel.dart';
import 'package:perso/core/extensions/context_extensions.dart';
import 'package:perso/core/navigation/screen_navigation_key.dart';

class SearchResultsScreen extends StatelessWidget {
  const SearchResultsScreen({required String input, super.key})
      : _input = input;
  final String _input;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SearchTrainersBloc>(
      create: (context) => SearchTrainersBloc(),
      child: _SearchResultsScreenContent(
        input: _input,
      ),
    );
  }
}

class _SearchResultsScreenContent extends StatelessWidget {
  const _SearchResultsScreenContent({required String input}) : _input = input;
  final String _input;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PersoColors.lightBlue,
      appBar: PersoAppBar(
        title: context.strings.search_results,
        iconActions: [
          IconAction(
            iconData: Icons.filter_list,
            onActionIconClick: onActionClick,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // TODO: Show 10 trainers, then load another 10 more on scroll
            Container(
              margin: const EdgeInsets.only(
                top: Dimens.mMargin,
                left: Dimens.mMargin,
                right: Dimens.mMargin,
              ),
              child: PersoTrainersSearch(initialText: _input),
            ),
            Container(
              margin: const EdgeInsets.only(top: Dimens.xmMargin),
              child: const PersoTrainersList(),
            ),
            Container(
              margin: const EdgeInsets.only(
                top: Dimens.xmMargin,
                left: Dimens.xmMargin,
              ),
              child: Text(
                context.strings.similar_trainers,
                style: ThemeText.mediumTitleBold,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: Dimens.xmMargin),
              child: const PersoTrainersSearchCarousel(),
            ),
          ],
        ),
      ),
    );
  }

  void onActionClick(BuildContext context) {
    context.pushNamed(
      ScreenNavigationKey.searchFilter,
      pathParameters: {'input': _input ?? ''},
    );
  }
}
