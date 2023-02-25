import 'package:Perso/app/model/training_category/training_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'training_category.freezed.dart';

@freezed
class TrainingCategory with _$TrainingCategory {
  const factory TrainingCategory(
      {required TrainingIcon trainingIcon, required Text text}) = _TrainingCategory;
}

// List<TrainingCategory> dummyTrainingCategories = [
//   TrainingCategory(
//       trainingIcon: SvgPicture.asset("assets/images//bodybuilding.svg"),
//       text: const Text("Bodybuilding")),
//   TrainingCategory(
//       trainingIcon: SvgPicture.asset("assets/images/yoga.svg"),
//       text: const Text("Yoga")),
//   TrainingCategory(
//       trainingIcon: SvgPicture.asset("assets/images/calisthenics.svg"),
//       text: const Text("Calisthenics")),
//   TrainingCategory(
//       trainingIcon: SvgPicture.asset("assets/images/cardio.svg"),
//       text: const Text("Cardio")),
//   TrainingCategory(
//       trainingIcon: SvgPicture.asset("assets/images/endurance.svg"),
//       text: const Text("Endurance")),
//   TrainingCategory(
//       trainingIcon: SvgPicture.asset("assets/images/gymnastics.svg"),
//       text: const Text("Gymnastics")),
//   TrainingCategory(
//       trainingIcon: SvgPicture.asset("assets/images/crossfit.svg"),
//       text: const Text("Crossfit")),
// ];

