import 'package:flutter/material.dart';
import 'package:perso/app/screens/exercise_details/exercise_details_inherited_widget.dart';
import 'package:perso/app/styleguide/value/app_dimens.dart';
import 'package:perso/app/styleguide/value/app_typography.dart';

class PersoDescriptionSection extends StatelessWidget {
  const PersoDescriptionSection({super.key});

  @override
  Widget build(BuildContext context) {
    final exerciseInheritedWidget = ExerciseInheritedWidget.of(context);

    return Container(
      margin: const EdgeInsets.all(Dimens.mMargin),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Description',
            style: ThemeText.smallTitleBold,
          ),
          Container(
            margin: const EdgeInsets.only(top: Dimens.mMargin),
            child: Text(
              exerciseInheritedWidget
                  .exerciseInTrainingEntity.exerciseEntity.description,
              style: ThemeText.bodyRegularBlackText,
            ),
          ),
        ],
      ),
    );
  }
}
