import 'package:perso/app/models/training_category/training_category.dart';
import 'package:perso/app/widgets/training_category_list/event/training_category_list_event.dart';
import 'package:perso/app/widgets/training_category_list/state/training_category_list_state.dart';
import 'package:perso/core/dependency_injection/get_it.dart';
import 'package:perso/data/training_categories/local_training_category_repository.dart';
import 'package:perso/data/training_categories/training_category_source.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TrainingCategoryListBloc
    extends Bloc<TrainingCategoryListEvent, TrainingCategoryListState> {
  final TrainingCategorySource _trainingCategoryRepository =
      getIt.get<LocalTrainingCategoryRepository>();

  TrainingCategoryListBloc()
      : super(const TrainingCategoryListState.initial()) {
    on<LoadAll>((event, emitter) async {
      try {
        List<TrainingCategory> categories =
            await _trainingCategoryRepository.getAllCategories();
        emitter(TrainingCategoryListState.content(categories: categories));
      } catch (error) {
        emitter(TrainingCategoryListState.error(error: error.toString()));
      }
    });

    on<LoadShortList>((event, emitter) async {
      try {
        List<TrainingCategory> categories =
            await _trainingCategoryRepository.getCategoriesShortList();
        emitter(TrainingCategoryListState.content(categories: categories));
      } catch (error) {
        emitter(TrainingCategoryListState.error(error: error.toString()));
      }
    });
  }
}
