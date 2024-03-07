import 'package:flutter/material.dart';
import 'package:perso/app/screens/exercise_details/exercise_details_inherited_widget.dart';
import 'package:perso/app/screens/exercise_details/model/exercise_details_screen_type.dart';
import 'package:perso/app/styleguide/value/app_dimens.dart';
import 'package:perso/app/styleguide/value/app_typography.dart';
import 'package:perso/app/widgets/perso_text_field.dart';

class PersoTrainerNote extends StatelessWidget {
  const PersoTrainerNote({super.key});

  @override
  Widget build(BuildContext context) {
    final exerciseInheritedWidget = ExerciseInheritedWidget.of(context);
    exerciseInheritedWidget.trainerNoteController.text = exerciseInheritedWidget
        .exerciseInTrainingEntity
        .exerciseEntity
        .exerciseOptionsData
        .trainerNote;
    return Container(
      margin: const EdgeInsets.all(
        Dimens.mMargin,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Trainer note', style: ThemeText.smallTitleBold),
          Container(
            margin: const EdgeInsets.only(top: Dimens.mMargin),
            height: 140,
            child: PersoTextField(
              hintText: _getTitle(
                exerciseInheritedWidget.exerciseDetailScreenType,
              ),
              isEnabled: exerciseInheritedWidget.exerciseDetailScreenType !=
                  ExerciseDetailsScreenType.client,
              isMultiLine: true,
              maxLength: 120,
              textEditingController:
                  exerciseInheritedWidget.trainerNoteController,
            ),
          ),
        ],
      ),
    );
  }

  String? _getTitle(
    ExerciseDetailsScreenType exerciseDetailScreenType,
  ) {
    if (exerciseDetailScreenType == ExerciseDetailsScreenType.client) {
      return null;
    } else {
      return 'Write a note for the client on the exercise...';
    }
  }
}
