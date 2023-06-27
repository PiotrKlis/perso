import 'package:Perso/app/models/trainer_card/trainer_entity.dart';
import 'package:Perso/app/utils/colors.dart';
import 'package:Perso/app/widgets/PersoAppBar.dart';
import 'package:flutter/material.dart';

class TrainerDetailsScreen extends StatelessWidget {
  const TrainerDetailsScreen({super.key, required TrainerEntity trainerEntity})
      : _trainerEntity = trainerEntity,
        super();

  final TrainerEntity _trainerEntity;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: PersoColors.lightBlue,
        appBar: PersoAppBar(title: "Trainer details screen"),
        body: Center(
            child: Text(
                "Trainer details screen, trainer entity ${_trainerEntity.toString()}")));
  }
}
