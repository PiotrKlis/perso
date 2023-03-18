import 'package:Perso/app/models/training_category/training_category.dart';
import 'package:Perso/data/providers/training_category_provider.dart';

class FirebaseTrainingCategoryProvider with TrainingCategoryProvider {
  @override
  Future<List<TrainingCategory>> getAllCategories() {
    return Future.value();
  }

  @override
  Future<List<TrainingCategory>> getCategoriesShortList() {
    return Future.value();
  }
}
