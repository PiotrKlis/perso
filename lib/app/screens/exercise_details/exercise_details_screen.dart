import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:perso/app/screens/exercise_details/exercise_options/perso_trainer_exercise_options.dart';
import 'package:perso/app/screens/exercise_details/save_options_button/perso_save_options_button.dart';
import 'package:perso/app/screens/exercise_details/superset_section/perso_superset_section.dart';
import 'package:perso/app/screens/exercise_details/time_break/perso_time_break_section.dart';
import 'package:perso/app/screens/plan_overview/trainer/widgets/exercise_list/bloc/trainer_exercise_list_bloc.dart';
import 'package:perso/app/screens/plan_overview/trainer/widgets/exercise_list/event/trainer_exercise_list_event.dart';
import 'package:perso/app/styleguide/value/app_dimens.dart';
import 'package:perso/app/styleguide/value/app_typography.dart';
import 'package:perso/app/widgets/category_chips/perso_category_chips.dart';
import 'package:perso/app/widgets/perso_app_bar.dart';
import 'package:perso/app/widgets/perso_divider.dart';
import 'package:perso/app/widgets/perso_text_field.dart';
import 'package:perso/app/widgets/video_player/bloc/video_player_bloc.dart';
import 'package:perso/app/widgets/video_player/perso_video_player.dart';
import 'package:perso/core/models/exercise_in_training_entity.dart';

class ExerciseDetailsScreen extends StatelessWidget {
  const ExerciseDetailsScreen({
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
    return Scaffold(
      appBar: PersoAppBar(
        title: _exerciseInTrainingEntity.exerciseEntity.title,
        actionIcon: Icons.delete_forever,
        onActionIconClick: (context) {
          //TODO: move providers into layer above
          context.read<TrainerExerciseListBloc>().add(
                TrainerExerciseListEvent.removeExercise(
                  _clientId,
                  _date,
                  _exerciseInTrainingEntity.id,
                ),
              );
          context.pop();
        },
      ),
      body: BlocProvider(
        create: (context) => VideoPlayerBloc(),
        child: _Exercise(
          clientId: _clientId,
          date: _date,
          exerciseInTrainingEntity: _exerciseInTrainingEntity,
        ),
      ),
    );
  }
}

class _Exercise extends StatelessWidget {
  _Exercise({
    required String clientId,
    required String date,
    required ExerciseInTrainingEntity exerciseInTrainingEntity,
  })  : _exerciseInTrainingEntity = exerciseInTrainingEntity,
        _date = date,
        _clientId = clientId;

  final String _clientId;
  final String _date;
  final ExerciseInTrainingEntity _exerciseInTrainingEntity;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PersoVideoPlayer(
            videoId: _exerciseInTrainingEntity.exerciseEntity.videoId,
          ),
          _Categories(
            _exerciseInTrainingEntity.exerciseEntity.tags,
          ),
          _DescriptionSection(
            description: _exerciseInTrainingEntity.exerciseEntity.description,
          ),
          PersoTrainerExerciseOptionsSection(
            formKey: _formKey,
            exerciseOptionsData:
                _exerciseInTrainingEntity.exerciseEntity.exerciseOptionsData,
          ),
          PersoTimeBreakSection(
            formKey: _formKey,
            timeBreak: _exerciseInTrainingEntity
                .exerciseEntity.exerciseOptionsData.timeBreak,
          ),
          PersoSupersetSection(clientId: _clientId, date: _date),
          const _TrainerNote(),
          PersoSaveOptionsButton(
            clientId: _clientId,
            date: _date,
            exerciseInTrainingId: _exerciseInTrainingEntity.id,
            formKey: _formKey,
            exerciseOptionsData:
                _exerciseInTrainingEntity.exerciseEntity.exerciseOptionsData,
          ),
        ],
      ),
    );
  }
}

class _TrainerNote extends StatelessWidget {
  const _TrainerNote();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(
        Dimens.mMargin,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Trainer note', style: ThemeText.smallTitleBold),
          Container(
            margin: const EdgeInsets.only(top: Dimens.mMargin),
            height: 140,
            child: const PersoTextField(
              title: 'Write a note for the client on the exercise...',
              isMultiLine: true,
              maxLength: 150,
              // textEditingController: _trainerNoteController,
            ),
          ),
        ],
      ),
    );
  }
}

class _DescriptionSection extends StatelessWidget {
  const _DescriptionSection({
    required String description,
  }) : _description = description;

  final String _description;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(Dimens.mMargin),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Description',
            style: ThemeText.smallTitleBold,
          ),
          Container(
            margin: const EdgeInsets.only(top: Dimens.mMargin),
            child: Text(
              _description,
              style: ThemeText.bodyRegularBlackText,
            ),
          ),
        ],
      ),
    );
  }
}

class _Categories extends StatelessWidget {
  const _Categories(this._categories);

  final List<String> _categories;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: Dimens.sMargin),
      child: PersoCategoryChips(
        categories: _categories,
      ),
    );
  }
}
