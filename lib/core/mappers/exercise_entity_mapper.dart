import 'package:algoliasearch/algoliasearch_lite.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:perso/core/dependency_injection/get_it.dart';
import 'package:perso/core/mappers/exercise_options_mapper.dart';
import 'package:perso/core/mappers/translations/string_list_mapper.dart';
import 'package:perso/core/mappers/translations/string_mapper.dart';
import 'package:perso/core/models/exercise_entity.dart';
import 'package:perso/data/utils/firestore_constants.dart';

@injectable
class ExerciseEntityMapper {
  final _stringTranslationsMapper = getIt.get<StringTranslationsMapper>();
  final _exerciseOptionsMapper = getIt.get<ExerciseOptionsMapper>();
  final _stringListTranslationsMapper =
      getIt.get<StringListTranslationsMapper>();

  ExerciseEntity map(QueryDocumentSnapshot<Map<String, dynamic>> exercise) {
    return ExerciseEntity(
      id: exercise[UserDocumentFields.id] as String,
      instructions: _stringTranslationsMapper.mapFrom(
        exercise[UserDocumentFields.instructions] as Map<String, dynamic>,
      ),
      index: exercise[UserDocumentFields.index] as int,
      tags: _stringListTranslationsMapper.map(
        exercise[UserDocumentFields.tags] as Map<String, dynamic>,
      ),
      title: _stringTranslationsMapper
          .mapFrom(exercise[UserDocumentFields.title] as Map<String, dynamic>),
      videoId: exercise[UserDocumentFields.videoId] as String,
      exerciseOptionsData: _exerciseOptionsMapper.map(exercise),
    );
  }

  ExerciseEntity mapSearchResult(Hit exercise) {
    return ExerciseEntity(
      id: exercise[UserDocumentFields.id] as String,
      instructions: _stringTranslationsMapper.mapFrom(
        exercise[UserDocumentFields.instructions] as Map<String, dynamic>,
      ),
      index: exercise[UserDocumentFields.index] as int,
      tags: _stringListTranslationsMapper.map(
        exercise[UserDocumentFields.tags] as Map<String, dynamic>,
      ),
      title: _stringTranslationsMapper
          .mapFrom(exercise[UserDocumentFields.title] as Map<String, dynamic>),
      videoId: exercise[UserDocumentFields.videoId] as String,
      exerciseOptionsData: _exerciseOptionsMapper.mapSearchResult(exercise),
    );
  }
}
