import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:perso/app/utils/event_transformer.dart';
import 'package:perso/app/widgets/search/trainers/event/search_trainers_event.dart';
import 'package:perso/app/widgets/search/trainers/state/search_trainers_state.dart';
import 'package:perso/core/dependency_injection/get_it.dart';
import 'package:perso/data/search/search_service.dart';

class SearchTrainersBloc
    extends Bloc<SearchTrainersEvent, SearchTrainersState> {
  SearchTrainersBloc() : super(const SearchTrainersState.empty()) {
    on<SearchTrainersInput>(
      (event, emitter) async {
        try {
          emitter(const SearchTrainersState.loading());
          final trainers =
              await _searchService.getTrainerSuggestions(event.input);
          emitter(SearchTrainersState.trainers(trainers));
        } catch (error) {
          emitter(SearchTrainersState.error(error.toString()));
        }
      },
      transformer: debounce(
        const Duration(milliseconds: 500),
      ),
    );

    on<EmptyTrainersSearch>((event, emitter) async {
      emitter(const SearchTrainersState.empty());
    },
      transformer: debounce(
        const Duration(milliseconds: 500),
      ),
    );
  }

  final _searchService = getIt.get<SearchService>();
}
