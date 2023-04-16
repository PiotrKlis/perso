import 'package:Perso/app/models/training_category/training_category.dart';
import 'package:Perso/app/models/training_category/training_category_icon.dart';
import 'package:Perso/app/utils/constants.dart';
import 'package:Perso/data/training_categories/training_category_source.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@injectable
class LocalTrainingCategoryRepository implements TrainingCategorySource {
  @override
  Future<List<TrainingCategory>> getCategoriesShortList() {
    return Future.value(_dummyTrainingCategories
        .take(Constants.trainingCategoryShortListNumber)
        .toList());
  }

  @override
  Future<List<TrainingCategory>> getAllCategories() {
    return Future.value(_dummyTrainingCategories);
  }

  final List<TrainingCategory> _dummyTrainingCategories = [
    const TrainingCategory(
        trainingCategoryIcon: TrainingCategoryIcon(
            path: "assets/images/bodybuilding.svg",
            color: Colors.deepPurpleAccent),
        name: "Bodybuilding"),
    const TrainingCategory(
        trainingCategoryIcon: TrainingCategoryIcon(
            path: "assets/images/yoga.svg", color: Colors.green),
        name: "Yoga"),
    const TrainingCategory(
        trainingCategoryIcon: TrainingCategoryIcon(
            path: "assets/images/calisthenics.svg", color: Colors.greenAccent),
        name: "Calisthenics"),
    const TrainingCategory(
        trainingCategoryIcon: TrainingCategoryIcon(
            path: "assets/images/cardio.svg", color: Colors.blue),
        name: "Cardio"),
    const TrainingCategory(
        trainingCategoryIcon: TrainingCategoryIcon(
            path: "assets/images/endurance.svg", color: Colors.orange),
        name: "Endurance"),
    const TrainingCategory(
        trainingCategoryIcon: TrainingCategoryIcon(
            path: "assets/images/gymnastics.svg", color: Colors.yellow),
        name: "Gymnastics"),
    const TrainingCategory(
        trainingCategoryIcon: TrainingCategoryIcon(
            path: "assets/images/crossfit.svg", color: Colors.pinkAccent),
        name: "Crossfit"),
  ];
}
