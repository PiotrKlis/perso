import 'package:flutter/material.dart';
import 'package:perso/core/models/exercise_type.dart';

class ExerciseInheritedWidget extends InheritedWidget {
  ExerciseInheritedWidget({
    super.key,
    required this.setsController,
    required this.secondController,
    required this.thirdController,
    required this.trainerNoteController,
    required this.timeBreakController,
    required this.supersetController,
    required this.exerciseType,
    required super.child,
  });

  final TextEditingController setsController;
  final TextEditingController secondController;
  final TextEditingController thirdController;
  final TextEditingController trainerNoteController;
  final TextEditingController timeBreakController;
  final TextEditingController supersetController;
  ExerciseType exerciseType;

  static ExerciseInheritedWidget of(BuildContext context) {
    final result = context.dependOnInheritedWidgetOfExactType<
        ExerciseInheritedWidget>();
    assert(result != null, 'No ExerciseControllers found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(
      ExerciseInheritedWidget oldWidget) {
    return setsController != oldWidget.setsController ||
        secondController != oldWidget.secondController ||
        thirdController != oldWidget.thirdController ||
        trainerNoteController != oldWidget.trainerNoteController ||
        supersetController != oldWidget.supersetController ||
        exerciseType != oldWidget.exerciseType ||
        timeBreakController != oldWidget.timeBreakController;
  }
}
