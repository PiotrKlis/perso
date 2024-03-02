import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:perso/app/screens/exercise_details/bloc/exercise_details_bloc.dart';
import 'package:perso/app/screens/exercise_details/widgets/perso_plan_overview_exercise_details.dart';
import 'package:perso/app/widgets/perso_app_bar.dart';
import 'package:perso/core/models/exercise_in_training_entity.dart';

class PlanOverviewExerciseDetailsScreen extends StatelessWidget {
  const PlanOverviewExerciseDetailsScreen({
    required String clientId,
    required String date,
    required ExerciseInTrainingEntity exerciseInTrainingEntity,
    super.key,
  })  : _exerciseInTrainingEntity = exerciseInTrainingEntity,
        _date = date,
        _clientId = clientId;

  final String _clientId;
  final String _date;
  final ExerciseInTrainingEntity _exerciseInTrainingEntity;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ExerciseDetailsBloc(),
      child: Scaffold(
        appBar: PersoAppBar(
          title: _exerciseInTrainingEntity.exerciseEntity.title,
        ),
        body: PersoPlanOverviewExerciseDetails(
          clientId: _clientId,
          date: _date,
          exerciseInTrainingEntity: _exerciseInTrainingEntity,
        ),
      ),
    );
  }
}
