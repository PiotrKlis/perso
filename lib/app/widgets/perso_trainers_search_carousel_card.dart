import 'package:Perso/app/model/trainers_search_carousel_data/trainers_search_carousel_card_data.dart';
import 'package:Perso/app/utils/dimens.dart';
import 'package:Perso/app/utils/theme_text.dart';
import 'package:flutter/material.dart';

class PersoTrainersSearchCarouselCard extends StatelessWidget {
  final int position;
  final TrainersSearchCarouselCardData cardData;

  PersoTrainersSearchCarouselCard(
      {super.key, required this.position, required this.cardData});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: Dimens.carouselCardWidth,
        margin: getPageViewCardMargin(position),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10)
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(cardData.image, fit: BoxFit.fitWidth),
              Container(
                  margin: const EdgeInsets.only(
                      top: Dimens.normalMargin, left: Dimens.normalMargin),
                  child: Text(cardData.categoryName,
                      style: ThemeText.captionSmallRegularGrey)),
              Text(cardData.title),
              Text(cardData.subtitle),
            ],
          ),
        ));
  }

  EdgeInsets getPageViewCardMargin(int position) {
    if (position == dummyCards.length - 1) {
      return const EdgeInsets.only(left: 8.0, right: 8.0);
    } else {
      return const EdgeInsets.only(left: 8.0);
    }
  }
}
