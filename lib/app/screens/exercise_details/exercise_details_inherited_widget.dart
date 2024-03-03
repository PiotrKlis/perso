import 'package:flutter/material.dart';
import 'package:perso/app/screens/exercise_details/model/exercise_details_screen_type.dart';
import 'package:perso/app/screens/exercise_details/model/exercise_options_data.dart';
import 'package:perso/core/models/exercise_in_training_entity.dart';
import 'package:perso/core/models/exercise_type.dart';

class ExerciseInheritedWidget extends InheritedWidget {
  ExerciseInheritedWidget({
    required this.clientId,
    required this.date,
    required this.exerciseDetailScreenType,
    required this.exerciseInTrainingEntity,
    required super.child,
    super.key,
  });

  final TextEditingController setsController = TextEditingController();
  final TextEditingController secondController = TextEditingController();
  final TextEditingController thirdController = TextEditingController();
  final TextEditingController trainerNoteController = TextEditingController();
  final TextEditingController timeBreakController = TextEditingController();
  final TextEditingController supersetController = TextEditingController();
  final GlobalKey<FormState> breakFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> optionsFormKey = GlobalKey<FormState>();
  final ExerciseDetailsScreenType exerciseDetailScreenType;
  final String clientId;
  final String date;
  ExerciseInTrainingEntity exerciseInTrainingEntity;

  static ExerciseInheritedWidget of(BuildContext context) {
    final result =
        context.dependOnInheritedWidgetOfExactType<ExerciseInheritedWidget>();
    assert(result != null, 'No ExerciseControllers found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(ExerciseInheritedWidget oldWidget) {
    return exerciseInTrainingEntity != oldWidget.exerciseInTrainingEntity ||
        exerciseDetailScreenType != oldWidget.exerciseDetailScreenType;
  }

  void updateExerciseType(ExerciseType exerciseType) {
    exerciseInTrainingEntity = exerciseInTrainingEntity.copyWith(
      exerciseEntity: exerciseInTrainingEntity.exerciseEntity.copyWith(
        exerciseOptionsData: exerciseInTrainingEntity
            .exerciseEntity.exerciseOptionsData
            .copyWith(
          exerciseType: exerciseType,
        ),
      ),
    );
  }

  void updateTimeBreak(int timeBreak) {
    exerciseInTrainingEntity = exerciseInTrainingEntity.copyWith(
      exerciseEntity: exerciseInTrainingEntity.exerciseEntity.copyWith(
        exerciseOptionsData: exerciseInTrainingEntity
            .exerciseEntity.exerciseOptionsData
            .copyWith(
          timeBreak: timeBreak,
        ),
      ),
    );
  }

  ExerciseInTrainingEntity updateOptionsData(ExerciseOptionsData optionsData) {
    return exerciseInTrainingEntity.copyWith(
      exerciseEntity: exerciseInTrainingEntity.exerciseEntity.copyWith(
        exerciseOptionsData: optionsData,
      ),
    );
  }
}
