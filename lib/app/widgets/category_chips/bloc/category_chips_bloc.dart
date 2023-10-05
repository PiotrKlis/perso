import 'package:Perso/app/widgets/category_chips/event/category_chips_event.dart';
import 'package:Perso/app/widgets/category_chips/state/category_chips_state.dart';
import 'package:Perso/core/dependency_injection/get_it_config.dart';
import 'package:Perso/data/training_categories/local_training_category_repository.dart';
import 'package:Perso/data/training_categories/training_category_source.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryChipsBloc extends Bloc<CategoryChipsEvent, CategoryChipsState> {
  final TrainingCategorySource _trainingCategorySource =
      getIt.get<LocalTrainingCategoryRepository>();

  CategoryChipsBloc() : super(const CategoryChipsState.initial()) {
    on<LoadData>((event, emitter) async {
      try {
        List<String> categories =
            await _trainingCategorySource.getAllCategoriesNames();
        emitter(CategoryChipsState.content(categories));
      } catch (error) {
        Future.error(error);
      }
    });
  }
}
