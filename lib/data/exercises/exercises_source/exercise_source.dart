import 'package:perso/core/models/exercise_entity.dart';

abstract class ExerciseSource {
  Future<List<ExerciseEntity>> getAllExercises();
}
