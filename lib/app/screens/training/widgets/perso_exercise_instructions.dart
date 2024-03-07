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
                child: Row(
                  children: [
                    Text('Weight: ', style: ThemeText.bodyRegularBlackText),
                    Text(
                      '${_exerciseOptions.weight} kg',
                      style: ThemeText.bodyRegularBlackText,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ExerciseType.timeBased => Container(
          margin: const EdgeInsets.only(top: Dimens.sMargin),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                children: [
                  Text('Time: ', style: ThemeText.bodyRegularBlackText),
                  Text(
                    '${_exerciseOptions.time} seconds',
                    style: ThemeText.bodyRegularBlackText,
                  ),
                ],
              ),
              Visibility(
                visible: _exerciseOptions.weight > 0,
                child: Row(
                  children: [
                    Text('Weight: ', style: ThemeText.bodyRegularBlackText),
                    Text(
                      '${_exerciseOptions.weight} kg',
                      style: ThemeText.bodyRegularBlackText,
                    ),
                  ],
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
              Row(
                children: [
                  Text(
                    'Repetitions in reserve: ',
                    style: ThemeText.bodyRegularBlackText,
                  ),
                  Text(
                    _exerciseOptions.repsInReserve.toString(),
                    style: ThemeText.bodyRegularBlackText,
                  ),
                ],
              ),
              Visibility(
                visible: _exerciseOptions.weight > 0,
                child: Row(
                  children: [
                    Text('Weight: ', style: ThemeText.bodyRegularBlackText),
                    Text(
                      '${_exerciseOptions.weight} kg',
                      style: ThemeText.bodyRegularBlackText,
                    ),
                  ],
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
              Row(
                children: [
                  Text(
                    'Rate of perceived exertion: ',
                    style: ThemeText.bodyRegularBlackText,
                  ),
                  Text(
                    _exerciseOptions.rateOfPerceivedExertion.toString(),
                    style: ThemeText.bodyRegularBlackText,
                  ),
                ],
              ),
              Visibility(
                visible: _exerciseOptions.weight > 0,
                child: Row(
                  children: [
                    Text('Weight: ', style: ThemeText.bodyRegularBlackText),
                    Text(
                      '${_exerciseOptions.weight} kg',
                      style: ThemeText.bodyRegularBlackText,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ExerciseType.maxPercentage => Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Repetitions: ', style: ThemeText.bodyRegularBlackText),
                Text(
                  _exerciseOptions.reps.toString(),
                  style: ThemeText.bodyRegularBlackText,
                ),
              ],
            ),
            Container(
              margin: const EdgeInsets.only(top: Dimens.sMargin),
              child: Row(
                children: [
                  Text('Max %: ', style: ThemeText.bodyRegularBlackText),
                  Text(
                    _exerciseOptions.maxPercentage.toString(),
                    style: ThemeText.bodyRegularBlackText,
                  ),
                ],
              ),
            ),
          ],
        ),
    };
  }
}
