import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:perso/app/screens/exercise_details/bloc/exercise_details_bloc.dart';
import 'package:perso/app/screens/exercise_details/event/exercise_details_event.dart';
import 'package:perso/app/screens/exercise_details/exercise_details_inherited_widget.dart';
import 'package:perso/app/screens/exercise_details/state/exercise_details_state.dart';
import 'package:perso/app/screens/exercise_details/widgets/perso_exercise_details_save_button.dart';
import 'package:perso/app/styleguide/value/app_dimens.dart';
import 'package:perso/app/widgets/perso_button.dart';

class PersoExerciseDetailsButtonsSection extends StatelessWidget {
  const PersoExerciseDetailsButtonsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final exerciseInheritedWidget = ExerciseInheritedWidget.of(context);
    return Container(
      margin: const EdgeInsets.all(Dimens.mMargin),
      child: Row(
        children: [
          Expanded(
            //TODO: implement saveLoading i deleteLoading
            child: BlocBuilder<ExerciseDetailsBloc, ExerciseDetailsState>(
              builder: (context, state) {
                return state.whenOrNull(
                      deleteLoading: () => const PersoButton(
                        whiteBlackTheme: true,
                        isLoading: true,
                      ),
                    ) ??
                    PersoButton(
                      whiteBlackTheme: true,
                      title: 'Delete',
                      onTap: (context) {
                        context.read<ExerciseDetailsBloc>().add(
                              ExerciseDetailsEvent.deleteExercise(
                                clientId: exerciseInheritedWidget.clientId,
                                date: exerciseInheritedWidget.date,
                                exerciseInTrainingId: exerciseInheritedWidget
                                    .exerciseInTrainingEntity.id,
                              ),
                            );
                      },
                    );
              },
            ),
          ),
          const SizedBox(width: Dimens.mMargin),
          const Expanded(
            child: PersoExerciseDetailsSaveButton(),
          ),
        ],
      ),
    );
  }
}
