import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:perso/app/styleguide/value/app_dimens.dart';
import 'package:perso/app/styleguide/value/app_typography.dart';
import 'package:perso/app/widgets/category_chips/perso_selectable_category_chips.dart';
import 'package:perso/app/widgets/perso_app_bar.dart';
import 'package:perso/app/widgets/perso_button.dart';
import 'package:perso/app/widgets/perso_divider.dart';
import 'package:perso/app/widgets/spoken_language_row.dart';

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
          const PersoDivider(),
          Container(
            margin: const EdgeInsets.only(
              top: Dimens.xmMargin,
              left: Dimens.lMargin,
            ),
            child: Text(
              AppLocalizations.of(context)!.languages,
              style: ThemeText.bodyBoldBlackText,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(
              top: Dimens.xsMargin,
              left: Dimens.xmMargin,
            ),
            child: SpokenLanguageRowWidget(),
          ),
          const PersoDivider(),
          Container(
            margin: const EdgeInsets.only(
              top: Dimens.xmMargin,
              left: Dimens.lMargin,
            ),
            child: Text(
              AppLocalizations.of(context)!.address,
              style: ThemeText.bodyBoldBlackText,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(
              left: Dimens.lMargin,
              top: Dimens.sMargin,
              bottom: Dimens.lMargin,
            ),
            child: Row(
              children: [
                Text(AppLocalizations.of(context)!.location_default_set),
              ],
            ),
          ),
          const PersoDivider(),
          Container(
            margin: const EdgeInsets.only(
              top: Dimens.xmMargin,
              left: Dimens.lMargin,
              bottom: Dimens.xmMargin,
            ),
            child: Row(
              children: [
                Text(
                  AppLocalizations.of(context)!.rating,
                  style: ThemeText.bodyBoldBlackText,
                ),
                Container(
                  margin: const EdgeInsets.only(left: Dimens.lMargin),
                  child: RatingBar(
                    allowHalfRating: true,
                    ratingWidget: RatingWidget(
                      full: const Icon(Icons.star, color: Colors.yellow),
                      half: const Icon(Icons.star_half, color: Colors.yellow),
                      empty: const Icon(
                        Icons.star_border,
                        color: Colors.yellow,
                      ),
                    ),
                    onRatingUpdate: (value) {
                      //no-op
                    },
                  ),
                ),
              ],
            ),
          ),
          const PersoDivider(),
          Container(
            margin: const EdgeInsets.only(
              top: Dimens.xmMargin,
              left: Dimens.lMargin,
            ),
            child: Text(
              AppLocalizations.of(context)!.specialities,
              style: ThemeText.bodyBoldBlackText,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(
              top: Dimens.lMargin,
              left: Dimens.lMargin,
              bottom: Dimens.lMargin,
            ),
            child: PersoSelectableCategoryChips(),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: const EdgeInsets.only(
                  bottom: Dimens.xlMargin,
                  left: Dimens.xmMargin,
                  right: Dimens.xmMargin,
                ),
                child: PersoButton(
                  title: AppLocalizations.of(context)!.confirm,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
