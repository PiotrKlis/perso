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
          mainAxisSize: MainAxisSize.max,
          children: [
            Divider(
              thickness: Dimens.dividerThickness
            ),
            Container(
              margin: EdgeInsets.only(
                top: 26,
                left: 24,
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
            Divider(
              thickness: Dimens.dividerThickness
            ),
            Container(
              margin: EdgeInsets.only(top: 26, left: 24),
              child: Text(
                AppLocalizations.of(context)!.location,
                style: ThemeText.bodyBoldBlackText,
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 24, top: 2, bottom: 26),
              child: Row(
                children: [Text("By default it is set to My country")],
              ),
            ),
            Divider(
              thickness: Dimens.dividerThickness
            ),
            Container(
              margin: EdgeInsets.only(top: 26, left: 24),
              child: Row(
                children: <Widget>[
                  Text(AppLocalizations.of(context)!.rating, style: ThemeText.bodyBoldBlackText),
                  Container(
                    margin: EdgeInsets.only(left: Dimens.bigMargin, bottom: 26),
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
            Divider(
              thickness: Dimens.dividerThickness),
            Container(
                margin: EdgeInsets.only(top: 26, left: 24),
                child: Text(
                  AppLocalizations.of(context)!.specialities,
                  style: ThemeText.bodyBoldBlackText,
                )),
            Container(
              margin: EdgeInsets.only(top: Dimens.bigMargin, bottom: 26),
              child: PersoCategoryChips(),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  margin: EdgeInsets.only(bottom: 35),
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
