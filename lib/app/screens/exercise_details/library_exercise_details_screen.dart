import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:perso/app/screens/exercise_details/bloc/exercise_details_bloc.dart';
import 'package:perso/app/screens/exercise_details/event/exercise_details_event.dart';
import 'package:perso/app/screens/exercise_details/exercise_details_inherited_widget.dart';
import 'package:perso/app/screens/exercise_details/widgets/perso_description_section.dart';
import 'package:perso/app/screens/exercise_details/widgets/perso_library_exercise_details.dart';
import 'package:perso/app/screens/exercise_details/widgets/perso_exercise_categories.dart';
import 'package:perso/app/screens/exercise_details/widgets/perso_exercise_options.dart';
import 'package:perso/app/screens/exercise_details/widgets/perso_exercise_details_buttons_section.dart';
import 'package:perso/app/screens/exercise_details/widgets/perso_superset_section.dart';
import 'package:perso/app/screens/exercise_details/widgets/perso_time_break_section.dart';
import 'package:perso/app/screens/exercise_details/widgets/perso_trainer_note.dart';
import 'package:perso/app/widgets/perso_app_bar.dart';
import 'package:perso/app/widgets/video_player/perso_video_player.dart';
import 'package:perso/core/models/exercise_in_training_entity.dart';

class LibraryExerciseDetailsScreen extends StatelessWidget {
  const LibraryExerciseDetailsScreen({
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
      child: _LibraryExerciseDetailsScreenContent(
        exerciseInTrainingEntity: _exerciseInTrainingEntity,
        clientId: _clientId,
        date: _date,
      ),
    );
  }
}

class _LibraryExerciseDetailsScreenContent extends StatefulWidget {
  const _LibraryExerciseDetailsScreenContent({
    required ExerciseInTrainingEntity exerciseInTrainingEntity,
    required String clientId,
    required String date,
  })  : _exerciseInTrainingEntity = exerciseInTrainingEntity,
        _clientId = clientId,
        _date = date;

  final ExerciseInTrainingEntity _exerciseInTrainingEntity;
  final String _clientId;
  final String _date;

  @override
  State<_LibraryExerciseDetailsScreenContent> createState() =>
      _LibraryExerciseDetailsScreenContentState();
}

class _LibraryExerciseDetailsScreenContentState
    extends State<_LibraryExerciseDetailsScreenContent> {
  @override
  void initState() {
    super.initState();
    context.read<ExerciseDetailsBloc>().add(
          ExerciseDetailsEvent.getNumberOfExercises(
            clientId: widget._clientId,
            date: widget._date,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PersoAppBar(
        title: widget._exerciseInTrainingEntity.exerciseEntity.title,
      ),
      body: PersoLibraryExerciseDetails(
        clientId: widget._clientId,
        date: widget._date,
        exerciseInTrainingEntity: widget._exerciseInTrainingEntity,
      ),
    );
  }
}
