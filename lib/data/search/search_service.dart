import 'package:algoliasearch/algoliasearch_lite.dart';
import 'package:injectable/injectable.dart';
import 'package:perso/core/models/exercise_entity.dart';
import 'package:perso/core/models/exercise_type.dart';

@injectable
class SearchService {
  Future<List<ExerciseEntity>> getSuggestions(String input) async {
    final client = SearchClient(
      appId: 'MQCK4CMRWW',
      apiKey: 'b9d0cecfb4ccbdfe1f0c61ebfa5dab24',
    );
    final queryHits = SearchForHits(
      indexName: 'exercises',
      query: input,
      hitsPerPage: 100,
    );
    final searchResponse = await client.searchIndex(request: queryHits);
    return searchResponse.hits
        .map(
          (exercise) => ExerciseEntity(
            id: exercise['id'] as String,
            description: exercise['description'] as String,
            index: exercise['index'] as int,
            exerciseType:
                (exercise['exerciseType'] as String).toExerciseType()!,
            reps: exercise['reps'] as int,
            sets: exercise['sets'] as int,
            tags: [],
            time: exercise['time'] as String,
            title: exercise['title'] as String,
            videoId: exercise['videoId'] as String,
          ),
        )
        .toList();
  }
}
