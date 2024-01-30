import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:perso/app/screens/plan_overview/exercise_options_data.dart';
import 'package:perso/app/screens/plan_overview/trainer/widgets/exercise_options/bloc/trainer_exercise_list_options_bloc.dart';
import 'package:perso/app/screens/plan_overview/trainer/widgets/exercise_options/event/trainer_exercise_list_options_event.dart';
import 'package:perso/app/screens/plan_overview/trainer/widgets/exercise_options/state/trainer_exercise_list_options_state.dart';
import 'package:perso/app/styleguide/value/app_dimens.dart';
import 'package:perso/app/styleguide/value/app_typography.dart';
import 'package:perso/app/widgets/perso_text_field.dart';
import 'package:perso/core/models/exercise_in_training_entity.dart';
import 'package:perso/core/models/exercise_type.dart';

class PersoTrainerExerciseOptionsSection extends StatelessWidget {
  const PersoTrainerExerciseOptionsSection(
    this._clientId,
    this._date,
    this._exerciseInTrainingEntity, {
    super.key,
  });

  final String _clientId;
  final String _date;
  final ExerciseInTrainingEntity _exerciseInTrainingEntity;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TrainerExerciseListOptionsBloc(),
      child: _OptionsSectionContent(
        _clientId,
        _date,
        _exerciseInTrainingEntity,
      ),
    );
  }
}

class _OptionsSectionContent extends StatefulWidget {
  const _OptionsSectionContent(
    this._clientId,
    this._date,
    this._exerciseInTrainingEntity,
  );

  final String _clientId;
  final String _date;
  final ExerciseInTrainingEntity _exerciseInTrainingEntity;

  @override
  State<_OptionsSectionContent> createState() => _OptionsSectionContentState();
}

class _OptionsSectionContentState extends State<_OptionsSectionContent> {
  late ExerciseOptionsData _optionsData;

  @override
  void initState() {
    _optionsData = ExerciseOptionsData(
      exerciseType:
          widget._exerciseInTrainingEntity.exerciseEntity.exerciseType,
      reps: widget._exerciseInTrainingEntity.exerciseEntity.reps.toString(),
      sets: widget._exerciseInTrainingEntity.exerciseEntity.sets.toString(),
      time: widget._exerciseInTrainingEntity.exerciseEntity.time,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<TrainerExerciseListOptionsBloc,
        TrainerExerciseListOptionsState>(
      listener: (context, state) {
        state.whenOrNull(
          exerciseOptionsDataUpdate: (optionsData) {
            setState(() {
              _optionsData = optionsData;
            });
          },
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(
              left: Dimens.mMargin,
              right: Dimens.sMargin,
              top: Dimens.mMargin,
            ),
            child: Text(
              'Options',
              style: ThemeText.smallTitleBold,
            ),
          ),
          RadioListTile(
            title: const Text('Reps based exercise'),
            value: ExerciseType.repsBased,
            groupValue: _optionsData.exerciseType,
            onChanged: (exerciseType) {
              if (exerciseType != _optionsData.exerciseType) {
                setState(() {
                  _optionsData =
                      _optionsData.copyWith(exerciseType: exerciseType!);
                  context.read<TrainerExerciseListOptionsBloc>().add(
                        TrainerExerciseListOptionsEvent.editExerciseType(
                          widget._clientId,
                          widget._date,
                          widget._exerciseInTrainingEntity.id,
                          _optionsData,
                        ),
                      );
                });
              }
            },
          ),
          RadioListTile(
            title: const Text('Time based exercise'),
            value: ExerciseType.timeBased,
            groupValue: _optionsData.exerciseType,
            onChanged: (exerciseType) {
              if (exerciseType != _optionsData.exerciseType) {
                setState(() {
                  _optionsData =
                      _optionsData.copyWith(exerciseType: exerciseType!);
                  context.read<TrainerExerciseListOptionsBloc>().add(
                        TrainerExerciseListOptionsEvent.editExerciseType(
                          widget._clientId,
                          widget._date,
                          widget._exerciseInTrainingEntity.id,
                          _optionsData,
                        ),
                      );
                });
              }
            },
          ),
          Visibility(
            visible: _optionsData.exerciseType == ExerciseType.repsBased,
            child: _RepsBasedExerciseOptions(
              clientId: widget._clientId,
              date: widget._date,
              exerciseId: widget._exerciseInTrainingEntity.id,
              optionsData: _optionsData,
            ),
          ),
          Visibility(
            visible: _optionsData.exerciseType == ExerciseType.timeBased,
            child: _TimeBasedExerciseOptions(
              optionsData: _optionsData,
              date: widget._date,
              clientId: widget._clientId,
              exerciseId: widget._exerciseInTrainingEntity.id,
            ),
          ),
        ],
      ),
    );
  }
}

