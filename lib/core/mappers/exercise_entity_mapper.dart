import 'package:algoliasearch/algoliasearch_lite.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:perso/core/dependency_injection/get_it.dart';
import 'package:perso/core/mappers/translations/string_list_mapper.dart';
import 'package:perso/core/mappers/translations/string_mapper.dart';
import 'package:perso/core/models/exercise_entity.dart';
import 'package:perso/core/models/exercise_type.dart';
import 'package:perso/data/utils/firestore_constants.dart';

@injectable
class ExerciseEntityMapper {
  final _stringTranslationsMapper = getIt.get<StringTranslationsMapper>();
  final _stringListTranslationsMapper =
      getIt.get<StringListTranslationsMapper>();

  ExerciseEntity map(QueryDocumentSnapshot<Map<String, dynamic>> exercise) {
    return ExerciseEntity(
      id: exercise[UserDocumentFields.id] as String,
      description: _stringTranslationsMapper.mapFrom(
        exercise[UserDocumentFields.description] as Map<String, dynamic>,
      ),
      index: exercise[UserDocumentFields.index] as int,
      exerciseType: (exercise[UserDocumentFields.exerciseType] as String)
          .toExerciseType()!,
      reps: exercise[UserDocumentFields.reps] as int,
      sets: exercise[UserDocumentFields.sets] as int,
      tags: _stringListTranslationsMapper.map(
        exercise[UserDocumentFields.tags] as Map<String, dynamic>,
      ),
      time: exercise[UserDocumentFields.time] as String,
      title: _stringTranslationsMapper
          .mapFrom(exercise[UserDocumentFields.title] as Map<String, dynamic>),
      videoId: exercise[UserDocumentFields.videoId] as String,
      timeBreak: exercise[UserDocumentFields.timeBreak] as int,
      supersetName: exercise[UserDocumentFields.supersetName] as String,
    );
  }

  ExerciseEntity mapSearchResult(Hit exercise) {
    return ExerciseEntity(
      id: exercise[UserDocumentFields.id] as String,
      description: _stringTranslationsMapper.mapFrom(
        exercise[UserDocumentFields.description] as Map<String, dynamic>,
      ),
      index: exercise[UserDocumentFields.index] as int,
      exerciseType: (exercise[UserDocumentFields.exerciseType] as String)
          .toExerciseType()!,
      reps: exercise[UserDocumentFields.reps] as int,
      sets: exercise[UserDocumentFields.sets] as int,
      tags: _stringListTranslationsMapper.map(
        exercise[UserDocumentFields.tags] as Map<String, dynamic>,
      ),
      time: exercise[UserDocumentFields.time] as String,
      title: _stringTranslationsMapper
          .mapFrom(exercise[UserDocumentFields.title] as Map<String, dynamic>),
      videoId: exercise[UserDocumentFields.videoId] as String,
      timeBreak: exercise[UserDocumentFields.timeBreak] as int,
      supersetName: exercise[UserDocumentFields.supersetName] as String,
    );
  }
}
