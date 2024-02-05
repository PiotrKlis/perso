import 'package:freezed_annotation/freezed_annotation.dart';
part 'search_rename_event.freezed.dart';

@freezed
class SearchExercisesEvent with _$SearchExercisesEvent {
  const factory SearchExercisesEvent.searchInput(String input) = SearchInput;
  const factory SearchExercisesEvent.emptySearch() = EmptySearch;
}
