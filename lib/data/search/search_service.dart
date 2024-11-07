import 'package:algoliasearch/algoliasearch_lite.dart';
import 'package:injectable/injectable.dart';
import 'package:perso/core/dependency_injection/get_it.dart';
import 'package:perso/core/mappers/exercise_entity_mapper.dart';
import 'package:perso/core/mappers/trainer_entity_mapper.dart';
import 'package:perso/core/models/exercise_entity.dart';
import 'package:perso/core/models/trainer_entity.dart';

@injectable
class SearchService {
  final _exerciseSearchClient = SearchClient(
    appId: '93R18ZFZVY',
    apiKey: '44515680adad5e4c9223bba9442696d8',
  );
  final _trainersSearchClient = SearchClient(
    appId: '93R18ZFZVY',
    apiKey: 'f4f7daba50927cfc65d5331ce67cd88e',
  );
  final _exerciseEntityMapper = getIt.get<ExerciseEntityMapper>();
  final _trainerEntityMapper = getIt.get<TrainerEntityMapper>();

  Future<List<ExerciseEntity>> getExerciseSuggestions(String input) async {
    final queryHits = SearchForHits(
      indexName: 'exercises',
      query: input,
      hitsPerPage: 20,
    );
    final searchResponse =
        await _exerciseSearchClient.searchIndex(request: queryHits);
    return searchResponse.hits
        .map(
          _exerciseEntityMapper.mapSearchResult,
        )
        .toList();
  }

  Future<List<TrainerEntity>> getTrainerSuggestions(String input) async {
    final queryHits = SearchForHits(
      indexName: 'users',
      query: input,
      hitsPerPage: 10,
      filters: 'userType:trainer',
    );
    final searchResponse =
        await _trainersSearchClient.searchIndex(request: queryHits);
    return searchResponse.hits
        .map(_trainerEntityMapper.mapSearchResult)
        .toList();
    // return Future.value();
  }
}
