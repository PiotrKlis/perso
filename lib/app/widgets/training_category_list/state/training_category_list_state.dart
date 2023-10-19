import 'package:perso/app/models/training_category/training_category.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'training_category_list_state.freezed.dart';

@freezed
class TrainingCategoryListState with _$TrainingCategoryListState {
  const factory TrainingCategoryListState.initial() = _Initial;
  const factory TrainingCategoryListState.content(
      {required List<TrainingCategory> categories}) = _Content;
  const factory TrainingCategoryListState.error({required String error}) =
      _Error;
}
