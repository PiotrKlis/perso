import 'package:flutter/material.dart';
import 'package:perso/app/screens/exercise_details/exercise_details_inherited_widget.dart';
import 'package:perso/app/screens/exercise_details/widgets/perso_description_section.dart';
import 'package:perso/app/screens/exercise_details/widgets/perso_exercise_categories.dart';
import 'package:perso/app/screens/exercise_details/widgets/perso_exercise_details_buttons_section.dart';
import 'package:perso/app/screens/exercise_details/widgets/perso_exercise_options.dart';
import 'package:perso/app/screens/exercise_details/widgets/perso_superset_section.dart';
import 'package:perso/app/screens/exercise_details/widgets/perso_time_break_section.dart';
import 'package:perso/app/screens/exercise_details/widgets/perso_trainer_note.dart';
import 'package:perso/app/widgets/video_player/perso_video_player.dart';
import 'package:perso/core/models/exercise_in_training_entity.dart';

class PersoPlanOverviewExerciseDetails extends StatelessWidget {
  PersoPlanOverviewExerciseDetails({
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
        setsController: TextEditingController(),
        secondController: TextEditingController(),
        thirdController: TextEditingController(),
        trainerNoteController: TextEditingController(),
        timeBreakController: TextEditingController(),
        supersetController: TextEditingController(),
        exerciseType: _exerciseInTrainingEntity
            .exerciseEntity.exerciseOptionsData.exerciseType,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PersoVideoPlayer(
              videoId: _exerciseInTrainingEntity.exerciseEntity.videoId,
            ),
            PersoExerciseCategories(
              _exerciseInTrainingEntity.exerciseEntity.tags,
            ),
            PersoDescriptionSection(
              description: _exerciseInTrainingEntity.exerciseEntity.description,
            ),
            PersoExerciseOptionsSection(
              formKey: _optionsFormKey,
              exerciseOptionsData:
                  _exerciseInTrainingEntity.exerciseEntity.exerciseOptionsData,
            ),
            PersoTimeBreakSection(
              formKey: _breaksFormKey,
              timeBreak: _exerciseInTrainingEntity
                  .exerciseEntity.exerciseOptionsData.timeBreak,
            ),
            const PersoSupersetSection(),
            PersoTrainerNote(
              trainerNote: _exerciseInTrainingEntity
                  .exerciseEntity.exerciseOptionsData.trainerNote,
            ),
            PersoExerciseDetailsButtonsSection(
              clientId: _clientId,
              date: _date,
              breaksFormKey: _breaksFormKey,
              optionsFormKey: _optionsFormKey,
              exerciseInTrainingEntity: _exerciseInTrainingEntity,
            ),
          ],
        ),
      ),
    );
  }
}
