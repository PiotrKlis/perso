import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:perso/app/screens/training/bloc/training_bloc.dart';
import 'package:perso/app/screens/training/event/training_event.dart';
import 'package:perso/app/screens/training/exercise_break_screen.dart';
import 'package:perso/app/screens/training/exercise_in_progress_screen.dart';
import 'package:perso/app/screens/training/state/training_state.dart';
import 'package:perso/app/widgets/perso_app_bar.dart';
import 'package:perso/core/models/exercise_entity.dart';

class TrainingScreen extends StatelessWidget {
  const TrainingScreen({required this.exercises, super.key});

  final List<ExerciseEntity> exercises;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) =>
          TrainingBloc()..add(TrainingEvent.loadTraining(exercises)),
      child: const _TrainingScreenContent(),
    );
  }
}

class _TrainingScreenContent extends StatelessWidget {
  const _TrainingScreenContent();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PersoAppBar(title: 'Training'),
      body: BlocBuilder<TrainingBloc, TrainingState>(
        builder: (context, state) {
          return state.when(
            initial: Container.new,
            exerciseInProgress: (exerciseEntity) => ExercisesInProgressScreen(
              exercise: exerciseEntity,
            ),
            trainingBreak: (breakEntity) {
              return ExerciseBreakScreen(
                breakEntity: breakEntity,
              );
            },
          );
        },
      ),
    );
  }
}
