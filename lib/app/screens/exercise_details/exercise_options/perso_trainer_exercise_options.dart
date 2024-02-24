import 'package:flutter/material.dart';
import 'package:perso/app/screens/exercise_details/exercise_options/model/exercise_options_data.dart';
import 'package:perso/app/styleguide/value/app_dimens.dart';
import 'package:perso/app/styleguide/value/app_typography.dart';
import 'package:perso/app/utils/validators.dart';
import 'package:perso/app/widgets/perso_text_field.dart';
import 'package:perso/core/models/exercise_type.dart';

class PersoTrainerExerciseOptionsSection extends StatefulWidget {
  const PersoTrainerExerciseOptionsSection({
    super.key,
    required ExerciseOptionsData exerciseOptionsData,
    required Key formKey,
  })  : _formKey = formKey,
        _exerciseOptionsData = exerciseOptionsData;

  final ExerciseOptionsData _exerciseOptionsData;
  final Key _formKey;

  @override
  State<PersoTrainerExerciseOptionsSection> createState() =>
      PersoTrainerExerciseOptionsSectionState();
}

class PersoTrainerExerciseOptionsSectionState
    extends State<PersoTrainerExerciseOptionsSection> {
  late ExerciseOptionsData _localExerciseOptionsData;

  @override
  void initState() {
    super.initState();
    _localExerciseOptionsData = widget._exerciseOptionsData;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(Dimens.mMargin),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Options',
            style: ThemeText.smallTitleBold,
          ),
          ListView(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            children: ExerciseType.values
                .map(
                  (exerciseType) => RadioListTile(
                    title: Text(exerciseType.value),
                    value: exerciseType,
                    groupValue: _localExerciseOptionsData.exerciseType,
                    onChanged: (exerciseType) {
                      if (exerciseType !=
                          _localExerciseOptionsData.exerciseType) {
                        setState(() {
                          _localExerciseOptionsData = _localExerciseOptionsData
                              .copyWith(exerciseType: exerciseType);
                        });
                      }
                    },
                  ),
                )
                .toList(),
          ),
          Form(
            key: widget._formKey,
            child: _ExerciseOptionsFields(
              exerciseOptionsData: _localExerciseOptionsData,
            ),
          ),
        ],
      ),
    );
  }
}

class _ExerciseOptionsFields extends StatelessWidget {
  _ExerciseOptionsFields({required ExerciseOptionsData exerciseOptionsData})
      : _exerciseOptionsData = exerciseOptionsData;

  final _setsController = TextEditingController();
  final _secondController = TextEditingController();
  final _thirdController = TextEditingController();
  final ExerciseOptionsData _exerciseOptionsData;

  @override
  Widget build(BuildContext context) {
    _updateTextControllers(_exerciseOptionsData);
    return Container(
      margin: const EdgeInsets.only(top: Dimens.mMargin),
      child: Row(
        children: [
          Expanded(
            child: PersoTextField(
              textEditingController: _setsController,
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
              textEditingController: _secondController,
              textInputType: TextInputType.number,
              title: _getSecondFieldTitle(_exerciseOptionsData.exerciseType),
              customValidator: TextFieldValidator.validateDigits,
            ),
          ),
          const SizedBox(
            width: 16,
          ),
          Visibility(
            visible:
                _exerciseOptionsData.exerciseType != ExerciseType.repsInReserve,
            child: Expanded(
              child: PersoTextField(
                textEditingController: _thirdController,
                textInputType: TextInputType.number,
                title: _getThirdFieldTitle(_exerciseOptionsData.exerciseType),
                customValidator: TextFieldValidator.validateDigits,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _updateTextControllers(ExerciseOptionsData optionsData) {
    _setsController.text = optionsData.sets.toString();
    switch (optionsData.exerciseType) {
      case ExerciseType.timeBased:
        _secondController.text = optionsData.time.toString();
        _thirdController.text = optionsData.weight.toString();
        break;
      case ExerciseType.repsInReserve:
        _secondController.text = optionsData.repsInReserve.toString();
        break;
      case ExerciseType.rateOfPerceivedExertion:
        _secondController.text = optionsData.rateOfPerceivedExertion.toString();
        _thirdController.text = optionsData.weight.toString();
        break;
      case ExerciseType.maxPercentage:
        _secondController.text = optionsData.reps.toString();
        _thirdController.text = optionsData.maxPercentage.toString();
        break;
      case null:
      case ExerciseType.repsBased:
        _secondController.text = optionsData.reps.toString();
        _thirdController.text = optionsData.weight.toString();
        break;
    }
  }

  String _getSecondFieldTitle(ExerciseType? exerciseType) {
    switch (exerciseType) {
      case ExerciseType.timeBased:
        return 'Time (seconds)';
      case ExerciseType.repsInReserve:
        return 'Reps in reserve';
      case ExerciseType.rateOfPerceivedExertion:
        return 'Rate of perceived exertion';
      case ExerciseType.maxPercentage:
      case ExerciseType.repsBased:
      case null:
        return 'Reps';
    }
  }

  String _getThirdFieldTitle(ExerciseType? exerciseType) {
    switch (exerciseType) {
      case ExerciseType.maxPercentage:
        return 'Max %';
      case ExerciseType.timeBased:
      case ExerciseType.repsInReserve:
      case ExerciseType.rateOfPerceivedExertion:
      case ExerciseType.repsBased:
      case null:
        return 'Weight (kg)';
    }
  }
}
