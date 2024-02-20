import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:perso/app/screens/exercise_details/exercise_options/bloc/trainer_exercise_options_bloc.dart';
import 'package:perso/app/screens/exercise_details/exercise_options/event/trainer_exercise_options_event.dart';
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
  const PersoTrainerExerciseOptionsSection({
    required ExerciseOptionsData exerciseOptionsData,
    required Key formKey,
    super.key,
  })  : _formKey = formKey,
        _exerciseOptionsData = exerciseOptionsData;

  final ExerciseOptionsData _exerciseOptionsData;
  final Key _formKey;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TrainerExerciseOptionsBloc(),
      child: _OptionsSectionContent(
        exerciseOptionsData: _exerciseOptionsData,
        formKey: _formKey,
      ),
    );
  }
}

class _OptionsSectionContent extends StatefulWidget {
  const _OptionsSectionContent({
    required ExerciseOptionsData exerciseOptionsData,
    required Key formKey,
  })  : _formKey = formKey,
        _exerciseOptionsData = exerciseOptionsData;

  final ExerciseOptionsData _exerciseOptionsData;
  final Key _formKey;

  @override
  State<_OptionsSectionContent> createState() => _OptionsSectionContentState();
}

class _OptionsSectionContentState extends State<_OptionsSectionContent> {
  late ExerciseOptionsData _optionsData;
  final _setsFieldController = TextEditingController();
  final _secondFieldController = TextEditingController();
  final _thirdFieldController = TextEditingController();
  final _key = GlobalKey<FormState>();
  var _selectedExerciseType = ExerciseType.repsBased;

  @override
  void initState() {
    // final timeList = _optionsData.time?.split(':');
    // final seconds = timeList[1];
    _setsFieldController.text = _optionsData.sets.toString();
    _secondFieldController.text = _optionsData.reps.toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _Header(),
        ListView(
          children: ExerciseType.values
              .map(
                (exerciseType) => RadioListTile(
                  title: Text(exerciseType.value),
                  value: exerciseType,
                  groupValue: exerciseType,
                  onChanged: (exerciseType) {
                    if (exerciseType != _selectedExerciseType) {
                      setState(() {
                        _selectedExerciseType = exerciseType!;
                      });
                    }
                  },
                ),
              )
              .toList(),
        ),
        Form(
          key: _key,
          child: Column(
            children: [
              _ExerciseOptionsFields(
                repsController: _secondFieldController,
                setsController: _setsFieldController,
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

class _Header extends StatelessWidget {
  const _Header({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        left: Dimens.mMargin,
        right: Dimens.sMargin,
        top: Dimens.mMargin,
      ),
      child: Text(
        'Options',
        style: ThemeText.smallTitleBold,
      ),
    );
  }
}

class _ExerciseOptionsFields extends StatefulWidget {
  const _ExerciseOptionsFields({
    required TextEditingController repsController,
    required TextEditingController setsController,
  })  : _repsController = repsController,
        _setsController = setsController;

  final TextEditingController _repsController;
  final TextEditingController _setsController;

  @override
  State<_ExerciseOptionsFields> createState() => _ExerciseOptionsFieldsState();
}

class _ExerciseOptionsFieldsState extends State<_ExerciseOptionsFields> {
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
