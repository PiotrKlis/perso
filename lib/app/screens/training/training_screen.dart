import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:perso/app/screens/training/bloc/training_bloc.dart';
import 'package:perso/app/screens/training/event/training_event.dart';
import 'package:perso/app/screens/training/exercise_break_screen.dart';
import 'package:perso/app/screens/training/exercise_in_progress_screen.dart';
import 'package:perso/app/screens/training/state/training_state.dart';
import 'package:perso/app/widgets/perso_app_bar.dart';

class TrainingScreen extends StatelessWidget {
  const TrainingScreen(
      {required this.trainerId, required this.date, super.key});

  final String trainerId;
  final String date;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) =>
          TrainingBloc()..add(const TrainingEvent.loadTraining()),
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
            error: (error) => Center(
              child: Text(error),
            ),
            exerciseInProgress: (exerciseEntity) => ExercisesInProgressScreen(
              exercise: exerciseEntity,
            ),
            trainingBreak: ExerciseBreakScreen.new,
            loading: CircularProgressIndicator.new,
          );
        },
      ),
    );
  }
}
