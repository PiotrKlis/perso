import 'package:Perso/app/models/trainer_card/trainer_entity.dart';
import 'package:Perso/app/utils/colors.dart';
import 'package:Perso/app/utils/dimens.dart';
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
        body: Center(
          child: Container(
            margin: const EdgeInsets.only(
                left: Dimens.normalMargin, right: Dimens.normalMargin),
            child: Column(
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
                  margin: EdgeInsets.only(top: Dimens.smallerMargin),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("5.0"),
                      Container(
                          margin: EdgeInsets.only(
                              left: Dimens.smallerMargin,
                              right: Dimens.smallerMargin),
                          child: Icon(Icons.star)),
                      Text("(142)")
                    ],
                  ),
                ),
                Container(
                    margin: EdgeInsets.only(top: Dimens.mediumMargin),
                    child: PersoButton(
                        title: "Request for training", width: 280.0)),
                Container(
                    margin: EdgeInsets.only(top: Dimens.mediumMargin),
                    child: PersoButton(title: "Contact", width: 280.0)),
              ],
            ),
          ),
        ));
  }
}
