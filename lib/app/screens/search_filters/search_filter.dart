import 'package:Perso/app/utils/colors.dart';
import 'package:Perso/app/utils/dimens.dart';
import 'package:Perso/app/utils/theme_text.dart';
import 'package:Perso/app/widgets/perso_app_bar.dart';
import 'package:Perso/app/widgets/perso_button.dart';
import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'package:Perso/app/widgets/spoken_language_row.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
=======
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
>>>>>>> 1e3d8368917abe0e107168ded3690e32abd7df88

class SearchFilterScreen extends StatelessWidget {
  const SearchFilterScreen({super.key});

  @override
  Widget build(BuildContext context) {
<<<<<<< HEAD
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: PersoAppBar(
          title: "Filters", 
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              margin: EdgeInsets.only(
                top: 32,
                left: 24,
              ),
              child: Text(
                "Spoken Languages",
                style: ThemeText.bodyBoldBlackText, 
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                  top: Dimens.smallMargin, left: Dimens.normalMargin),
              child: SpokenLanguageRowWidget(), 
            ),
            Container(
              margin: EdgeInsets.only(top: 56, left: 24),
              child: Text(
                "Location",
                style: ThemeText.bodyBoldBlackText,
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 24, top: 2),
              child: Row(
                children: [Text("By default it is set to My country")],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 58, left: 24),
              child: Row(
                children: <Widget>[
                  Text(
                    "Rating",
                    style: ThemeText.bodyBoldBlackText
                    ),
                  Container(
                    margin: EdgeInsets.only(left: Dimens.bigMargin),
                    child: RatingBar(
                                allowHalfRating: true,
                                  ratingWidget: RatingWidget(
                      full: const Icon(Icons.star, color: Colors.yellow),
                      half: const Icon(Icons.star_half, color: Colors.yellow),
                      empty:
                          const Icon(Icons.star_border, color: Colors.yellow)),
                                  onRatingUpdate: (value) {
                     //no-op
                                  },
                                 ),
                  )
                ],
              ),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  margin: EdgeInsets.only(bottom: 40),
                  child: PersoButton(
                    width: Dimens.bigButtonWidth,
                    title: "Apply Filtres",
                  ),
                ),
              ),
            )
          ],
        ));
=======
    return  Scaffold(
        backgroundColor: PersoColors.lightBlue,
        appBar: PersoAppBar(
          title: AppLocalizations.of(context)!.search_filter,
        ),
        body: Center(child: Text(AppLocalizations.of(context)!.search_filter_screen)));
>>>>>>> 1e3d8368917abe0e107168ded3690e32abd7df88
  }
}
