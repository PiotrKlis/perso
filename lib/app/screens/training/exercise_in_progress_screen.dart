import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:perso/app/screens/training/bloc/training_bloc.dart';
import 'package:perso/app/screens/training/event/training_event.dart';
import 'package:perso/app/screens/training/widgets/perso_exercise_instructions.dart';
import 'package:perso/app/screens/training/widgets/perso_exercise_timer.dart';
import 'package:perso/app/styleguide/styleguide.dart';
import 'package:perso/app/widgets/perso_divider.dart';
import 'package:perso/app/widgets/perso_text_field.dart';
import 'package:perso/app/widgets/video_player/perso_video_player.dart';
import 'package:perso/core/models/exercise_entity.dart';
import 'package:perso/core/models/exercise_type.dart';

//TODO: Make me great plz, then breakz screen
class ExercisesInProgressScreen extends StatelessWidget {
  const ExercisesInProgressScreen({required this.exercise, super.key});

  final ExerciseEntity exercise;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverFillRemaining(
          hasScrollBody: false,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PersoVideoPlayer(videoId: exercise.videoId),
              _Title(exerciseTitle: exercise.title),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  PersoExerciseInstructions(
                    exerciseOptionsData: exercise.exerciseOptionsData,
                  ),
                  _TimerSection(
                    exerciseType: exercise.exerciseOptionsData.exerciseType,
                    time: exercise.exerciseOptionsData.time,
                  ),
                ],
              ),
              _Description(exercise: exercise),
              _TrainerNote(
                trainerNote: exercise.exerciseOptionsData.trainerNote,
              ),
              const _ClientNote(),
              _ButtonsSection(),
            ],
          ),
        ),
      ],
    );
  }
}

class _ClientNote extends StatelessWidget {
  const _ClientNote();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        top: Dimens.mMargin,
        left: Dimens.mMargin,
        right: Dimens.mMargin,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const PersoDivider(),
          const SizedBox(height: Dimens.mMargin),
          Text('Client note', style: ThemeText.bodyBoldBlackText),
          Container(
            margin: const EdgeInsets.only(top: Dimens.mMargin),
            child: const PersoTextField(
              hintText: 'Raise problem on the exercise',
            ),
          ),
        ],
      ),
    );
  }
}

class _TimerSection extends StatelessWidget {
  const _TimerSection({required ExerciseType exerciseType, required int time})
      : _time = time,
        _exerciseType = exerciseType;

  final ExerciseType _exerciseType;
  final int _time;

  @override
  Widget build(BuildContext context) {
    if (_exerciseType == ExerciseType.timeBased) {
      return PersoExerciseTimer(
        time: _time,
      );
    } else {
      return Container();
    }
  }
}

class _ButtonsSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          margin: const EdgeInsets.only(
            bottom: Dimens.mMargin,
            top: Dimens.lMargin,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  context.read<TrainingBloc>().add(
                        const TrainingEvent.previousExercise(),
                      );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: PersoColors.lighterGrey,
                  shape: const CircleBorder(),
                ),
                child: const Icon(
                  Icons.keyboard_arrow_left,
                  color: Colors.black,
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  context.read<TrainingBloc>().add(
                        const TrainingEvent.exerciseDone(),
                      );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  shape: const CircleBorder(),
                  padding: const EdgeInsets.all(Dimens.mMargin),
                ),
                child: const Icon(
                  Icons.check_rounded,
                  color: Colors.white,
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  context.read<TrainingBloc>().add(
                        const TrainingEvent.nextExercise(),
                      );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: PersoColors.lighterGrey,
                  shape: const CircleBorder(),
                ),
                child: const Icon(
                  Icons.keyboard_arrow_right,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TrainerNote extends StatelessWidget {
  const _TrainerNote({
    required String trainerNote,
  }) : _trainerNote = trainerNote;

  final String _trainerNote;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        top: Dimens.mMargin,
        left: Dimens.mMargin,
        right: Dimens.mMargin,
      ),
      child: Visibility(
        visible: _trainerNote.isNotEmpty,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const PersoDivider(),
            const SizedBox(height: Dimens.mMargin),
            Text('Trainer note', style: ThemeText.bodyBoldBlackText),
            Container(
              margin: const EdgeInsets.only(top: Dimens.sMargin),
              child: Text(
                _trainerNote,
                style: ThemeText.bodyRegularBlackText,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Description extends StatelessWidget {
  const _Description({
    required this.exercise,
  });

  final ExerciseEntity exercise;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        top: Dimens.mMargin,
        left: Dimens.mMargin,
        right: Dimens.mMargin,
      ),
      child: Text(
        exercise.description,
        style: ThemeText.bodyRegularBlackText,
      ),
    );
  }
}

class _Title extends StatelessWidget {
  const _Title({
    required String exerciseTitle,
  }) : _exerciseTitle = exerciseTitle;

  final String _exerciseTitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        left: Dimens.mMargin,
        top: Dimens.mMargin,
      ),
      child: Text(
        _exerciseTitle,
        style: ThemeText.largerTitleBold,
      ),
    );
  }
}
