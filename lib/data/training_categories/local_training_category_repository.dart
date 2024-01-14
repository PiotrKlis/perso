import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:perso/app/models/training_category/training_category.dart';
import 'package:perso/app/models/training_category/training_category_icon.dart';
import 'package:perso/app/styleguide/value/app_assets.dart';
import 'package:perso/app/utils/constants.dart';
import 'package:perso/data/training_categories/training_category_source.dart';

@injectable
class LocalTrainingCategoryRepository implements TrainingCategorySource {
  @override
  Future<List<TrainingCategory>> getCategoriesShortList() {
    return Future.value(
      _dummyTrainingCategories
          .take(Constants.trainingCategoryShortListNumber)
          .toList(),
    );
  }

  @override
  Future<List<TrainingCategory>> getAllCategories() {
    return Future.value(_dummyTrainingCategories);
  }

  @override
  Future<List<String>> getAllCategoriesNames() {
    return Future.value(
      _dummyTrainingCategories.map((element) => element.name).toList(),
    );
  }

  final List<TrainingCategory> _dummyTrainingCategories = [
    const TrainingCategory(
      trainingCategoryIcon: TrainingCategoryIcon(
        path: AppVectors.bodybuilding,
        color: Colors.deepPurpleAccent,
      ),
      name: 'Bodybuilding',
    ),
    const TrainingCategory(
      trainingCategoryIcon: TrainingCategoryIcon(
        path: AppVectors.yoga,
        color: Colors.green,
      ),
      name: 'Yoga',
    ),
    const TrainingCategory(
      trainingCategoryIcon: TrainingCategoryIcon(
        path: AppVectors.calisthenics,
        color: Colors.greenAccent,
      ),
      name: 'Calisthenics',
    ),
    const TrainingCategory(
      trainingCategoryIcon: TrainingCategoryIcon(
        path: AppVectors.cardio,
        color: Colors.blue,
      ),
      name: 'Cardio',
    ),
    const TrainingCategory(
      trainingCategoryIcon: TrainingCategoryIcon(
        path: AppVectors.endurance,
        color: Colors.orange,
      ),
      name: 'Endurance',
    ),
    const TrainingCategory(
      trainingCategoryIcon: TrainingCategoryIcon(
        path: AppVectors.gymnastics,
        color: Colors.yellow,
      ),
      name: 'Gymnastics',
    ),
    const TrainingCategory(
      trainingCategoryIcon: TrainingCategoryIcon(
        path: AppVectors.crossfit,
        color: Colors.pinkAccent,
      ),
      name: 'Crossfit',
    ),
  ];
}
