import 'package:Perso/app/models/trainer_card/trainer_entity.dart';
import 'package:Perso/app/utils/colors.dart';
import 'package:Perso/app/widgets/PersoAppBar.dart';
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
            child: ToggleButtons(
          isSelected: _selectedFruits,
          children: [Text("About"), Text("Reviews")],
        )));
  }
}
