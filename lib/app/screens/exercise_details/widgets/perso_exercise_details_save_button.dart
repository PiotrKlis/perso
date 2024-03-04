import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:perso/app/screens/exercise_details/bloc/exercise_details_bloc.dart';
import 'package:perso/app/screens/exercise_details/event/exercise_details_event.dart';
import 'package:perso/app/screens/exercise_details/exercise_details_inherited_widget.dart';
import 'package:perso/app/widgets/perso_button.dart';
import 'package:perso/core/models/exercise_type.dart';

class PersoExerciseDetailsSaveButton extends StatelessWidget {
  const PersoExerciseDetailsSaveButton({super.key});

  @override
  Widget build(BuildContext context) {
    final exerciseInheritedWidget = ExerciseInheritedWidget.of(context);

    return PersoButton(
      title: 'Save',
      onTap: (context) {
        if (exerciseInheritedWidget.optionsFormKey.currentState!.validate() &&
            exerciseInheritedWidget.breakFormKey.currentState!.validate()) {
          final exerciseOptionsData = exerciseInheritedWidget
              .exerciseInTrainingEntity.exerciseEntity.exerciseOptionsData;
          final optionsData = switch (exerciseOptionsData.exerciseType) {
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
                  clientId: exerciseInheritedWidget.clientId,
                  date: exerciseInheritedWidget.date,
                  exerciseInTrainingEntity:
                      exerciseInheritedWidget.updateOptionsData(optionsData),
                ),
              );
          context.pop();
        }
      },
    );
  }
}
