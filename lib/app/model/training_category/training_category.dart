import 'package:Perso/app/model/training_category/training_category_icon.dart';
import 'package:Perso/app/widgets/perso_training_category_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'training_category.freezed.dart';

@freezed
class TrainingCategory with _$TrainingCategory {
  const factory TrainingCategory(
      {required PersoTrainingCategoryIcon persoCategoryIcon,
      required Text text}) = _TrainingCategory;
}

List<TrainingCategory> dummyTrainingCategories = [
  TrainingCategory(
      persoCategoryIcon: PersoTrainingCategoryIcon(
          trainingCategoryIcon: TrainingCategoryIcon(
              icon: SvgPicture.asset("assets/images/bodybuilding.svg"),
              color: Colors.deepPurpleAccent)),
      text: const Text("Bodybuilding")),
  TrainingCategory(
      persoCategoryIcon: PersoTrainingCategoryIcon(
          trainingCategoryIcon: TrainingCategoryIcon(
              icon: SvgPicture.asset("assets/images/yoga.svg", fit: BoxFit.none),
              color: Colors.green)),
      text: const Text("Yoga")),
  TrainingCategory(
      persoCategoryIcon: PersoTrainingCategoryIcon(
          trainingCategoryIcon: TrainingCategoryIcon(
              icon: SvgPicture.asset("assets/images/calisthenics.svg"),
              color: Colors.greenAccent)),
      text: const Text("Calisthenics")),
  TrainingCategory(
      persoCategoryIcon: PersoTrainingCategoryIcon(
          trainingCategoryIcon: TrainingCategoryIcon(
              icon: SvgPicture.asset("assets/images/cardio.svg"),
              color: Colors.blue)),
      text: const Text("Cardio")),
  TrainingCategory(
      persoCategoryIcon: PersoTrainingCategoryIcon(
          trainingCategoryIcon: TrainingCategoryIcon(
              icon: SvgPicture.asset("assets/images/endurance.svg"),
              color: Colors.orange)),
      text: const Text("Endurance")),
  TrainingCategory(
      persoCategoryIcon: PersoTrainingCategoryIcon(
          trainingCategoryIcon: TrainingCategoryIcon(
              icon: SvgPicture.asset("assets/images/gymnastics.svg"),
              color: Colors.yellow)),
      text: const Text("Gymnastics")),
  TrainingCategory(
      persoCategoryIcon: PersoTrainingCategoryIcon(
          trainingCategoryIcon: TrainingCategoryIcon(
              icon: SvgPicture.asset("assets/images/crossfit.svg"),
              color: Colors.pinkAccent)),
      text: const Text("Crossfit")),
];
