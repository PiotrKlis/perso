import 'package:freezed_annotation/freezed_annotation.dart';
part 'training_category_list_event.freezed.dart';

@freezed
class TrainingCategoryListEvent with _$TrainingCategoryListEvent {
  const factory TrainingCategoryListEvent.loadShortList() = LoadShortList;
  const factory TrainingCategoryListEvent.loadAll() = LoadAll;
}
