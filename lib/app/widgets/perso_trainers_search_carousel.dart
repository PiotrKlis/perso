import 'package:Perso/app/model/trainers_search_carousel_data/trainers_search_carousel_card_data.dart';
import 'package:Perso/app/utils/dimens.dart';
import 'package:Perso/app/widgets/perso_trainers_search_carousel_card.dart';
import 'package:flutter/material.dart';

class PersoTrainersSearchCarousel extends StatelessWidget {
  PersoTrainersSearchCarousel({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Dimens.carouselCardHeight,
      child: PageView.builder(
          itemCount: dummyCards.length,
          padEnds: false,
          controller:
              PageController(viewportFraction: Dimens.carouselViewportFraction),
          itemBuilder: (context, pagePosition) {
            return PersoTrainersSearchCarouselCard(
                position: pagePosition, cardData: dummyCards[pagePosition]);
          }),
    );
  }
}
