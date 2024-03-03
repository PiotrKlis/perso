enum ExerciseDetailsScreenType { client, trainer, library }

extension StringToExerciseDetailScreenType on String {
  ExerciseDetailsScreenType toExerciseDetailsScreenType() {
    switch (this) {
      case 'client':
        return ExerciseDetailsScreenType.client;
      case 'trainer':
        return ExerciseDetailsScreenType.trainer;
      case 'library':
        return ExerciseDetailsScreenType.library;
      default:
        throw Exception('Invalid ExerciseDetailScreenType');
    }
  }
}
