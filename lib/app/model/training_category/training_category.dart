import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'training_category.freezed.dart';

@freezed
class TrainingCategory with _$TrainingCategory {
  const factory TrainingCategory(
      {required SvgPicture icon, required Text text}) = _TrainingCategory;
}

List<TrainingCategory> categoriesShortList = [
  TrainingCategory(
      icon: SvgPicture.asset("assets/bodybuilding.svg"),
      text: const Text("Bodybuilding")),
  TrainingCategory(
      icon: SvgPicture.asset("assets/yoga.svg"), text: const Text("Yoga")),
  TrainingCategory(
      icon: SvgPicture.asset("assets/calisthenics.svg"),
      text: const Text("Calisthenics"))
];

List<TrainingCategory> categories = [
  TrainingCategory(
      icon: SvgPicture.asset("assets/bodybuilding.svg"),
      text: const Text("Bodybuilding")),
  TrainingCategory(
      icon: SvgPicture.asset("assets/yoga.svg"), text: const Text("Yoga")),
  TrainingCategory(
      icon: SvgPicture.asset("assets/calisthenics.svg"),
      text: const Text("Calisthenics")),
  TrainingCategory(
      icon: SvgPicture.asset("assets/cardio.svg"), text: const Text("Cardio")),
  TrainingCategory(
      icon: SvgPicture.asset("assets/endurance.svg"),
      text: const Text("Endurance")),
  TrainingCategory(
      icon: SvgPicture.asset("assets/gymnastics.svg"),
      text: const Text("Gymnastics")),
  TrainingCategory(
      icon: SvgPicture.asset("assets/crossfit.svg"),
      text: const Text("Crossfit")),
];
