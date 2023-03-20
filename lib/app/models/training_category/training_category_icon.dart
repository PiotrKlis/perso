import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'training_category_icon.freezed.dart';

@freezed
class TrainingCategoryIcon with _$TrainingCategoryIcon {
  const factory TrainingCategoryIcon(
      {required String path, required Color color}) = _TrainingCategoryIcon;
}
