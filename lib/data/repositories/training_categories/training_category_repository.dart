import 'package:Perso/app/models/training_category/training_category.dart';

abstract class TrainingCategoryRepository {
  Future<List<TrainingCategory>> getCategoriesShortList();

  Future<List<TrainingCategory>> getAllCategories();
}
