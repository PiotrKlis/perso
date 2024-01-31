import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:perso/app/screens/plan_overview/exercise_options_data.dart';
import 'package:perso/app/screens/plan_overview/trainer/widgets/exercise_options/bloc/trainer_exercise_list_options_bloc.dart';
import 'package:perso/app/screens/plan_overview/trainer/widgets/exercise_options/event/trainer_exercise_list_options_event.dart';
import 'package:perso/app/styleguide/value/app_dimens.dart';
import 'package:perso/app/styleguide/value/app_typography.dart';
import 'package:perso/app/widgets/perso_button.dart';
import 'package:perso/app/widgets/perso_text_field.dart';
import 'package:perso/core/models/exercise_in_training_entity.dart';
import 'package:perso/core/models/exercise_type.dart';
import 'package:perso/core/string_extensions.dart';

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
  final _setsController = TextEditingController();
  final _repsController = TextEditingController();
  final _minutesController = TextEditingController();
  final _secondsController = TextEditingController();

  @override
  void initState() {
    _optionsData = ExerciseOptionsData(
      exerciseType:
          widget._exerciseInTrainingEntity.exerciseEntity.exerciseType,
      reps: widget._exerciseInTrainingEntity.exerciseEntity.reps,
      sets: widget._exerciseInTrainingEntity.exerciseEntity.sets,
      time: widget._exerciseInTrainingEntity.exerciseEntity.time,
    );
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
          groupValue: _optionsData.exerciseType,
          onChanged: (exerciseType) {
            if (exerciseType != _optionsData.exerciseType) {
              setState(() {
                _optionsData =
                    _optionsData.copyWith(exerciseType: exerciseType!);
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
              });
            }
          },
        ),
        Visibility(
          visible: _optionsData.exerciseType == ExerciseType.repsBased,
          child: _RepsBasedExerciseOptions(
            reps: _optionsData.reps.toString(),
            sets: _optionsData.sets.toString(),
            repsController: _repsController,
            setsController: _setsController,
          ),
        ),
        Visibility(
          visible: _optionsData.exerciseType == ExerciseType.timeBased,
          child: _TimeBasedExerciseOptions(
            time: _optionsData.time,
            minutesController: _minutesController,
            secondsController: _secondsController,
          ),
        ),
        Container(
          margin: const EdgeInsets.all(Dimens.mMargin),
          child: PersoButton(
            title: 'Save',
            onTap: (context) {
              final minutes = _minutesController.text.removeLeadingZeroes;
              final seconds = _secondsController.text
                  .removeLeadingZeroes()
                  .limitToTwoDigits;
              //TODO: add validation // form? pass custom validator? validateDigits
              _optionsData = _optionsData.copyWith(
                reps: int.parse(_repsController.text),
                sets: int.parse(_setsController.text),
                time: '$seconds:$minutes',
              );
              context.read<TrainerExerciseListOptionsBloc>().add(
                    TrainerExerciseListOptionsEvent.editExerciseOptions(
                      clientId: widget._clientId,
                      date: widget._date,
                      exerciseInTrainingId: widget._exerciseInTrainingEntity.id,
                      exerciseOptionsData: _optionsData,
                    ),
                  );
            },
          ),
        ),
      ],
    );
  }
}

class _RepsBasedExerciseOptions extends StatefulWidget {
  const _RepsBasedExerciseOptions({
    required String reps,
    required String sets,
    required TextEditingController repsController,
    required TextEditingController setsController,
  })  : _reps = reps,
        _sets = sets,
        _repsController = repsController,
        _setsController = setsController;

  final String _reps;
  final String _sets;
  final TextEditingController _repsController;
  final TextEditingController _setsController;

  @override
  State<_RepsBasedExerciseOptions> createState() =>
      _RepsBasedExerciseOptionsState();
}

class _RepsBasedExerciseOptionsState extends State<_RepsBasedExerciseOptions> {
  @override
  Widget build(BuildContext context) {
    widget._repsController.text = widget._reps;
    widget._setsController.text = widget._sets;
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
              textEditingController: widget._setsController,
              textInputType: TextInputType.number,
              title: 'Sets',
            ),
          ),
          const SizedBox(
            width: 8,
          ),
          Expanded(
            child: PersoTextField(
              textEditingController: widget._repsController,
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
  const _TimeBasedExerciseOptions({
    required String time,
    required TextEditingController minutesController,
    required TextEditingController secondsController,
  })  : _time = time,
        _minutesController = minutesController,
        _secondsController = secondsController;

  final TextEditingController _minutesController;
  final TextEditingController _secondsController;
  final String _time;

  @override
  Widget build(BuildContext context) {
    final timeList = _time.split(':');
    final minutes = timeList[0];
    final seconds = timeList[1];
    _minutesController.text = minutes;
    _secondsController.text = seconds;
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
