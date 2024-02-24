import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:perso/app/screens/exercise_details/exercise_options/bloc/trainer_exercise_options_bloc.dart';
import 'package:perso/app/screens/exercise_details/exercise_options/event/trainer_exercise_options_event.dart';
import 'package:perso/app/screens/exercise_details/exercise_options/model/exercise_options_data.dart';
import 'package:perso/app/styleguide/value/app_dimens.dart';
import 'package:perso/app/utils/extension/context_extensions.dart';
import 'package:perso/app/widgets/perso_button.dart';
import 'package:perso/core/models/exercise_type.dart';

class PersoSaveOptionsButton extends StatelessWidget {
  const PersoSaveOptionsButton({
    super.key,
    required String clientId,
    required String date,
    required String exerciseInTrainingId,
    required GlobalKey<FormState> optionsFormKey,
    required ExerciseOptionsData exerciseOptionsData,
    required GlobalKey<FormState> breaksFormKey,
  })  : _breaksFormKey = breaksFormKey,
        _exerciseOptionsData = exerciseOptionsData,
        _clientId = clientId,
        _date = date,
        _exerciseInTrainingId = exerciseInTrainingId,
        _optionsFormKey = optionsFormKey;

  final String _clientId;
  final String _date;
  final String _exerciseInTrainingId;
  final ExerciseOptionsData _exerciseOptionsData;
  final GlobalKey<FormState> _optionsFormKey;
  final GlobalKey<FormState> _breaksFormKey;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(Dimens.mMargin),
      child: PersoButton(
        title: 'Save',
        onTap: (context) {
          if (_optionsFormKey.currentState!.validate() &&
              _breaksFormKey.currentState!.validate()) {
            switch (_exerciseOptionsData.exerciseType) {
              // case ExerciseType.repsBased:
              //   {
              //     _optionsData = _optionsData.copyWith(
              //       reps: int.parse(_repsController.text),
              //       sets: int.parse(_setsController.text),
              //       timeBreak: int.parse(_timeBreakController.text),
              //     );
              //   }
              case ExerciseType.timeBased:
              // {
              //   final minutes = _minutesController.text.removeLeadingZeroes();
              //   final seconds = _secondsController.text
              //       .removeLeadingZeroes()
              //       .limitToTwoDigits();
              //   _optionsData = _optionsData.copyWith(
              //     time: '$minutes:$seconds',
              //   );
              // }
              case ExerciseType.repsInReserve:
              // TODO: Handle this case.
              case ExerciseType.rateOfPerceivedExertion:
              // TODO: Handle this case.
              case ExerciseType.maxPercentage:
              // TODO: Handle this case.
              case ExerciseType.repsBased:
              // TODO: Handle this case.
              case null:
              // TODO: Handle this case.
            }
            // context.read<TrainerExerciseOptionsBloc>().add(
            //       TrainerExerciseOptionsEvent.editExerciseOptions(
            //         clientId: _clientId,
            //         date: _date,
            //         exerciseInTrainingId: _exerciseInTrainingId,
            //         exerciseOptionsData: _exerciseOptionsData,
            //       ),
            //     );
            context.showSuccessfulSnackBar('Saving succeeded');
          }
        },
      ),
    );
  }
}
