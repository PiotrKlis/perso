import 'package:freezed_annotation/freezed_annotation.dart';
part 'search_exercises_event.freezed.dart';

@freezed
class SearchExercisesEvent with _$SearchExercisesEvent {
  const factory SearchExercisesEvent.searchInput(String input) = SearchInput;
  const factory SearchExercisesEvent.emptySearch() = EmptySearch;
}
