import 'package:Perso/app/model/training_category/training_category_icon.dart';
import 'package:Perso/app/utils/theme_text.dart';
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
              icon: SvgPicture.asset("assets/images/bodybuilding.svg",
                  fit: BoxFit.none),
              color: Colors.deepPurpleAccent)),
      text: Text("Bodybuilding", style: ThemeText.bodyBoldBlackText)),
  TrainingCategory(
      persoCategoryIcon: PersoTrainingCategoryIcon(
          trainingCategoryIcon: TrainingCategoryIcon(
              icon:
                  SvgPicture.asset("assets/images/yoga.svg", fit: BoxFit.none),
              color: Colors.green)),
      text: Text("Yoga", style: ThemeText.bodyBoldBlackText)),
  TrainingCategory(
      persoCategoryIcon: PersoTrainingCategoryIcon(
          trainingCategoryIcon: TrainingCategoryIcon(
              icon: SvgPicture.asset("assets/images/calisthenics.svg",
                  fit: BoxFit.none),
              color: Colors.greenAccent)),
      text: Text("Calisthenics", style: ThemeText.bodyBoldBlackText)),
  TrainingCategory(
      persoCategoryIcon: PersoTrainingCategoryIcon(
          trainingCategoryIcon: TrainingCategoryIcon(
              icon: SvgPicture.asset("assets/images/cardio.svg",
                  fit: BoxFit.none),
              color: Colors.blue)),
      text: Text("Cardio", style: ThemeText.bodyBoldBlackText)),
  TrainingCategory(
      persoCategoryIcon: PersoTrainingCategoryIcon(
          trainingCategoryIcon: TrainingCategoryIcon(
              icon: SvgPicture.asset("assets/images/endurance.svg",
                  fit: BoxFit.none),
              color: Colors.orange)),
      text: Text("Endurance", style: ThemeText.bodyBoldBlackText)),
  TrainingCategory(
      persoCategoryIcon: PersoTrainingCategoryIcon(
          trainingCategoryIcon: TrainingCategoryIcon(
              icon: SvgPicture.asset("assets/images/gymnastics.svg",
                  fit: BoxFit.none),
              color: Colors.yellow)),
      text: Text("Gymnastics", style: ThemeText.bodyBoldBlackText)),
  TrainingCategory(
      persoCategoryIcon: PersoTrainingCategoryIcon(
          trainingCategoryIcon: TrainingCategoryIcon(
              icon: SvgPicture.asset("assets/images/crossfit.svg",
                  fit: BoxFit.none),
              color: Colors.pinkAccent)),
      text: Text("Crossfit", style: ThemeText.bodyBoldBlackText)),
];
