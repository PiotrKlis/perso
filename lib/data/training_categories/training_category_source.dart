import 'package:perso/app/models/training_category/training_category.dart';

abstract class TrainingCategorySource {
  Future<List<TrainingCategory>> getCategoriesShortList();

  Future<List<TrainingCategory>> getAllCategories();

  Future<List<String>> getAllCategoriesNames();
}
