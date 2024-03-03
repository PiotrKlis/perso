import 'package:flutter/material.dart';
import 'package:perso/app/screens/exercise_details/exercise_details_inherited_widget.dart';
import 'package:perso/app/styleguide/value/app_dimens.dart';
import 'package:perso/app/widgets/category_chips/perso_category_chips.dart';

class PersoExerciseCategories extends StatelessWidget {
  const PersoExerciseCategories({super.key});

  @override
  Widget build(BuildContext context) {
    final exerciseInheritedWidget = ExerciseInheritedWidget.of(context);
    return Container(
      margin: const EdgeInsets.symmetric(vertical: Dimens.sMargin),
      child: PersoCategoryChips(
        categories: exerciseInheritedWidget
            .exerciseInTrainingEntity.exerciseEntity.tags,
      ),
    );
  }
}
