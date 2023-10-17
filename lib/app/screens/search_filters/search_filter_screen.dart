import 'package:Perso/app/utils/colors.dart';
import 'package:Perso/app/utils/dimens.dart';
import 'package:Perso/app/utils/theme_text.dart';
import 'package:Perso/app/widgets/category_chips/category_chips.dart';
import 'package:Perso/app/widgets/perso_app_bar.dart';
import 'package:Perso/app/widgets/perso_button.dart';
import 'package:flutter/material.dart';
import 'package:Perso/app/widgets/spoken_language_row.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:Perso/app/widgets/perso_divider.dart';

class SearchFilterScreen extends StatelessWidget {
  const SearchFilterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: PersoAppBar(
          title: AppLocalizations.of(context)!.filters,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PersoDivider(),
            Container(
              margin: EdgeInsets.only(
                top: Dimens.normalMargin,
                left: Dimens.bigMargin,
              ),
              child: Text(
                AppLocalizations.of(context)!.spoken_languages,
                style: ThemeText.bodyBoldBlackText,
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                  top: Dimens.smallMargin, left: Dimens.normalMargin),
              child: SpokenLanguageRowWidget(),
            ),
            PersoDivider(),
            Container(
              margin: EdgeInsets.only(
                  top: Dimens.normalMargin, left: Dimens.bigMargin),
              child: Text(
                AppLocalizations.of(context)!.location,
                style: ThemeText.bodyBoldBlackText,
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                  left: Dimens.bigMargin,
                  top: Dimens.smallerMargin,
                  bottom: Dimens.bigMargin),
              child: Row(
                children: [Text(AppLocalizations.of(context)!.location_default_set)],
              ),
            ),
            PersoDivider(),
            Container(
              margin: EdgeInsets.only(
                  top: Dimens.normalMargin,
                  left: Dimens.bigMargin,
                  bottom: Dimens.normalMargin),
              child: Row(
                children: [
                  Text(AppLocalizations.of(context)!.rating,
                      style: ThemeText.bodyBoldBlackText),
                  Container(
                    margin: EdgeInsets.only(left: Dimens.bigMargin),
                    child: RatingBar(
                      allowHalfRating: true,
                      ratingWidget: RatingWidget(
                          full: const Icon(Icons.star, color: Colors.yellow),
                          half:
                              const Icon(Icons.star_half, color: Colors.yellow),
                          empty: const Icon(Icons.star_border,
                              color: Colors.yellow)),
                      onRatingUpdate: (value) {
                        //no-op
                      },
                    ),
                  )
                ],
              ),
            ),
            PersoDivider(),
            Container(
                margin: EdgeInsets.only(
                    top: Dimens.normalMargin, left: Dimens.bigMargin),
                child: Text(
                  AppLocalizations.of(context)!.specialities,
                  style: ThemeText.bodyBoldBlackText,
                )),
            Container(
              margin: EdgeInsets.only(
                  top: Dimens.bigMargin,
                  left: Dimens.bigMargin,
                  bottom: Dimens.bigMargin),
              child: PersoCategoryChips(),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  margin: EdgeInsets.only(bottom: Dimens.biggerMargin),
                  child: PersoButton(
                    width: Dimens.bigButtonWidth,
                    title: AppLocalizations.of(context)!.apply_filtres_button,
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
