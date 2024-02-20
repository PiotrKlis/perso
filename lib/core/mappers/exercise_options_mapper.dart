import 'package:algoliasearch/algoliasearch_lite.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:perso/app/screens/exercise_details/exercise_options/model/exercise_options_data.dart';
import 'package:perso/core/models/exercise_type.dart';
import 'package:perso/data/utils/firestore_constants.dart';

@injectable
class ExerciseOptionsMapper {
  ExerciseOptionsData map(
      QueryDocumentSnapshot<Map<String, dynamic>> exercise) {
    return ExerciseOptionsData(
      exerciseType: (exercise[UserDocumentFields.exerciseType] as String)
          .toExerciseType()!,
      reps: exercise[UserDocumentFields.reps] as int,
      sets: exercise[UserDocumentFields.sets] as int,
      time: exercise[UserDocumentFields.time] as String,
      timeBreak: exercise[UserDocumentFields.timeBreak] as int,
      supersetName: exercise[UserDocumentFields.supersetName] as String,
      repsInReserve: exercise[UserDocumentFields.repsInReserve] as int,
      rateOfPerceivedExertion:
          exercise[UserDocumentFields.rateOfPerceivedExertion] as int,
      maxPercentage: exercise[UserDocumentFields.maxPercentage] as int,
      trainerNote: exercise[UserDocumentFields.trainerNote] as String,
      weight: exercise[UserDocumentFields.weight] as int,
    );
  }

  ExerciseOptionsData mapSearchResult(Hit exercise) {
    return ExerciseOptionsData(
      exerciseType: (exercise[UserDocumentFields.exerciseType] as String)
          .toExerciseType()!,
      reps: exercise[UserDocumentFields.reps] as int,
      sets: exercise[UserDocumentFields.sets] as int,
      time: exercise[UserDocumentFields.time] as String,
      timeBreak: exercise[UserDocumentFields.timeBreak] as int,
      supersetName: exercise[UserDocumentFields.supersetName] as String,
      repsInReserve: exercise[UserDocumentFields.repsInReserve] as int,
      rateOfPerceivedExertion:
      exercise[UserDocumentFields.rateOfPerceivedExertion] as int,
      maxPercentage: exercise[UserDocumentFields.maxPercentage] as int,
      trainerNote: exercise[UserDocumentFields.trainerNote] as String,
      weight: exercise[UserDocumentFields.weight] as int,
    );
  }
}
