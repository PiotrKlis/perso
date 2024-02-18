enum ExerciseType {
  repsBased,
  timeBased,
  repsInReserve,
  rateOfPerceivedExertion,
  maxPercentage,
}

extension StringToUserType on String {
  ExerciseType? toExerciseType() {
    switch (this) {
      case 'repsBased':
        return ExerciseType.repsBased;
      case 'timeBased':
        return ExerciseType.timeBased;
      case 'repsInReserve':
        return ExerciseType.repsInReserve;
      case 'rateOfPerceivedExertion':
        return ExerciseType.rateOfPerceivedExertion;
      case 'maxPercentage':
        return ExerciseType.maxPercentage;
      default:
        return null;
    }
  }
}
