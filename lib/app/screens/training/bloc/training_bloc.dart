import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:perso/app/screens/training/event/training_event.dart';
import 'package:perso/app/screens/training/state/training_state.dart';
import 'package:perso/core/dependency_injection/get_it.dart';
import 'package:perso/data/exercises/exercises_source/firestore_exercise_provider.dart';

class TrainingBloc extends Bloc<TrainingEvent, TrainingState> {
  final _exerciseProvider = getIt.get<FirestoreExerciseProvider>();

  TrainingBloc() : super(const TrainingState.initial()) {
    on<LoadTraining>((event, emitter) async {
      emitter(const TrainingState.loading());

    });
    on<NextExercise>((event, emitter) async {});
    on<PreviousExercise>((event, emitter) async {});
    on<Stop>((event, emitter) async {});
    on<Start>((event, emitter) async {});
  }
}
