import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'training_category.freezed.dart';

@freezed
class TrainingCategory with _$TrainingCategory {
  const factory TrainingCategory({required Widget icon, required Text name}) =
      _TrainingCategory;
}

List<TrainingCategory> categoriesShortList = [
  TrainingCategory(
      icon: SvgPicture.asset("assets/bodybuilding.svg"),
      name: Text("Bodybuilding")),
  TrainingCategory(
      icon: SvgPicture.asset("assets/yoga.svg"), name: Text("Yoga")),
  TrainingCategory(
      icon: SvgPicture.asset("assets/calisthenics.svg"),
      name: Text("Calisthenics"))
];
