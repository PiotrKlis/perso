enum ExerciseType { repsBased, timeBased }

extension StringToUserType on String {
  ExerciseType? toExerciseType() {
    switch (this) {
      case 'repsBased':
        return ExerciseType.repsBased;
      case 'timeBased':
        return ExerciseType.timeBased;
      default:
        return null;
    }
  }
}
