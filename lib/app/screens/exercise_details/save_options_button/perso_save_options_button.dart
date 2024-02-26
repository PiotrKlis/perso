import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:perso/app/screens/exercise_details/exercise_inherited_widget.dart';
import 'package:perso/app/screens/exercise_details/exercise_options/bloc/trainer_exercise_options_bloc.dart';
import 'package:perso/app/screens/exercise_details/exercise_options/event/trainer_exercise_options_event.dart';
import 'package:perso/app/screens/exercise_details/exercise_options/model/exercise_options_data.dart';
import 'package:perso/app/styleguide/value/app_dimens.dart';
import 'package:perso/app/utils/extension/context_extensions.dart';
import 'package:perso/app/widgets/perso_button.dart';
import 'package:perso/core/models/exercise_type.dart';

class PersoSaveOptionsButton extends StatelessWidget {
  const PersoSaveOptionsButton({
    super.key,
    required String clientId,
    required String date,
    required String exerciseInTrainingId,
    required GlobalKey<FormState> optionsFormKey,
    required ExerciseOptionsData exerciseOptionsData,
    required GlobalKey<FormState> breaksFormKey,
  })  : _breaksFormKey = breaksFormKey,
        _exerciseOptionsData = exerciseOptionsData,
        _clientId = clientId,
        _date = date,
        _exerciseInTrainingId = exerciseInTrainingId,
        _optionsFormKey = optionsFormKey;

  final String _clientId;
  final String _date;
  final String _exerciseInTrainingId;
  final ExerciseOptionsData _exerciseOptionsData;
  final GlobalKey<FormState> _optionsFormKey;
  final GlobalKey<FormState> _breaksFormKey;

  @override
  Widget build(BuildContext context) {
    final exerciseInheritedWidget = ExerciseInheritedWidget.of(context);
    return Container(
      margin: const EdgeInsets.all(Dimens.mMargin),
      child: PersoButton(
        title: 'Save',
        onTap: (context) {
          if (_optionsFormKey.currentState!.validate() &&
              _breaksFormKey.currentState!.validate()) {
            final optionsData = switch (_exerciseOptionsData.exerciseType) {
              ExerciseType.repsBased => _exerciseOptionsData.copyWith(
                  exerciseType: exerciseInheritedWidget.exerciseType,
                  sets: int.parse(exerciseInheritedWidget.setsController.text),
                  reps:
                      int.parse(exerciseInheritedWidget.secondController.text),
                  weight:
                      int.parse(exerciseInheritedWidget.thirdController.text),
                  timeBreak: int.parse(
                    exerciseInheritedWidget.timeBreakController.text,
                  ),
                  supersetName: exerciseInheritedWidget.supersetController.text,
                  trainerNote:
                      exerciseInheritedWidget.trainerNoteController.text,
                ),
              ExerciseType.timeBased => _exerciseOptionsData.copyWith(
                  exerciseType: exerciseInheritedWidget.exerciseType,
                  sets: int.parse(exerciseInheritedWidget.setsController.text),
                  time:
                      int.parse(exerciseInheritedWidget.secondController.text),
                  weight:
                      int.parse(exerciseInheritedWidget.thirdController.text),
                  timeBreak: int.parse(
                    exerciseInheritedWidget.timeBreakController.text,
                  ),
                  supersetName: exerciseInheritedWidget.supersetController.text,
                  trainerNote:
                      exerciseInheritedWidget.trainerNoteController.text,
                ),
              ExerciseType.repsInReserve => _exerciseOptionsData.copyWith(
                  exerciseType: exerciseInheritedWidget.exerciseType,
                  sets: int.parse(exerciseInheritedWidget.setsController.text),
                  repsInReserve:
                      int.parse(exerciseInheritedWidget.secondController.text),
                  timeBreak: int.parse(
                    exerciseInheritedWidget.timeBreakController.text,
                  ),
                  supersetName: exerciseInheritedWidget.supersetController.text,
                  trainerNote:
                      exerciseInheritedWidget.trainerNoteController.text,
                ),
              ExerciseType.rateOfPerceivedExertion =>
                _exerciseOptionsData.copyWith(
                  exerciseType: exerciseInheritedWidget.exerciseType,
                  sets: int.parse(exerciseInheritedWidget.setsController.text),
                  rateOfPerceivedExertion:
                      int.parse(exerciseInheritedWidget.secondController.text),
                  weight:
                      int.parse(exerciseInheritedWidget.thirdController.text),
                  timeBreak: int.parse(
                    exerciseInheritedWidget.timeBreakController.text,
                  ),
                  supersetName: exerciseInheritedWidget.supersetController.text,
                  trainerNote:
                      exerciseInheritedWidget.trainerNoteController.text,
                ),
              ExerciseType.maxPercentage => _exerciseOptionsData.copyWith(
                  exerciseType: exerciseInheritedWidget.exerciseType,
                  sets: int.parse(exerciseInheritedWidget.setsController.text),
                  reps:
                      int.parse(exerciseInheritedWidget.secondController.text),
                  maxPercentage:
                      int.parse(exerciseInheritedWidget.thirdController.text),
                  timeBreak: int.parse(
                    exerciseInheritedWidget.timeBreakController.text,
                  ),
                  supersetName: exerciseInheritedWidget.supersetController.text,
                  trainerNote:
                      exerciseInheritedWidget.trainerNoteController.text,
                ),
            };
            context.read<TrainerExerciseOptionsBloc>().add(
                  TrainerExerciseOptionsEvent.editExerciseOptions(
                    clientId: _clientId,
                    date: _date,
                    exerciseInTrainingId: _exerciseInTrainingId,
                    exerciseOptionsData: optionsData,
                  ),
                );
            context.showSuccessfulSnackBar('Saving succeeded');
          }
        },
      ),
    );
  }
}
