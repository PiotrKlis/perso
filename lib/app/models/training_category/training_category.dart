import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:perso/app/models/training_category/training_category_icon.dart';

part 'training_category.freezed.dart';

@freezed
class TrainingCategory with _$TrainingCategory {
  const factory TrainingCategory({
    required TrainingCategoryIcon trainingCategoryIcon,
    required String name,
  }) = _TrainingCategory;
}
