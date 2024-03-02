import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:perso/app/screens/exercise_library/widgets/exercise_list/event/library_exercise_list_event.dart';
import 'package:perso/app/screens/exercise_library/widgets/exercise_list/state/library_exercise_list_state.dart';
import 'package:perso/core/dependency_injection/get_it.dart';
import 'package:perso/data/exercises/exercises_source/firestore_exercise_provider.dart';

class LibraryExerciseListBloc
    extends Bloc<LibraryExerciseListEvent, LibraryExerciseListState> {
  LibraryExerciseListBloc() : super(const LibraryExerciseListState.init()) {
    on<GetAllLibraryExercises>((event, emitter) async {
      try {
        final exercises = await _exercisesProvider.getAllExercises();
        emitter(LibraryExerciseListState.exercises(exercises));
      } catch (error) {
        emitter(LibraryExerciseListState.error(error.toString()));
      }
    });
  }

  final _exercisesProvider = getIt.get<FirestoreExerciseProvider>();
}
