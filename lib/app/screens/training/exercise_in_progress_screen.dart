import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:perso/app/screens/training/bloc/training_bloc.dart';
import 'package:perso/app/screens/training/event/training_event.dart';
import 'package:perso/app/styleguide/styleguide.dart';
import 'package:perso/core/models/exercise_entity.dart';

class ExercisesInProgressScreen extends StatelessWidget {
  const ExercisesInProgressScreen({required this.exercise, super.key});

  final ExerciseEntity exercise;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: Colors.grey,
          height: Dimens.xlPlaceholder,
        ),
        Container(
          margin: const EdgeInsets.only(
            top: Dimens.xlMargin,
          ),
          child: Text(
            exercise.title,
            style: ThemeText.bodyBoldBlackText,
          ),
        ),
        // Container(
        //   margin: const EdgeInsets.only(
        //     top: Dimens.sMargin,
        //   ),
        //   child: Text(exercise.reps.toString()),
        // ),
        Container(
          margin: const EdgeInsets.only(
            top: Dimens.lMargin,
            left: Dimens.mMargin,
            right: Dimens.mMargin,
          ),
          child: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              text: exercise.description,
              style: ThemeText.bodyRegularBlackText,
              children: [
                TextSpan(
                  text: 'Read More...',
                  style: ThemeText.footnoteBoldBlue,
                ),
              ],
            ),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: Dimens.xlMargin),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.only(right: Dimens.xlMargin),
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: PersoColors.lighterGrey,
                    shape: const CircleBorder(),
                    padding: const EdgeInsets.all(Dimens.sIconSize),
                  ),
                  child: const Icon(
                    Icons.keyboard_arrow_left,
                    color: Colors.black,
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  context.read<TrainingBloc>().add(
                        const TrainingEvent.nextExercise(),
                      );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  shape: const CircleBorder(),
                  padding: const EdgeInsets.all(Dimens.lMargin),
                ),
                child: const Icon(
                  Icons.check_rounded,
                  color: Colors.white,
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: Dimens.xlMargin),
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: PersoColors.lighterGrey,
                    shape: const CircleBorder(),
                    padding: const EdgeInsets.all(Dimens.sIconSize),
                  ),
                  child: const Icon(
                    Icons.keyboard_arrow_right,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
