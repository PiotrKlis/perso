import 'package:flutter/material.dart';
import 'package:perso/app/models/trainers_search_card_data/trainers_search_carousel_card_data.dart';
import 'package:perso/app/styleguide/styleguide.dart';

class PersoTrainersSearchCarouselCard extends StatelessWidget {

  const PersoTrainersSearchCarouselCard(
      {required this.position, required this.cardData, required this.isLastCard, super.key,});
  final int position;
  final TrainersSearchCarouselCardData cardData;
  final bool isLastCard;

  @override
  Widget build(BuildContext context) {
    final cardWithImageOnTheTop = [
      Image.asset(cardData.image),
      Container(
          margin: const EdgeInsets.only(
              top: Dimens.normalMargin, left: Dimens.normalMargin,),
          child: Text(cardData.categoryName,
              style: ThemeText.captionSmallRegularGrey,),),
      Container(
          margin: const EdgeInsets.only(
              top: Dimens.smallerMargin, left: Dimens.normalMargin,),
          child: Text(
            cardData.title,
            style: ThemeText.mediumTitleBold,
          ),),
      Container(
          margin: const EdgeInsets.only(
              top: Dimens.smallerMargin, left: Dimens.normalMargin,),
          child: Text(
            cardData.subtitle,
            style: ThemeText.footnoteRegular,
          ),),
    ];

    final cardWithImageOnTheBottom = [
      Container(
          margin: const EdgeInsets.only(
              top: Dimens.normalMargin, left: Dimens.normalMargin,),
          child: Text(cardData.categoryName,
              style: ThemeText.captionSmallRegularGrey,),),
      Container(
          margin: const EdgeInsets.only(
              top: Dimens.smallerMargin, left: Dimens.normalMargin,),
          child: Text(
            cardData.title,
            style: ThemeText.mediumTitleBold,
          ),),
      Container(
          margin: const EdgeInsets.only(
              top: Dimens.smallerMargin, left: Dimens.normalMargin,),
          child: Text(
            cardData.subtitle,
            style: ThemeText.footnoteRegular,
          ),),
      Container(
          margin: const EdgeInsets.only(top: Dimens.smallMargin),
          child: Image.asset(cardData.image, fit: BoxFit.fitHeight),),
    ];

    List<Widget> getContent(int position) {
      if (position.isOdd) {
        return cardWithImageOnTheBottom;
      } else {
        return cardWithImageOnTheTop;
      }
    }

    return Container(
        width: Dimens.carouselCardWidth,
        margin: getMargin(position),
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: getContent(position),
          ),
        ),);
  }

  EdgeInsets getMargin(int position) {
    if (isLastCard) {
      return const EdgeInsets.only(left: 8, right: 8);
    } else {
      return const EdgeInsets.only(left: 8);
    }
  }
}
