import 'package:Perso/app/models/trainer_card/trainer_entity.dart';
import 'package:Perso/app/utils/colors.dart';
import 'package:Perso/app/utils/dimens.dart';
import 'package:Perso/app/utils/theme_text.dart';
import 'package:Perso/app/widgets/perso_app_bar.dart';
import 'package:Perso/app/widgets/perso_button.dart';
import 'package:Perso/app/widgets/perso_divider.dart';
import 'package:Perso/core/string_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class TrainerDetailsScreen extends StatefulWidget {
  const TrainerDetailsScreen({super.key, required TrainerEntity trainerEntity})
      : _trainerEntity = trainerEntity,
        super();

  final TrainerEntity _trainerEntity;

  @override
  State<TrainerDetailsScreen> createState() => _TrainerDetailsScreenState();
}

class _TrainerDetailsScreenState extends State<TrainerDetailsScreen> {
  Set<String> _segmentSelected = Set.from({"About"});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: PersoColors.lightBlue,
        appBar: PersoAppBar(
            isTitleCentered: true, title: "@${widget._trainerEntity.nickname}"),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(
                        top: Dimens.normalMargin,
                        left: Dimens.hugeMargin,
                        right: Dimens.hugeMargin),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: SegmentedButton(
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.resolveWith<Color>(
                                  (Set<MaterialState> states) {
                                    if (states
                                        .contains(MaterialState.selected)) {
                                      return Colors.black;
                                    } else {
                                      return Colors.white;
                                    }
                                  },
                                ),
                                textStyle: MaterialStateProperty.resolveWith<
                                    TextStyle>(
                                  (Set<MaterialState> states) {
                                    if (states
                                        .contains(MaterialState.selected)) {
                                      return ThemeText.bodyBoldWhiteText;
                                    } else {
                                      return ThemeText.bodyBoldBlackText;
                                    }
                                  },
                                ),
                              ),
                              showSelectedIcon: false,
                              selected: _segmentSelected,
                              segments: const [
                                ButtonSegment<String>(
                                    value: "About", label: Text('About')),
                                ButtonSegment<String>(
                                    value: "Reviews", label: Text('Reviews')),
                              ],
                              onSelectionChanged: (selectedSet) {
                                setState(() {
                                  _segmentSelected = selectedSet;
                                });
                              }),
                        ),
                      ],
                    ),
                  ),
                  Container(
                      margin: const EdgeInsets.only(top: Dimens.biggerMargin),
                      child: const Icon(
                        Icons.account_circle,
                        size: 88.0,
                      )),
                  Container(
                    margin: const EdgeInsets.only(top: Dimens.biggerMargin),
                    child: const Text("Andrew Parker"),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: Dimens.smallerMargin),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("5.0"),
                        Container(
                            margin: const EdgeInsets.only(
                                left: Dimens.smallerMargin,
                                right: Dimens.smallerMargin),
                            child: const Icon(Icons.star)),
                        const Text("(142)")
                      ],
                    ),
                  ),
                  Container(
                      margin: const EdgeInsets.only(top: Dimens.mediumMargin),
                      child: const PersoButton(
                          title: "Request for training", width: 280.0)),
                  Container(
                      margin: const EdgeInsets.only(
                          top: Dimens.mediumMargin,
                          bottom: Dimens.biggerMargin),
                      child: const PersoButton(
                        title: "Contact",
                        width: 280.0,
                        whiteBlackTheme: true,
                      )),
                  // setState() {}
                ],
              ),
              Visibility(
                visible: _segmentSelected.contains("About"),
                child: _aboutSection(),
              ),
              Visibility(
                visible: _segmentSelected.contains("Reviews"),
                child: _reviewsSection(),
              )
            ],
          ),
        ));
  }

  Container _aboutSection() {
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              margin: const EdgeInsets.only(
                  top: Dimens.bigMargin, left: Dimens.normalMargin),
              child: Text(
                "Biography",
                style: ThemeText.bodyBoldBlackText,
              )),
          Container(
            margin: const EdgeInsets.only(
                top: Dimens.smallMargin,
                left: Dimens.normalMargin,
                right: Dimens.normalMargin),
            child: Text(
              "Hello! I have been doing Yoga training for over 8 years and I’m pleased to present you my teachings. Below are my contact details.",
              style: ThemeText.subHeadingRegularGrey,
            ),
          ),
          Container(
              margin: const EdgeInsets.only(
                  top: Dimens.bigMargin,
                  left: Dimens.normalMargin,
                  right: Dimens.normalMargin),
              child: Text(
                "Location",
                style: ThemeText.bodyBoldBlackText,
              )),
          Container(
            margin: const EdgeInsets.only(
                left: Dimens.normalMargin,
                top: Dimens.mediumMargin,
                right: Dimens.normalMargin),
            child: Row(
              children: [
                const Icon(Icons.pin_drop),
                Flexible(
                  child: Container(
                      margin: const EdgeInsets.only(
                          left: Dimens.normalMargin, right: Dimens.normalMargin),
                      child: Text(
                        widget._trainerEntity.location,
                        style: ThemeText.bodyRegularBlackText,
                        softWrap: true,
                      )),
                )
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(
                top: Dimens.bigMargin, left: Dimens.normalMargin),
            child: Text(
              "Languages",
              style: ThemeText.bodyBoldBlackText,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(
                top: Dimens.mediumMargin,
                left: Dimens.normalMargin,
                right: Dimens.normalMargin,
                bottom: Dimens.normalMargin),
            child: _getLanguages(),
          ),
        ],
      ),
    );
  }

  Container _reviewsSection() {
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              margin: const EdgeInsets.only(
                  top: Dimens.mediumMargin, left: Dimens.mediumMargin),
              child: Text("Rating", style: ThemeText.bodyBoldBlackText)),
          Container(
            margin: const EdgeInsets.only(
                left: Dimens.mediumMargin, bottom: Dimens.mediumMargin),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Based on 142 reviews",
                    style: ThemeText.bodyRegularBlackText),
                Row(
                  children: [
                    const Icon(
                      Icons.star,
                      color: Colors.yellow,
                      size: 40.0,
                    ),
                    Container(
                        margin: const EdgeInsets.only(
                            left: Dimens.smallMargin,
                            right: Dimens.normalMargin),
                        child: Text(
                          "5.0",
                          style: ThemeText.largerTitleBold,
                        )),
                  ],
                )
              ],
            ),
          ),
          const PersoDivider(),
          Container(
            margin: const EdgeInsets.only(
                top: Dimens.mediumMargin,
                left: Dimens.mediumMargin,
                right: Dimens.mediumMargin),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Tap to rate",
                  style: ThemeText.bodyBoldBlackText,
                ),
                RatingBar(
                  allowHalfRating: true,
                  ratingWidget: RatingWidget(
                      full: const Icon(Icons.star, color: Colors.yellow),
                      half: const Icon(Icons.star_half, color: Colors.yellow),
                      empty:
                          const Icon(Icons.star_border, color: Colors.yellow)),
                  onRatingUpdate: (value) {
                    //no-op
                  },
                )
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(
                left: Dimens.mediumMargin,
                right: Dimens.mediumMargin,
                bottom: Dimens.mediumMargin),
            child: Row(
              children: [
                const Icon(
                  Icons.account_circle,
                  size: 48.0,
                ),
                Container(
                    margin: const EdgeInsets.only(left: Dimens.smallMargin),
                    child: Text("Write review",
                        style: ThemeText.calloutRegularGrey))
              ],
            ),
          ),
          const PersoDivider(),
          Container(
            margin: const EdgeInsets.only(
                top: Dimens.mediumMargin, left: Dimens.mediumMargin),
            child: Text(
              "Reviews",
              style: ThemeText.bodyBoldBlackText,
            ),
          ),
          _review()
        ],
      ),
    );
  }

  Container _review() {
    return Container(
      margin: const EdgeInsets.all(Dimens.mediumMargin),
      child: Column(
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Row(
              children: [
                const Icon(Icons.account_circle, size: 48.0),
                Container(
                  margin: const EdgeInsets.only(left: Dimens.smallMargin),
                  child: Column(
                    children: [
                      Text("John Wick", style: ThemeText.bodyBoldBlackText),
                      RatingBar(
                        itemSize: 20.0,
                        allowHalfRating: true,
                        ratingWidget: RatingWidget(
                            full: const Icon(Icons.star, color: Colors.yellow),
                            half: const Icon(Icons.star_half,
                                color: Colors.yellow),
                            empty: const Icon(Icons.star_border,
                                color: Colors.yellow)),
                        onRatingUpdate: (value) {
                          //no-op
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Text("1 month ago", style: ThemeText.bodyRegularBlackText)
          ]),
          Container(
              margin: const EdgeInsets.only(top: Dimens.smallMargin),
              child: Text(
                  "Let me put it this way! Andrew went out of his way to in our journey together. I wasn’t sure about things in the beginning, Lol.",
                  style: ThemeText.bodyRegularBlackText)),
        ],
      ),
    );
  }

  Row _getLanguages() {
    List<Text> languages = widget._trainerEntity.languages.map((element) {
      String language = element.removeBrackets();
      return Text(
        language,
        style: const TextStyle(fontSize: 24.0),
      );
    }).toList();
    return Row(
      children: languages,
    );
  }
}
