import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:perso/app/screens/exercise_details/bloc/exercise_details_bloc.dart';
import 'package:perso/app/screens/exercise_details/exercise_details_inherited_widget.dart';
import 'package:perso/app/screens/exercise_details/model/exercise_details_screen_type.dart';
import 'package:perso/app/screens/exercise_details/state/exercise_details_state.dart';
import 'package:perso/app/screens/exercise_details/widgets/perso_exercise_categories.dart';
import 'package:perso/app/screens/exercise_details/widgets/perso_exercise_details_buttons_section.dart';
import 'package:perso/app/screens/exercise_details/widgets/perso_exercise_details_save_button.dart';
import 'package:perso/app/screens/exercise_details/widgets/perso_exercise_options.dart';
import 'package:perso/app/screens/exercise_details/widgets/perso_instructions_section.dart';
import 'package:perso/app/screens/exercise_details/widgets/perso_superset_section.dart';
import 'package:perso/app/screens/exercise_details/widgets/perso_time_break_section.dart';
import 'package:perso/app/screens/exercise_details/widgets/perso_trainer_note.dart';
import 'package:perso/app/styleguide/value/app_dimens.dart';
import 'package:perso/app/widgets/app_bar/perso_app_bar.dart';
import 'package:perso/app/widgets/video_player/perso_video_player.dart';
import 'package:perso/core/models/exercise_in_training_entity.dart';

class ExerciseDetailsScreen extends StatelessWidget {
  const ExerciseDetailsScreen({
    required String clientId,
    required String date,
    required ExerciseInTrainingEntity exerciseInTrainingEntity,
    required String exerciseDetailsScreenType,
    super.key,
  })  : _exerciseDetailScreenType = exerciseDetailsScreenType,
        _exerciseInTrainingEntity = exerciseInTrainingEntity,
        _date = date,
        _clientId = clientId;

  final String _clientId;
  final String _date;
  final ExerciseInTrainingEntity _exerciseInTrainingEntity;
  final String _exerciseDetailScreenType;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ExerciseDetailsBloc(),
      child: _ExerciseDetailsScreenContent(
        exerciseInTrainingEntity: _exerciseInTrainingEntity,
        clientId: _clientId,
        date: _date,
        exerciseDetailScreenType: _exerciseDetailScreenType,
      ),
    );
  }
}

class _ExerciseDetailsScreenContent extends StatelessWidget {
  const _ExerciseDetailsScreenContent({
    required ExerciseInTrainingEntity exerciseInTrainingEntity,
    required String clientId,
    required String date,
    required String exerciseDetailScreenType,
  })  : _exerciseInTrainingEntity = exerciseInTrainingEntity,
        _clientId = clientId,
        _date = date,
        _exerciseDetailScreenType = exerciseDetailScreenType;

  final ExerciseInTrainingEntity _exerciseInTrainingEntity;
  final String _clientId;
  final String _date;
  final String _exerciseDetailScreenType;

  @override
  Widget build(BuildContext context) {
    return BlocListener<ExerciseDetailsBloc, ExerciseDetailsState>(
      listener: (context, state) {
        state.whenOrNull(
          updated: () => context.pop(),
        );
      },
      child: Scaffold(
        appBar: PersoAppBar(
          title: _exerciseInTrainingEntity.exerciseEntity.title,
        ),
        body: SingleChildScrollView(
          child: ExerciseInheritedWidget(
            clientId: _clientId,
            date: _date,
            exerciseDetailScreenType:
                _exerciseDetailScreenType.toExerciseDetailsScreenType(),
            exerciseInTrainingEntity: _exerciseInTrainingEntity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                PersoVideoPlayer(
                  videoId: _exerciseInTrainingEntity.exerciseEntity.videoId,
                ),
                const PersoExerciseCategories(),
                const PersoInstructionsSection(),
                const PersoExerciseOptionsSection(),
                const PersoTimeBreakSection(),
                const PersoSupersetSection(),
                const PersoTrainerNote(),
                const _ButtonSection(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ButtonSection extends StatelessWidget {
  const _ButtonSection();

  @override
  Widget build(BuildContext context) {
    final exerciseInheritedWidget = ExerciseInheritedWidget.of(context);
    return switch (exerciseInheritedWidget.exerciseDetailScreenType) {
      ExerciseDetailsScreenType.client => Container(),
      ExerciseDetailsScreenType.trainer =>
        const PersoExerciseDetailsButtonsSection(),
      ExerciseDetailsScreenType.library => Container(
          margin: const EdgeInsets.all(Dimens.mMargin),
          child: const PersoExerciseDetailsSaveButton(),
        ),
    };
  }
}
