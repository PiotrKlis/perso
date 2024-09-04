import 'package:flutter/material.dart';
import 'package:perso/app/screens/exercise_details/exercise_details_inherited_widget.dart';
import 'package:perso/app/styleguide/value/app_dimens.dart';
import 'package:perso/app/styleguide/value/app_typography.dart';

class PersoInstructionsSection extends StatelessWidget {
  const PersoInstructionsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final exerciseInheritedWidget = ExerciseInheritedWidget.of(context);
    return Container(
      margin: const EdgeInsets.all(Dimens.mMargin),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Instructions',
            style: ThemeText.smallTitleBold,
          ),
          Container(
            margin: const EdgeInsets.only(top: Dimens.mMargin),
            child: Text(
              exerciseInheritedWidget
                  .exerciseInTrainingEntity.exerciseEntity.instructions,
              style: ThemeText.bodyRegularBlackText,
            ),
          ),
        ],
      ),
    );
  }
}
