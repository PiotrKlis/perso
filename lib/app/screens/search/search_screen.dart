import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:perso/app/styleguide/styleguide.dart';
import 'package:perso/app/utils/extension/context_extensions.dart';
import 'package:perso/app/widgets/perso_app_bar.dart';
import 'package:perso/app/widgets/perso_search.dart';
import 'package:perso/core/navigation/screen_navigation_key.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({super.key});

  final List<String> _emptySearch = [
    'Best Yoga trainers',
    'Best trainers in your area',
    'Calisthenics',
    'No equipment',
    'Bodybuilding',
    'Best Yoga trainers',
    'Best trainers in your area',
    'Calisthenics',
    'No equipment',
    'Bodybuilding',
    'Best Yoga trainers',
    'Best trainers in your area',
    'Calisthenics',
    'No equipment',
    'Bodybuilding',
  ];

  final TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: PersoColors.lightWhite,
        appBar: PersoAppBar(title: context.strings.search),
        body: Column(
          children: [
            Container(
                margin: const EdgeInsets.only(
                    top: Dimens.normalMargin,
                    left: Dimens.normalMargin,
                    right: Dimens.normalMargin,),
                //TODO: Probably will need to migrate to TextEdit to use onFieldSubmitted
                child: const PersoSearch(),),
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(top: Dimens.normalMargin),
                color: Colors.white,
                child: ListView.separated(
                  itemCount: _emptySearch.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                        contentPadding:
                            const EdgeInsets.only(left: Dimens.biggerMargin),
                        onTap: () => context.pushNamed(
                            ScreenNavigationKey.searchResults,
                            pathParameters: {'input': _emptySearch[index]},),
                        title: Text(
                          _emptySearch[index],
                        ),);
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return Container(
                      margin: const EdgeInsets.only(
                          left: Dimens.normalMargin,
                          right: Dimens.normalMargin,),
                      child: const Divider(
                        thickness: Dimens.dividerThickness,
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),);
  }
}
