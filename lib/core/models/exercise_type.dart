enum ExerciseType {
  repsBased('Reps based'),
  timeBased('Time based'),
  repsInReserve('Reps in reserve'),
  rateOfPerceivedExertion('Rate of perceived exertion'),
  maxPercentage('Max percentage');

  const ExerciseType(this.value);

  final String value;
}

extension StringToUserType on String {
  ExerciseType toExerciseType() {
    switch (this) {
      case 'timeBased':
        return ExerciseType.timeBased;
      case 'repsInReserve':
        return ExerciseType.repsInReserve;
      case 'rateOfPerceivedExertion':
        return ExerciseType.rateOfPerceivedExertion;
      case 'maxPercentage':
        return ExerciseType.maxPercentage;
      case 'repsBased':
      default:
        return ExerciseType.repsBased;
    }
  }
}
