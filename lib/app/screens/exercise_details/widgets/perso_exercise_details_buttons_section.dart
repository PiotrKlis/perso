import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:perso/app/screens/exercise_details/bloc/exercise_details_bloc.dart';
import 'package:perso/app/screens/exercise_details/event/exercise_details_event.dart';
import 'package:perso/app/screens/exercise_details/widgets/perso_exercise_details_save_button.dart';
import 'package:perso/app/styleguide/value/app_dimens.dart';
import 'package:perso/app/widgets/perso_button.dart';
import 'package:perso/core/models/exercise_in_training_entity.dart';

class PersoExerciseDetailsButtonsSection extends StatelessWidget {
  const PersoExerciseDetailsButtonsSection({
    required String clientId,
    required String date,
    required GlobalKey<FormState> optionsFormKey,
    required GlobalKey<FormState> breaksFormKey,
    required ExerciseInTrainingEntity exerciseInTrainingEntity,
    super.key,
  })  : _exerciseInTrainingEntity = exerciseInTrainingEntity,
        _breaksFormKey = breaksFormKey,
        _clientId = clientId,
        _date = date,
        _optionsFormKey = optionsFormKey;

  final String _clientId;
  final String _date;
  final GlobalKey<FormState> _optionsFormKey;
  final GlobalKey<FormState> _breaksFormKey;
  final ExerciseInTrainingEntity _exerciseInTrainingEntity;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(Dimens.mMargin),
      child: Row(
        children: [
          Expanded(
            child: PersoButton(
              whiteBlackTheme: true,
              title: 'Delete',
              onTap: (context) {
                context.read<ExerciseDetailsBloc>().add(
                      ExerciseDetailsEvent.deleteExercise(
                        clientId: _clientId,
                        date: _date,
                        exerciseInTrainingId: _exerciseInTrainingEntity.id,
                      ),
                    );
                context.pop();
              },
            ),
          ),
          const SizedBox(width: Dimens.mMargin),
          Expanded(
            child: PersoExerciseDetailsSaveButton(
              clientId: _clientId,
              date: _date,
              optionsFormKey: _optionsFormKey,
              breaksFormKey: _breaksFormKey,
              exerciseInTrainingEntity: _exerciseInTrainingEntity,
            ),
          ),
        ],
      ),
    );
  }
}
