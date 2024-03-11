import 'package:flutter/material.dart';
import 'package:perso/app/screens/exercise_details/model/exercise_options_data.dart';
import 'package:perso/app/styleguide/value/app_dimens.dart';
import 'package:perso/app/styleguide/value/app_typography.dart';
import 'package:perso/core/models/exercise_type.dart';

class PersoExerciseInstructions extends StatelessWidget {
  const PersoExerciseInstructions({
    required ExerciseOptionsData exerciseOptionsData,
    super.key,
  }) : _exerciseOptions = exerciseOptionsData;

  final ExerciseOptionsData _exerciseOptions;

  @override
  Widget build(BuildContext context) {
    return switch (_exerciseOptions.exerciseType) {
      ExerciseType.repsBased => Container(
          margin: const EdgeInsets.only(top: Dimens.mMargin),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                children: [
                  Text('Repetitions: ', style: ThemeText.bodyRegularBlackText),
                  Text(
                    _exerciseOptions.reps.toString(),
                    style: ThemeText.bodyRegularBlackText,
                  ),
                ],
              ),
              Visibility(
                visible: _exerciseOptions.weight > 0,
                child: Text(
                  'Weight: ${_exerciseOptions.weight} kg',
                  style: ThemeText.bodyRegularBlackText,
                ),
              ),
              Visibility(
                visible: _exerciseOptions.supersetName.isNotEmpty,
                child: Text(
                  'Superset: ${_exerciseOptions.supersetName}',
                  style: ThemeText.bodyRegularBlackText,
                ),
              ),
            ],
          ),
        ),
      ExerciseType.timeBased => Container(
          margin:
              const EdgeInsets.only(top: Dimens.sMargin, left: Dimens.mMargin),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Time: ${_exerciseOptions.time} seconds',
                style: ThemeText.bodyRegularBlackText,
              ),
              Visibility(
                visible: _exerciseOptions.weight > 0,
                child: Container(
                  margin: const EdgeInsets.only(top: Dimens.sMargin),
                  child: Text(
                    'Weight: ${_exerciseOptions.weight} kg',
                    style: ThemeText.bodyRegularBlackText,
                  ),
                ),
              ),
              Visibility(
                visible: _exerciseOptions.supersetName.isNotEmpty,
                child: Container(
                  margin: const EdgeInsets.only(top: Dimens.sMargin),
                  child: Text(
                    'Superset: ${_exerciseOptions.supersetName}',
                    style: ThemeText.bodyRegularBlackText,
                  ),
                ),
              ),
            ],
          ),
        ),
      ExerciseType.repsInReserve => Container(
          margin: const EdgeInsets.only(top: Dimens.sMargin),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                'Repetitions in reserve: ${_exerciseOptions.repsInReserve}',
                style: ThemeText.bodyRegularBlackText,
              ),
              Visibility(
                visible: _exerciseOptions.weight > 0,
                child: Text(
                  'Weight: ${_exerciseOptions.weight} kg',
                  style: ThemeText.bodyRegularBlackText,
                ),
              ),
              Visibility(
                visible: _exerciseOptions.supersetName.isNotEmpty,
                child: Text(
                  'Superset: ${_exerciseOptions.supersetName}',
                  style: ThemeText.bodyRegularBlackText,
                ),
              ),
            ],
          ),
        ),
      ExerciseType.rateOfPerceivedExertion => Container(
          margin: const EdgeInsets.only(top: Dimens.sMargin),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                'Rate of perceived exertion: ${_exerciseOptions.rateOfPerceivedExertion}',
                style: ThemeText.bodyRegularBlackText,
              ),
              Visibility(
                visible: _exerciseOptions.weight > 0,
                child: Text(
                  'Weight: ${_exerciseOptions.weight} kg',
                  style: ThemeText.bodyRegularBlackText,
                ),
              ),
              Visibility(
                visible: _exerciseOptions.supersetName.isNotEmpty,
                child: Text(
                  'Superset: ${_exerciseOptions.supersetName}',
                  style: ThemeText.bodyRegularBlackText,
                ),
              ),
            ],
          ),
        ),
      ExerciseType.maxPercentage => Container(
          margin: const EdgeInsets.only(top: Dimens.sMargin),
          child: Row(
            children: [
              Text(
                'Repetitions: ${_exerciseOptions.reps}',
                style: ThemeText.bodyRegularBlackText,
              ),
              Text(
                'Max %: ${_exerciseOptions.maxPercentage}',
                style: ThemeText.bodyRegularBlackText,
              ),
              Visibility(
                visible: _exerciseOptions.supersetName.isNotEmpty,
                child: Text(
                  'Superset: ${_exerciseOptions.supersetName}',
                  style: ThemeText.bodyRegularBlackText,
                ),
              ),
            ],
          ),
        ),
    };
  }
}
