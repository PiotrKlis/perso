import 'package:freezed_annotation/freezed_annotation.dart';
part 'search_trainers_event.freezed.dart';

@freezed
class SearchTrainersEvent with _$SearchTrainersEvent {
  const factory SearchTrainersEvent.searchTrainersInput(String input) = SearchTrainersInput;
  const factory SearchTrainersEvent.emptyTrainersSearch() = EmptyTrainersSearch;
}
