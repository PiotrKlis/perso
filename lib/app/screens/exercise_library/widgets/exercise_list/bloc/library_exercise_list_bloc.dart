import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:perso/app/screens/exercise_library/widgets/exercise_list/event/library_exercise_list_event.dart';
import 'package:perso/app/screens/exercise_library/widgets/exercise_list/state/library_exercise_list_state.dart';
import 'package:perso/core/dependency_injection/get_it.dart';
import 'package:perso/core/models/user_session_model.dart';
import 'package:perso/data/exercises/exercises_service/firestore_exercise_service.dart';
import 'package:perso/data/exercises/exercises_source/firestore_exercise_provider.dart';

class LibraryExerciseListBloc
    extends Bloc<LibraryExerciseListEvent, LibraryExerciseListState> {
  LibraryExerciseListBloc() : super(const LibraryExerciseListState.init()) {
    final trainerId = _userSessionModel.user?.uid ?? '';

    on<GetAllLibraryExercises>((event, emitter) async {
      try {
        final exercises = await _exercisesProvider.getAllExercises();
        emitter(LibraryExerciseListState.exercises(exercises));
      } catch (error) {
        emitter(LibraryExerciseListState.error(error.toString()));
      }
    });

    on<Add>((event, emitter) async {
      try {
        await _exercisesService.add(
          event.clientId,
          trainerId,
          event.date,
          event.exerciseEntity.copyWith(index: _currentExerciseIndex),
        );
        _currentExerciseIndex++;
      } catch (error) {
        emitter(LibraryExerciseListState.error(error.toString()));
      }
    });

    on<UpdateNumberOfAlreadyPresentExercises>((event, emitter) async {
      try {
        final numberOfExercises = await _exercisesProvider.getNumberOfExercises(
          event.clientId,
          trainerId,
          event.date,
        );
        _currentExerciseIndex = numberOfExercises;
      } catch (error) {
        emitter(LibraryExerciseListState.error(error.toString()));
      }
    });

    // on<GetExercises>((event, emitter) async {
    //   try {
    //     final exercisesStream = _exercisesProvider.getExercisesForTrainer(
    //       event.clientId,
    //       trainerId,
    //       event.date,
    //     );
    //     await for (final exercises in exercisesStream) {
    //       exercises.sort((a, b) =>
    //           a.exerciseEntity.index.compareTo(b.exerciseEntity.index));
    //       emitter(TrainerExerciseListState.exercises(exercises));
    //     }
    //   } catch (error) {
    //     emitter(TrainerExerciseListState.error(error.toString()));
    //   }
    // });
    //
  }

  final _userSessionModel = getIt.get<UserSessionModel>();
  final _exercisesProvider = getIt.get<FirestoreExerciseProvider>();
  final _exercisesService = getIt.get<FirestoreExerciseService>();
  var _currentExerciseIndex = 0;
}
