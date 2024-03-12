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
          margin:
              const EdgeInsets.only(top: Dimens.sMargin, left: Dimens.mMargin),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _Reps(exerciseOptions: _exerciseOptions),
              _Weight(exerciseOptions: _exerciseOptions),
              _Superset(exerciseOptions: _exerciseOptions),
            ],
          ),
        ),
      ExerciseType.timeBased => Container(
          margin:
              const EdgeInsets.only(top: Dimens.sMargin, left: Dimens.mMargin),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _Time(exerciseOptions: _exerciseOptions),
              _Weight(exerciseOptions: _exerciseOptions),
              _Superset(exerciseOptions: _exerciseOptions),
            ],
          ),
        ),
      ExerciseType.repsInReserve => Container(
          margin:
              const EdgeInsets.only(top: Dimens.sMargin, left: Dimens.mMargin),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _RepsInReserve(exerciseOptions: _exerciseOptions),
              _Weight(exerciseOptions: _exerciseOptions),
              _Superset(exerciseOptions: _exerciseOptions),
            ],
          ),
        ),
      ExerciseType.rateOfPerceivedExertion => Container(
          margin:
              const EdgeInsets.only(top: Dimens.sMargin, left: Dimens.mMargin),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _RateOfPerceivedExertion(exerciseOptions: _exerciseOptions),
              _Weight(exerciseOptions: _exerciseOptions),
              _Superset(exerciseOptions: _exerciseOptions),
            ],
          ),
        ),
      ExerciseType.maxPercentage => Container(
          margin:
              const EdgeInsets.only(top: Dimens.sMargin, left: Dimens.mMargin),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _Reps(exerciseOptions: _exerciseOptions),
              _MaxPercent(exerciseOptions: _exerciseOptions),
              _Superset(exerciseOptions: _exerciseOptions),
            ],
          ),
        ),
    };
  }
}

class _Time extends StatelessWidget {
  const _Time({
    required ExerciseOptionsData exerciseOptions,
  }) : _exerciseOptions = exerciseOptions;

  final ExerciseOptionsData _exerciseOptions;

  @override
  Widget build(BuildContext context) {
    return Text(
      'Time: ${_exerciseOptions.time} seconds',
      style: ThemeText.bodyRegularBlackText,
    );
  }
}

class _RepsInReserve extends StatelessWidget {
  const _RepsInReserve({
    required ExerciseOptionsData exerciseOptions,
  }) : _exerciseOptions = exerciseOptions;

  final ExerciseOptionsData _exerciseOptions;

  @override
  Widget build(BuildContext context) {
    return Text(
      'Repetitions in reserve: ${_exerciseOptions.repsInReserve}',
      style: ThemeText.bodyRegularBlackText,
    );
  }
}

class _RateOfPerceivedExertion extends StatelessWidget {
  const _RateOfPerceivedExertion({
    required ExerciseOptionsData exerciseOptions,
  }) : _exerciseOptions = exerciseOptions;

  final ExerciseOptionsData _exerciseOptions;

  @override
  Widget build(BuildContext context) {
    return Text(
      'Rate of perceived exertion: ${_exerciseOptions.rateOfPerceivedExertion}',
      style: ThemeText.bodyRegularBlackText,
    );
  }
}

class _Weight extends StatelessWidget {
  const _Weight({
    required ExerciseOptionsData exerciseOptions,
  }) : _exerciseOptions = exerciseOptions;

  final ExerciseOptionsData _exerciseOptions;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: _exerciseOptions.weight > 0,
      child: Container(
        margin: const EdgeInsets.only(top: Dimens.sMargin),
        child: Text(
          'Weight: ${_exerciseOptions.weight} kg',
          style: ThemeText.bodyRegularBlackText,
        ),
      ),
    );
  }
}

class _Superset extends StatelessWidget {
  const _Superset({
    required ExerciseOptionsData exerciseOptions,
  }) : _exerciseOptions = exerciseOptions;

  final ExerciseOptionsData _exerciseOptions;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: _exerciseOptions.supersetName.isNotEmpty,
      child: Container(
        margin: const EdgeInsets.only(top: Dimens.sMargin),
        child: Text(
          'Superset: ${_exerciseOptions.supersetName}',
          style: ThemeText.bodyRegularBlackText,
        ),
      ),
    );
  }
}

class _MaxPercent extends StatelessWidget {
  const _MaxPercent({
    required ExerciseOptionsData exerciseOptions,
  }) : _exerciseOptions = exerciseOptions;

  final ExerciseOptionsData _exerciseOptions;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: _exerciseOptions.weight > 0,
      child: Container(
        margin: const EdgeInsets.only(top: Dimens.sMargin),
        child: Text(
          'Max %: ${_exerciseOptions.maxPercentage}',
          style: ThemeText.bodyRegularBlackText,
        ),
      ),
    );
  }
}

class _Reps extends StatelessWidget {
  const _Reps({
    required ExerciseOptionsData exerciseOptions,
  }) : _exerciseOptions = exerciseOptions;

  final ExerciseOptionsData _exerciseOptions;

  @override
  Widget build(BuildContext context) {
    return Text(
      'Repetitions: ${_exerciseOptions.reps}',
      style: ThemeText.bodyRegularBlackText,
    );
  }
}
