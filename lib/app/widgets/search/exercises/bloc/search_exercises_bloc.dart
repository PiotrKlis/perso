import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:perso/app/utils/event_transformer.dart';
import 'package:perso/app/widgets/search/exercises/event/search_exercises_event.dart';
import 'package:perso/app/widgets/search/exercises/state/search_exercises_state.dart';
import 'package:perso/core/dependency_injection/get_it.dart';
import 'package:perso/data/search/search_service.dart';

class SearchExercisesBloc
    extends Bloc<SearchExercisesEvent, SearchExercisesState> {
  SearchExercisesBloc() : super(const SearchExercisesState.loading()) {
    on<SearchInput>(
      (event, emitter) async {
        try {
          emitter(const SearchExercisesState.loading());
          final exercises =
              await _searchService.getExerciseSuggestions(event.input);
          emitter(SearchExercisesState.exercises(exercises));
        } catch (error) {
          emitter(SearchExercisesState.error(error.toString()));
        }
      },
      transformer: debounce(
        const Duration(milliseconds: 500),
      ),
    );

    on<EmptySearch>((event, emitter) async {
      emitter(const SearchExercisesState.empty());
    });
  }

  final _searchService = getIt.get<SearchService>();
}
