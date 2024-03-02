import 'package:flutter/material.dart';
import 'package:perso/app/screens/exercise_details/exercise_details_inherited_widget.dart';
import 'package:perso/app/screens/exercise_details/model/exercise_details_screen_type.dart';
import 'package:perso/app/screens/exercise_details/widgets/perso_description_section.dart';
import 'package:perso/app/screens/exercise_details/widgets/perso_exercise_categories.dart';
import 'package:perso/app/screens/exercise_details/widgets/perso_exercise_details_save_button.dart';
import 'package:perso/app/screens/exercise_details/widgets/perso_exercise_options.dart';
import 'package:perso/app/screens/exercise_details/widgets/perso_superset_section.dart';
import 'package:perso/app/screens/exercise_details/widgets/perso_time_break_section.dart';
import 'package:perso/app/screens/exercise_details/widgets/perso_trainer_note.dart';
import 'package:perso/app/styleguide/value/app_dimens.dart';
import 'package:perso/app/widgets/video_player/perso_video_player.dart';
import 'package:perso/core/models/exercise_in_training_entity.dart';

class PersoLibraryExerciseDetails extends StatelessWidget {
  PersoLibraryExerciseDetails({
    required String clientId,
    required String date,
    required ExerciseInTrainingEntity exerciseInTrainingEntity,
    super.key,
  })  : _exerciseInTrainingEntity = exerciseInTrainingEntity,
        _date = date,
        _clientId = clientId;

  final String _clientId;
  final String _date;
  final ExerciseInTrainingEntity _exerciseInTrainingEntity;
  final GlobalKey<FormState> _optionsFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _breaksFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: ExerciseInheritedWidget(
        exerciseInTrainingEntity: _exerciseInTrainingEntity,
        exerciseDetailScreenType: ExerciseDetailScreenType.library,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const PersoVideoPlayer(),
            const PersoExerciseCategories(),
            const PersoDescriptionSection(),
            const PersoExerciseOptionsSection(),
            PersoTimeBreakSection(),
            const PersoSupersetSection(),
            PersoTrainerNote(),
            Container(
              margin: const EdgeInsets.all(Dimens.mMargin),
              child: PersoExerciseDetailsSaveButton(
                clientId: _clientId,
                date: _date,
                breaksFormKey: _breaksFormKey,
                optionsFormKey: _optionsFormKey,
                exerciseInTrainingEntity: _exerciseInTrainingEntity,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
