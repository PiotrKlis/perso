import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:perso/app/screens/exercise_details/exercise_options/bloc/trainer_exercise_list_options_bloc.dart';
import 'package:perso/app/screens/exercise_details/exercise_options/event/trainer_exercise_list_options_event.dart';
import 'package:perso/app/screens/exercise_details/exercise_options/model/exercise_options_data.dart';
import 'package:perso/app/screens/exercise_details/superset_section/perso_superset_section.dart';
import 'package:perso/app/styleguide/value/app_dimens.dart';
import 'package:perso/app/styleguide/value/app_typography.dart';
import 'package:perso/app/utils/extension/context_extensions.dart';
import 'package:perso/app/utils/validators.dart';
import 'package:perso/app/widgets/perso_button.dart';
import 'package:perso/app/widgets/perso_divider.dart';
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
        clientId: _clientId,
        date: _date,
        exerciseInTrainingEntity: _exerciseInTrainingEntity,
      ),
    );
  }
}

class _OptionsSectionContent extends StatefulWidget {
  const _OptionsSectionContent({
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
  State<_OptionsSectionContent> createState() => _OptionsSectionContentState();
}

class _OptionsSectionContentState extends State<_OptionsSectionContent> {
  late ExerciseOptionsData _optionsData;
  final _setsController = TextEditingController();
  final _repsController = TextEditingController();
  final _minutesController = TextEditingController();
  final _secondsController = TextEditingController();
  final _timeBreakController = TextEditingController();
  final _key = GlobalKey<FormState>();
  bool _shouldShowTimeBreak = false;

  @override
  void initState() {
    _optionsData = ExerciseOptionsData(
      exerciseType:
          widget._exerciseInTrainingEntity.exerciseEntity.exerciseType,
      reps: widget._exerciseInTrainingEntity.exerciseEntity.reps,
      sets: widget._exerciseInTrainingEntity.exerciseEntity.sets,
      time: widget._exerciseInTrainingEntity.exerciseEntity.time,
      timeBreak: widget._exerciseInTrainingEntity.exerciseEntity.timeBreak,
    );
    final timeList = _optionsData.time.split(':');
    final minutes = timeList[0];
    final seconds = timeList[1];
    _minutesController.text = minutes;
    _secondsController.text = seconds;
    _setsController.text = _optionsData.sets.toString();
    _repsController.text = _optionsData.reps.toString();
    _timeBreakController.text = _optionsData.timeBreak.toString();

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
          title: const Text('Reps based'),
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
          title: const Text('Time based'),
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
        RadioListTile(
          title: const Text('Reps in reserve'),
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
        RadioListTile(
          title: const Text('Rate of perceived exertion'),
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
        RadioListTile(
          title: const Text('Max %'),
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
        Form(
          key: _key,
          child: Column(
            children: [
              Visibility(
                maintainState: true,
                visible: _optionsData.exerciseType == ExerciseType.repsBased,
                child: _RepsBasedExerciseOptions(
                  repsController: _repsController,
                  setsController: _setsController,
                ),
              ),
              Visibility(
                maintainState: true,
                visible: _optionsData.exerciseType == ExerciseType.timeBased,
                child: _TimeBasedExerciseOptions(
                  minutesController: _minutesController,
                  secondsController: _secondsController,
                ),
              ),
              Visibility(
                maintainState: true,
                visible:
                    _optionsData.exerciseType == ExerciseType.repsInReserve,
                child: _RepsBasedExerciseOptions(
                  repsController: _repsController,
                  setsController: _setsController,
                ),
              ),
              Visibility(
                maintainState: true,
                visible: _optionsData.exerciseType ==
                    ExerciseType.rateOfPerceivedExertion,
                child: _TimeBasedExerciseOptions(
                  minutesController: _minutesController,
                  secondsController: _secondsController,
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: Dimens.mMargin,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Time breaks between sets',
                      style: ThemeText.bodyRegularBlackText,
                    ),
                    Switch(
                      value: _shouldShowTimeBreak,
                      onChanged: (value) {
                        if (!value) {
                          _timeBreakController.text = '0';
                        }
                        setState(() {
                          _shouldShowTimeBreak = value;
                        });
                      },
                    ),
                  ],
                ),
              ),
              Visibility(
                maintainState: true,
                visible: _shouldShowTimeBreak,
                child: Container(
                  margin: const EdgeInsets.only(
                      top: Dimens.mMargin,
                      left: Dimens.mMargin,
                      right: Dimens.mMargin),
                  child: PersoTextField(
                    textEditingController: _timeBreakController,
                    textInputType: TextInputType.number,
                    title: 'Time break (seconds)',
                    customValidator: TextFieldValidator.validateDigits,
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: Dimens.mMargin),
          child: const PersoDivider(),
        ),
      ],
    );
  }
}

class _RepsBasedExerciseOptions extends StatefulWidget {
  const _RepsBasedExerciseOptions({
    required TextEditingController repsController,
    required TextEditingController setsController,
  })  : _repsController = repsController,
        _setsController = setsController;

  final TextEditingController _repsController;
  final TextEditingController _setsController;

  @override
  State<_RepsBasedExerciseOptions> createState() =>
      _RepsBasedExerciseOptionsState();
}

class _RepsBasedExerciseOptionsState extends State<_RepsBasedExerciseOptions> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        top: Dimens.sMargin,
        left: Dimens.mMargin,
        right: Dimens.mMargin,
        bottom: Dimens.mMargin,
      ),
      child: Column(
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: PersoTextField(
                  textEditingController: widget._setsController,
                  textInputType: TextInputType.number,
                  title: 'Sets',
                  customValidator: TextFieldValidator.validateDigits,
                ),
              ),
              const SizedBox(
                width: 16,
              ),
              Expanded(
                child: PersoTextField(
                  textEditingController: widget._repsController,
                  textInputType: TextInputType.number,
                  title: 'Repetitions',
                  customValidator: TextFieldValidator.validateDigits,
                ),
              ),
              const SizedBox(
                width: 16,
              ),
              Expanded(
                child: PersoTextField(
                  //TODO: add weight controller
                  // textEditingController: widget._repsController,
                  textInputType: TextInputType.number,
                  title: 'Weight (kg)',
                  customValidator: TextFieldValidator.validateDigits,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _TimeBasedExerciseOptions extends StatelessWidget {
  const _TimeBasedExerciseOptions({
    required TextEditingController minutesController,
    required TextEditingController secondsController,
  })  : _minutesController = minutesController,
        _secondsController = secondsController;

  final TextEditingController _minutesController;
  final TextEditingController _secondsController;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(Dimens.mMargin),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: PersoTextField(
              //TODO: Change into sets controller
              textEditingController: _minutesController,
              textInputType: TextInputType.number,
              title: 'Sets',
              customValidator: TextFieldValidator.validateDigits,
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(
              horizontal: Dimens.sMargin,
            ),
          ),
          Expanded(
            child: PersoTextField(
              textEditingController: _secondsController,
              textInputType: TextInputType.number,
              title: 'Seconds',
              customValidator: TextFieldValidator.validateDigits,
            ),
          ),
        ],
      ),
    );
  }
}
