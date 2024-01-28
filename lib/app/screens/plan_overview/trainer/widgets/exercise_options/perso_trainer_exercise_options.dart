import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:perso/app/screens/plan_overview/trainer/widgets/exercise_options/bloc/trainer_exercise_list_options_bloc.dart';
import 'package:perso/app/screens/plan_overview/trainer/widgets/exercise_options/event/trainer_exercise_list_options_event.dart';
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
        child: _OptionsContent(
          _clientId,
          _date,
          _exerciseInTrainingEntity,
        ));
  }
}

class _OptionsContent extends StatefulWidget {
  const _OptionsContent(
    this._clientId,
    this._date,
    this._exerciseInTrainingEntity,
  );

  final String _clientId;
  final String _date;
  final ExerciseInTrainingEntity _exerciseInTrainingEntity;

  @override
  State<_OptionsContent> createState() => _OptionsContentState();
}

class _OptionsContentState extends State<_OptionsContent> {
  ExerciseType? _exerciseType;

  @override
  void initState() {
    _exerciseType =
        widget._exerciseInTrainingEntity.exerciseEntity.exerciseType;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
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
          groupValue: _exerciseType,
          onChanged: (exerciseType) {
            if (exerciseType != _exerciseType) {
              context.read<TrainerExerciseListOptionsBloc>().add(
                    TrainerExerciseListOptionsEvent.editExerciseType(
                      widget._clientId,
                      widget._date,
                      widget._exerciseInTrainingEntity.id,
                      exerciseType!,
                    ),
                  );
              setState(() {
                _exerciseType = exerciseType;
              });
            }
          },
        ),
        RadioListTile(
          title: const Text('Time based exercise'),
          value: ExerciseType.timeBased,
          groupValue: _exerciseType,
          onChanged: (exerciseType) {
            if (exerciseType != _exerciseType) {
              context.read<TrainerExerciseListOptionsBloc>().add(
                    TrainerExerciseListOptionsEvent.editExerciseType(
                      widget._clientId,
                      widget._date,
                      widget._exerciseInTrainingEntity.id,
                      exerciseType!,
                    ),
                  );
              setState(() {
                _exerciseType = exerciseType;
              });
            }
          },
        ),
        Visibility(
          visible: _exerciseType == ExerciseType.repsBased,
          child: _RepsBasedExerciseOptions(
            clientId: widget._clientId,
            date: widget._date,
            exerciseId: widget._exerciseInTrainingEntity.id,
            reps:
                widget._exerciseInTrainingEntity.exerciseEntity.reps.toString(),
            sets:
                widget._exerciseInTrainingEntity.exerciseEntity.sets.toString(),
          ),
        ),
        Visibility(
          visible: _exerciseType == ExerciseType.timeBased,
          child: _TimeBasedExerciseOptions(
            widget._exerciseInTrainingEntity.exerciseEntity.time,
            widget._date,
            widget._clientId,
            widget._exerciseInTrainingEntity.id,
          ),
        ),
      ],
    );
  }
}

class _RepsBasedExerciseOptions extends StatelessWidget {
  _RepsBasedExerciseOptions({
    required String reps,
    required String sets,
    required String clientId,
    required String date,
    required String exerciseId,
  })  : _reps = reps,
        _sets = sets,
        _clientId = clientId,
        _date = date,
        _exerciseId = exerciseId;

  final String _clientId;
  final String _date;
  final String _exerciseId;
  final String _reps;
  final String _sets;
  final _repsController = TextEditingController();
  final _setsController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _repsController.text = _reps;
    _setsController.text = _sets;
    _repsController.addListener(() {
      context.read<TrainerExerciseListOptionsBloc>().add(
            TrainerExerciseListOptionsEvent.editReps(
              _clientId,
              _date,
              _exerciseId,
              _repsController.text,
              _setsController.text,
            ),
          );
    });
    _setsController.addListener(() {
      context.read<TrainerExerciseListOptionsBloc>().add(
            TrainerExerciseListOptionsEvent.editReps(
              _clientId,
              _date,
              _exerciseId,
              _repsController.text,
              _setsController.text,
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
  _TimeBasedExerciseOptions(
      this._time, this._date, this._clientId, this._exerciseId);

  final String _date;
  final String _clientId;
  final String _exerciseId;
  final String _time;
  final _minutesController = TextEditingController();
  final _secondsController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final time = _time.split(':');
    final minutes = time[0];
    final seconds = time[1];
    _minutesController.text = minutes;
    _secondsController.text = seconds;
    _minutesController.addListener(() {
      context.read<TrainerExerciseListOptionsBloc>().add(
            TrainerExerciseListOptionsEvent.editTime(
              _clientId,
              _date,
              _exerciseId,
              _secondsController.text,
              _minutesController.text,
            ),
          );
    });
    _secondsController.addListener(() {
      context.read<TrainerExerciseListOptionsBloc>().add(
            TrainerExerciseListOptionsEvent.editTime(
              _clientId,
              _date,
              _exerciseId,
              _secondsController.text,
              _minutesController.text,
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
