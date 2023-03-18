import 'package:Perso/app/models/training_category/training_category_icon.dart';
import 'package:Perso/app/utils/dimens.dart';
import 'package:flutter/material.dart';

class PersoTrainingCategoryIcon extends StatelessWidget {
  const PersoTrainingCategoryIcon(
      {Key? key, required this.trainingCategoryIcon})
      : super(key: key);
  final TrainingCategoryIcon trainingCategoryIcon;

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Material(
        color: trainingCategoryIcon.color, // Button color
        child: SizedBox(
            width: Dimens.trainingCategoryIconWidth,
            height: Dimens.trainingCategoryIconHeight,
            child: trainingCategoryIcon.icon),
      ),
    );
  }
}
