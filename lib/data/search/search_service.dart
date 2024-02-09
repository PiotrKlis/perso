import 'package:algoliasearch/algoliasearch_lite.dart';
import 'package:injectable/injectable.dart';
import 'package:perso/core/dependency_injection/get_it.dart';
import 'package:perso/core/mappers/exercise_entity_mapper.dart';
import 'package:perso/core/models/exercise_entity.dart';

@injectable
class SearchService {
  final _client = SearchClient(
    appId: 'MQCK4CMRWW',
    apiKey: 'b9d0cecfb4ccbdfe1f0c61ebfa5dab24',
  );
  final _exerciseEntityMapper = getIt.get<ExerciseEntityMapper>();

  Future<List<ExerciseEntity>> getSuggestions(String input) async {
    final queryHits = SearchForHits(
      indexName: 'exercises',
      query: input,
      hitsPerPage: 100,
    );
    final searchResponse = await _client.searchIndex(request: queryHits);
    return searchResponse.hits
        .map(
          _exerciseEntityMapper.mapSearchResult,
        )
        .toList();
  }
}
