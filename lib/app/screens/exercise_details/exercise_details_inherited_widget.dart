import 'package:flutter/material.dart';
import 'package:perso/app/screens/exercise_details/model/exercise_details_screen_type.dart';
import 'package:perso/core/models/exercise_in_training_entity.dart';
import 'package:perso/core/models/exercise_type.dart';

class ExerciseInheritedWidget extends InheritedWidget {
  ExerciseInheritedWidget({
    required this.exerciseDetailScreenType,
    required this.exerciseInTrainingEntity,
    required this.exerciseType,
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
  final ExerciseInTrainingEntity exerciseInTrainingEntity;
  final ExerciseDetailScreenType exerciseDetailScreenType;
  ExerciseType exerciseType;

  static ExerciseInheritedWidget of(BuildContext context) {
    final result =
        context.dependOnInheritedWidgetOfExactType<ExerciseInheritedWidget>();
    assert(result != null, 'No ExerciseControllers found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(ExerciseInheritedWidget oldWidget) {
    return setsController != oldWidget.setsController ||
        secondController != oldWidget.secondController ||
        thirdController != oldWidget.thirdController ||
        trainerNoteController != oldWidget.trainerNoteController ||
        supersetController != oldWidget.supersetController ||
        exerciseType != oldWidget.exerciseType ||
        exerciseDetailScreenType != oldWidget.exerciseDetailScreenType ||
        timeBreakController != oldWidget.timeBreakController;
  }
}