class _RepsBasedExerciseOptions extends StatefulWidget {
  const _RepsBasedExerciseOptions({
    required String clientId,
    required String date,
    required String exerciseId,
    required ExerciseOptionsData optionsData,
  })  : _clientId = clientId,
        _date = date,
        _exerciseId = exerciseId,
        _optionsData = optionsData;

  final String _clientId;
  final String _date;
  final String _exerciseId;
  final ExerciseOptionsData _optionsData;

  @override
  State<_RepsBasedExerciseOptions> createState() =>
      _RepsBasedExerciseOptionsState();
}

class _RepsBasedExerciseOptionsState extends State<_RepsBasedExerciseOptions> {
  final _repsController = TextEditingController();
  final _setsController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _repsController.text = widget._optionsData.reps;
    _setsController.text = widget._optionsData.sets;
    _repsController.addListener(() {
      final updatedOptions = widget._optionsData.copyWith(
        reps: _repsController.text,
        sets: _setsController.text,
      );
      context.read<TrainerExerciseListOptionsBloc>().add(
            TrainerExerciseListOptionsEvent.editReps(
              widget._clientId,
              widget._date,
              widget._exerciseId,
              updatedOptions,
            ),
          );
    });
    _setsController.addListener(() {
      final updatedOptions = widget._optionsData.copyWith(
        reps: _repsController.text,
        sets: _setsController.text,
      );
      context.read<TrainerExerciseListOptionsBloc>().add(
            TrainerExerciseListOptionsEvent.editReps(
              widget._clientId,
              widget._date,
              widget._exerciseId,
              updatedOptions,
            ),
          );
    });
    return Container(
      margin: const EdgeInsets.only(
        top: Dimens.sMargin,
        left: Dimens.sMargin,
        right: Dimens.sMargin,
        bottom: Dimens.mMargin,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            child: PersoTextField(
              textEditingController: _setsController,
              textInputType: TextInputType.number,
              title: 'Sets',
            ),
          ),
          const SizedBox(
            width: 8,
          ),
          Expanded(
            child: PersoTextField(
              textEditingController: _repsController,
              textInputType: TextInputType.number,
              title: 'Repetitions',
            ),
          ),
        ],
      ),
    );
  }
}

class _TimeBasedExerciseOptions extends StatelessWidget {
  _TimeBasedExerciseOptions({
    required ExerciseOptionsData optionsData,
    required String clientId,
    required String date,
    required String exerciseId,
  })  : _clientId = clientId,
        _date = date,
        _exerciseId = exerciseId,
        _optionsData = optionsData;

  final String _date;
  final String _clientId;
  final String _exerciseId;
  final ExerciseOptionsData _optionsData;
  final _minutesController = TextEditingController();
  final _secondsController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final time = _optionsData.time.split(':');
    final minutes = time[0];
    final seconds = time[1];
    _minutesController.text = minutes;
    _secondsController.text = seconds;
    _minutesController.addListener(() {
      final time = '${_minutesController.text}:${_secondsController.text}';
      final updatedOptions = _optionsData.copyWith(
        time: time,
      );
      context.read<TrainerExerciseListOptionsBloc>().add(
            TrainerExerciseListOptionsEvent.editTime(
              _clientId,
              _date,
              _exerciseId,
              updatedOptions,
            ),
          );
    });
    _secondsController.addListener(() {
      final time = '${_minutesController.text}:${_secondsController.text}';
      final updatedOptions = _optionsData.copyWith(
        time: time,
      );
      context.read<TrainerExerciseListOptionsBloc>().add(
            TrainerExerciseListOptionsEvent.editTime(
              _clientId,
              _date,
              _exerciseId,
              updatedOptions,
            ),
          );
    });
    return Container(
      margin: const EdgeInsets.only(
        top: Dimens.sMargin,
        left: Dimens.sMargin,
        right: Dimens.sMargin,
        bottom: Dimens.mMargin,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: PersoTextField(
              textEditingController: _minutesController,
              title: 'Minutes',
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(
              horizontal: 8,
            ),
            child: Text(
              ':',
              style: ThemeText.bodyBoldBlackText,
            ),
          ),
          Expanded(
            child: PersoTextField(
              textEditingController: _secondsController,
              title: 'Seconds',
            ),
          ),
        ],
      ),
    );
  }
}
