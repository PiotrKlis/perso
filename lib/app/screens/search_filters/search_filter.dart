import 'package:Perso/app/utils/colors.dart';
import 'package:Perso/app/utils/dimens.dart';
import 'package:Perso/app/utils/theme_text.dart';
import 'package:Perso/app/widgets/perso_app_bar.dart';
import 'package:Perso/app/widgets/perso_button.dart';
import 'package:flutter/material.dart';
import 'package:Perso/app/widgets/spoken_language_row.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class SearchFilterScreen extends StatelessWidget {
  const SearchFilterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: PersoColors.lightBlue,
        appBar: PersoAppBar(
          title: "Filters", 
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              color: Colors.white,
              child: Column(
                              mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(
                      top: 82,
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
                    child: SpokenLanguageRowWidget(), alignment: Alignment.bottomCenter,
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 82, left: 24),
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
                    margin: EdgeInsets.only(top: 82, left: 24, bottom: 82),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Expanded(
                            child: Text(
                          "Rating",
                          style: TextStyle(
                            fontSize: 17,
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w600,
                            letterSpacing: -0.4,
                          ),
                        )),
                        Expanded(
                          child: RatingBar.builder(
                            initialRating: 0,
                            minRating: 1,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 5,
                            itemPadding: EdgeInsets.symmetric(horizontal: 0),
                            itemSize: 30,
                            itemBuilder: (context, _) => Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            onRatingUpdate: (rating) {
                              print(rating);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
                margin: EdgeInsets.only(
                  top: Dimens.hugeMargin,
                ),
                child: PersoButton(
                  title: "Apply Filtres",
                ))
          ],
        ));
  }
}
