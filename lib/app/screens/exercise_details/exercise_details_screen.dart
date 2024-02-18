import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:perso/app/screens/exercise_details/exercise_options/bloc/trainer_exercise_list_options_bloc.dart';
import 'package:perso/app/screens/exercise_details/exercise_options/event/trainer_exercise_list_options_event.dart';
import 'package:perso/app/screens/exercise_details/exercise_options/perso_trainer_exercise_options.dart';
import 'package:perso/app/screens/exercise_details/superset_section/perso_superset_section.dart';
import 'package:perso/app/screens/plan_overview/trainer/widgets/exercise_list/bloc/trainer_exercise_list_bloc.dart';
import 'package:perso/app/screens/plan_overview/trainer/widgets/exercise_list/event/trainer_exercise_list_event.dart';
import 'package:perso/app/styleguide/value/app_dimens.dart';
import 'package:perso/app/styleguide/value/app_typography.dart';
import 'package:perso/app/utils/extension/context_extensions.dart';
import 'package:perso/app/widgets/category_chips/perso_category_chips.dart';
import 'package:perso/app/widgets/perso_app_bar.dart';
import 'package:perso/app/widgets/perso_button.dart';
import 'package:perso/app/widgets/perso_divider.dart';
import 'package:perso/app/widgets/video_player/bloc/video_player_bloc.dart';
import 'package:perso/app/widgets/video_player/perso_video_player.dart';
import 'package:perso/core/models/exercise_in_training_entity.dart';
import 'package:perso/core/models/exercise_type.dart';

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
      appBar:
          PersoAppBar(title: _exerciseInTrainingEntity.exerciseEntity.title),
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
  const _Exercise({
    required String clientId,
    required String date,
    required ExerciseInTrainingEntity exerciseInTrainingEntity,
  })  : _exerciseInTrainingEntity = exerciseInTrainingEntity,
        _date = date,
        _clientId = clientId;

  final String _clientId;
  final String _date;
  final ExerciseInTrainingEntity _exerciseInTrainingEntity;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(top: Dimens.sMargin),
            child: PersoVideoPlayer(
              videoId: _exerciseInTrainingEntity.exerciseEntity.videoId,
            ),
          ),
          _DescriptionSection(
            clientId: _clientId,
            date: _date,
            exerciseInTrainingEntity: _exerciseInTrainingEntity,
          ),
          Container(
            margin: const EdgeInsets.only(top: Dimens.mMargin),
            child: const PersoDivider(),
          ),
          PersoTrainerExerciseOptionsSection(
            _clientId,
            _date,
            _exerciseInTrainingEntity,
          ),
          PersoSupersetSection(clientId: _clientId, date: _date),
          _Categories(
            _exerciseInTrainingEntity.exerciseEntity.tags,
          ),
          _SaveButton(
            clientId: _clientId,
            date: _date,
            exerciseInTrainingEntity: _exerciseInTrainingEntity,
          ),
        ],
      ),
    );
  }
}

class _SaveButton extends StatelessWidget {
  const _SaveButton({
    super.key,
    required String clientId,
    required String date,
    required ExerciseInTrainingEntity exerciseInTrainingEntity,
  })  : _clientId = clientId,
        _date = date,
        _exerciseInTrainingEntity = exerciseInTrainingEntity;

  final String _clientId;
  final String _date;
  final ExerciseInTrainingEntity _exerciseInTrainingEntity;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(Dimens.mMargin),
      child: PersoButton(
        title: 'Save',
        onTap: (context) {
          if (_key.currentState!.validate()) {
            switch (_optionsData.exerciseType) {
              case ExerciseType.repsBased:
                {
                  _optionsData = _optionsData.copyWith(
                    reps: int.parse(_repsController.text),
                    sets: int.parse(_setsController.text),
                    timeBreak: int.parse(_timeBreakController.text),
                  );
                }
              case ExerciseType.timeBased:
                {
                  final minutes = _minutesController.text.removeLeadingZeroes();
                  final seconds = _secondsController.text
                      .removeLeadingZeroes()
                      .limitToTwoDigits();
                  _optionsData = _optionsData.copyWith(
                    time: '$minutes:$seconds',
                  );
                }
              case ExerciseType.repsInReserve:
              // TODO: Handle this case.
              case ExerciseType.rateOfPerceivedExertion:
              // TODO: Handle this case.
              case ExerciseType.maxPercentage:
              // TODO: Handle this case.
            }
            context.read<TrainerExerciseListOptionsBloc>().add(
                  TrainerExerciseListOptionsEvent.editExerciseOptions(
                    clientId: _clientId,
                    date: _date,
                    exerciseInTrainingId: _exerciseInTrainingEntity.id,
                    exerciseOptionsData: _optionsData,
                  ),
                );
            context.showSuccessfulSnackBar('Saving succeeded');
          }
        },
      ),
    );
  }
}

class _DescriptionSection extends StatelessWidget {
  const _DescriptionSection({
    required String clientId,
    required String date,
    required ExerciseInTrainingEntity exerciseInTrainingEntity,
  })  : _exerciseInTrainingEntity = exerciseInTrainingEntity,
        _date = date,
        _clientId = clientId;

  final String _clientId;
  final String _date;
  final ExerciseInTrainingEntity _exerciseInTrainingEntity;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: Dimens.mMargin),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(
              top: Dimens.sMargin,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Description',
                  style: ThemeText.smallTitleBold,
                ),
                _ActionableIcon(
                  clientId: _clientId,
                  date: _date,
                  exerciseInTrainingId: _exerciseInTrainingEntity.id,
                ),
              ],
            ),
          ),
          Text(
            _exerciseInTrainingEntity.exerciseEntity.description,
            style: ThemeText.bodyRegularBlackText,
          ),
        ],
      ),
    );
  }
}

class _ActionableIcon extends StatelessWidget {
  const _ActionableIcon({
    required String clientId,
    required String date,
    required String exerciseInTrainingId,
  })  : _exerciseInTrainingId = exerciseInTrainingId,
        _date = date,
        _clientId = clientId;

  final String _clientId;
  final String _date;
  final String _exerciseInTrainingId;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(
        Icons.delete_forever,
        size: 32,
      ),
      onPressed: () {
        context.read<TrainerExerciseListBloc>().add(
              TrainerExerciseListEvent.removeExercise(
                _clientId,
                _date,
                _exerciseInTrainingId,
              ),
            );
      },
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
