import 'package:Perso/app/models/trainer_card/trainer_entity.dart';
import 'package:Perso/app/utils/colors.dart';
import 'package:Perso/app/utils/dimens.dart';
import 'package:Perso/app/utils/theme_text.dart';
import 'package:Perso/app/widgets/PersoAppBar.dart';
import 'package:Perso/app/widgets/perso_button.dart';
import 'package:flutter/material.dart';

class TrainerDetailsScreen extends StatelessWidget {
  TrainerDetailsScreen({super.key, required TrainerEntity trainerEntity})
      : _trainerEntity = trainerEntity,
        super();

  final TrainerEntity _trainerEntity;
  final List<bool> _selectedFruits = <bool>[true, false];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: PersoColors.lightBlue,
        appBar: PersoAppBar(
            isTitleCentered: true, title: "@${_trainerEntity.nickname}"),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: Dimens.normalMargin),
                    child: ToggleButtons(
                      isSelected: _selectedFruits,
                      children: const [Text("About"), Text("Reviews")],
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
              Container(
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        margin: EdgeInsets.only(
                            top: Dimens.bigMargin, left: Dimens.normalMargin),
                        child: Text(
                          "Biography",
                          style: ThemeText.bodyBoldBlackText,
                        )),
                    Container(
                      margin: EdgeInsets.only(
                          top: Dimens.smallMargin,
                          left: Dimens.normalMargin),
                      child: Text(
                        "Hello! I have been doing Yoga training for over 8 years and I’m pleased to present you my teachings. Below are my contact details.",
                        style: ThemeText.subHeadingRegularGrey,
                      ),
                    ),
                    Container(
                        margin: EdgeInsets.only(
                            top: Dimens.biggerMargin,
                            left: Dimens.normalMargin),
                        child: Text(
                          "Contact",
                          style: ThemeText.bodyBoldBlackText,
                        )),
                    Container(
                      margin: EdgeInsets.only(
                          left: Dimens.normalMargin, top: Dimens.mediumMargin),
                      child: Row(
                        children: [
                          Icon(Icons.mail),
                          Container(
                              margin:
                                  EdgeInsets.only(left: Dimens.normalMargin),
                              child: Text(_trainerEntity.email))
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          left: Dimens.normalMargin, top: Dimens.mediumMargin),
                      child: Row(
                        children: [
                          Icon(Icons.phone),
                          Container(
                              margin:
                                  EdgeInsets.only(left: Dimens.normalMargin),
                              child: Text(_trainerEntity.phoneNumber))
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          left: Dimens.normalMargin, top: Dimens.mediumMargin),
                      child: Row(
                        children: [
                          Icon(Icons.pin_drop),
                          Container(
                              margin:
                                  EdgeInsets.only(left: Dimens.normalMargin),
                              child: Text(_trainerEntity.location))
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: Dimens.biggerMargin, left: Dimens.normalMargin),
                      child: Text("Languages"),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: Dimens.mediumMargin, left: Dimens.normalMargin),
                      child: Text(_trainerEntity.languages.first),
                    ),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
