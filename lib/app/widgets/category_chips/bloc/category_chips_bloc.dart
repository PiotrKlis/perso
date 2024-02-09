import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:perso/app/widgets/category_chips/event/category_chips_event.dart';
import 'package:perso/app/widgets/category_chips/state/category_chips_state.dart';
import 'package:perso/core/dependency_injection/get_it.dart';
import 'package:perso/data/training_categories/local_training_category_repository.dart';
import 'package:perso/data/training_categories/training_category_source.dart';

class CategoryChipsBloc extends Bloc<CategoryChipsEvent, CategoryChipsState> {
  CategoryChipsBloc() : super(const CategoryChipsState.initial()) {
    on<LoadAllCategories>((event, emitter) async {
      try {
        final categories =
            await _trainingCategorySource.getAllCategoriesNames();
        emitter(CategoryChipsState.content(categories));
      } catch (error) {
        return Future.error(error);
      }
    });
  }

  final TrainingCategorySource _trainingCategorySource =
      getIt.get<LocalTrainingCategoryRepository>();
}
