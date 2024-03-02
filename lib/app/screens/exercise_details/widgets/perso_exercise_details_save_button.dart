import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:perso/app/screens/exercise_details/bloc/exercise_details_bloc.dart';
import 'package:perso/app/screens/exercise_details/event/exercise_details_event.dart';
import 'package:perso/app/screens/exercise_details/exercise_details_inherited_widget.dart';
import 'package:perso/app/widgets/perso_button.dart';
import 'package:perso/core/models/exercise_in_training_entity.dart';
import 'package:perso/core/models/exercise_type.dart';

class PersoExerciseDetailsSaveButton extends StatelessWidget {
  const PersoExerciseDetailsSaveButton({
    required String clientId,
    required String date,
    required GlobalKey<FormState> optionsFormKey,
    required GlobalKey<FormState> breaksFormKey,
    required ExerciseInTrainingEntity exerciseInTrainingEntity,
    super.key,
  })  : _exerciseInTrainingEntity = exerciseInTrainingEntity,
        _breaksFormKey = breaksFormKey,
        _clientId = clientId,
        _date = date,
        _optionsFormKey = optionsFormKey;

  final String _clientId;
  final String _date;
  final GlobalKey<FormState> _optionsFormKey;
  final GlobalKey<FormState> _breaksFormKey;
  final ExerciseInTrainingEntity _exerciseInTrainingEntity;

  @override
  Widget build(BuildContext context) {
    final exerciseInheritedWidget = ExerciseInheritedWidget.of(context);
    final exerciseOptionsData =
        _exerciseInTrainingEntity.exerciseEntity.exerciseOptionsData;
    return PersoButton(
      title: 'Save',
      onTap: (context) {
        if (_optionsFormKey.currentState!.validate() &&
            _breaksFormKey.currentState!.validate()) {
          final optionsData = switch (exerciseInheritedWidget.exerciseType) {
            ExerciseType.repsBased => exerciseOptionsData.copyWith(
                exerciseType: ExerciseType.repsBased,
                sets: int.parse(
                  exerciseInheritedWidget.setsController.text,
                ),
                reps: int.parse(
                  exerciseInheritedWidget.secondController.text,
                ),
                weight: int.parse(
                  exerciseInheritedWidget.thirdController.text,
                ),
                timeBreak: int.parse(
                  exerciseInheritedWidget.timeBreakController.text,
                ),
                supersetName: exerciseInheritedWidget.supersetController.text,
                trainerNote: exerciseInheritedWidget.trainerNoteController.text,
              ),
            ExerciseType.timeBased => exerciseOptionsData.copyWith(
                exerciseType: ExerciseType.timeBased,
                sets: int.parse(
                  exerciseInheritedWidget.setsController.text,
                ),
                time: int.parse(
                  exerciseInheritedWidget.secondController.text,
                ),
                weight: int.parse(
                  exerciseInheritedWidget.thirdController.text,
                ),
                timeBreak: int.parse(
                  exerciseInheritedWidget.timeBreakController.text,
                ),
                supersetName: exerciseInheritedWidget.supersetController.text,
                trainerNote: exerciseInheritedWidget.trainerNoteController.text,
              ),
            ExerciseType.repsInReserve => exerciseOptionsData.copyWith(
                exerciseType: ExerciseType.repsInReserve,
                sets: int.parse(
                  exerciseInheritedWidget.setsController.text,
                ),
                repsInReserve: int.parse(
                  exerciseInheritedWidget.secondController.text,
                ),
                timeBreak: int.parse(
                  exerciseInheritedWidget.timeBreakController.text,
                ),
                supersetName: exerciseInheritedWidget.supersetController.text,
                trainerNote: exerciseInheritedWidget.trainerNoteController.text,
              ),
            ExerciseType.rateOfPerceivedExertion =>
              exerciseOptionsData.copyWith(
                exerciseType: ExerciseType.rateOfPerceivedExertion,
                sets: int.parse(
                  exerciseInheritedWidget.setsController.text,
                ),
                rateOfPerceivedExertion: int.parse(
                  exerciseInheritedWidget.secondController.text,
                ),
                weight: int.parse(
                  exerciseInheritedWidget.thirdController.text,
                ),
                timeBreak: int.parse(
                  exerciseInheritedWidget.timeBreakController.text,
                ),
                supersetName: exerciseInheritedWidget.supersetController.text,
                trainerNote: exerciseInheritedWidget.trainerNoteController.text,
              ),
            ExerciseType.maxPercentage => exerciseOptionsData.copyWith(
                exerciseType: ExerciseType.maxPercentage,
                sets: int.parse(
                  exerciseInheritedWidget.setsController.text,
                ),
                reps: int.parse(
                  exerciseInheritedWidget.secondController.text,
                ),
                maxPercentage: int.parse(
                  exerciseInheritedWidget.thirdController.text,
                ),
                timeBreak: int.parse(
                  exerciseInheritedWidget.timeBreakController.text,
                ),
                supersetName: exerciseInheritedWidget.supersetController.text,
                trainerNote: exerciseInheritedWidget.trainerNoteController.text,
              ),
          };
          context.read<ExerciseDetailsBloc>().add(
                ExerciseDetailsEvent.saveExercise(
                  clientId: _clientId,
                  date: _date,
                  exerciseInTrainingEntity: _exerciseInTrainingEntity.copyWith(
                    exerciseEntity:
                        _exerciseInTrainingEntity.exerciseEntity.copyWith(
                      exerciseOptionsData: optionsData,
                    ),
                  ),
                ),
              );
          context.pop();
        }
      },
    );
  }
}
