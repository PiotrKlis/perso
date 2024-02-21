import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:perso/app/screens/plan_overview/trainer/widgets/exercise_list/bloc/trainer_exercise_list_bloc.dart';
import 'package:perso/app/screens/plan_overview/trainer/widgets/exercise_list/event/trainer_exercise_list_event.dart';
import 'package:perso/app/screens/plan_overview/trainer/widgets/exercise_list/state/trainer_exercise_list_state.dart';
import 'package:perso/app/styleguide/styleguide.dart';
import 'package:perso/app/utils/extension/date_time_extensions.dart';
import 'package:perso/app/widgets/calendar/bloc/calendar_bloc.dart';
import 'package:perso/app/widgets/calendar/state/calendar_state.dart';
import 'package:perso/core/models/exercise_in_training_entity.dart';
import 'package:perso/core/navigation/navigation_config.dart';
import 'package:perso/core/navigation/screen_navigation_key.dart';

class PersoTrainerExerciseList extends StatefulWidget {
  const PersoTrainerExerciseList({
    required this.clientId,
    super.key,
  });

  final String clientId;

  @override
  State<PersoTrainerExerciseList> createState() =>
      _PersoTrainerExerciseListState();
}

class _PersoTrainerExerciseListState extends State<PersoTrainerExerciseList> {
  final _localExercises = <ExerciseInTrainingEntity>[];
  String _selectedDate = DateTime.now().yearMonthDayFormat;

  @override
  Widget build(BuildContext context) {
    return BlocListener<CalendarBloc, CalendarState>(
      listener: (context, state) {
        state.whenOrNull(
          selectedDate: (selectedDate) {
            _selectedDate = selectedDate;
            context.read<TrainerExerciseListBloc>().add(
                  TrainerExerciseListEvent.fetchExercises(
                    widget.clientId,
                    _selectedDate,
                  ),
                );
          },
        );
      },
      child: BlocBuilder<TrainerExerciseListBloc, TrainerExerciseListState>(
        builder: (context, state) {
          return state.when(
            exercises: (exercises) {
              if (exercises.isEmpty) {
                return SizedBox(
                  height: MediaQuery.of(context).size.height * 0.5,
                  child: Container(
                    margin: const EdgeInsets.only(
                      top: Dimens.xlMargin,
                    ),
                    child: Text(
                      'No exercises for this date',
                      style: ThemeText.bodyRegularBlackText,
                    ),
                  ),
                );
              } else {
                _localExercises
                  ..clear()
                  ..addAll(exercises);
                return Column(
                  children: [
                    ReorderableListView(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      proxyDecorator: (child, index, animation) =>
                          _ExercisesListDecorator(
                        animation: animation,
                        child: child,
                      ),
                      children: _localExercises.map((exerciseInTraining) {
                        return _Exercise(
                          key: UniqueKey(),
                          exerciseInTrainingEntity: exerciseInTraining,
                          clientId: widget.clientId,
                          date: _selectedDate,
                        );
                      }).toList(),
                      onReorder: (oldIndex, newIndex) {
                        setState(() {
                          if (newIndex > oldIndex) {
                            newIndex -= 1;
                          }
                          final item = _localExercises.removeAt(oldIndex);
                          _localExercises.insert(newIndex, item);
                          context.read<TrainerExerciseListBloc>().add(
                                TrainerExerciseListEvent.reorder(
                                  widget.clientId,
                                  _selectedDate,
                                  _localExercises,
                                ),
                              );
                        });
                      },
                    ),
                  ],
                );
              }
            },
            error: (error) {
              return Center(
                child: Text(error),
              );
            },
            loading: () {
              return const Center(child: CircularProgressIndicator());
            },
          );
        },
      ),
    );
  }
}

class _ExercisesListDecorator extends StatelessWidget {
  const _ExercisesListDecorator({required this.animation, required this.child});

  final Animation<double> animation;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (BuildContext context, Widget? child) {
        final animValue = Curves.easeInOut.transform(animation.value);
        final elevation = lerpDouble(0, 6, animValue)!;
        return Material(
          elevation: elevation,
          color: Colors.transparent,
          shadowColor: Colors.grey.withOpacity(0.1),
          child: child,
        );
      },
      child: child,
    );
  }
}

class _Exercise extends StatefulWidget {
  const _Exercise({
    required ExerciseInTrainingEntity exerciseInTrainingEntity,
    required String clientId,
    required String date,
    required Key key,
  })  : _date = date,
        _clientId = clientId,
        _exerciseInTrainingEntity = exerciseInTrainingEntity,
        super(key: key);

  final ExerciseInTrainingEntity _exerciseInTrainingEntity;
  final String _clientId;
  final String _date;

  @override
  State<_Exercise> createState() => _ExerciseState();
}

class _ExerciseState extends State<_Exercise> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: Dimens.sMargin),
      //ExpansionPanelList needs to be wrapped in Column as it fixes
      //avoid RenderListBody must have unlimited space along its main axis error
      child: Column(
        children: [
          _ExerciseHeader(
            exerciseInTraining: widget._exerciseInTrainingEntity,
            clientId: widget._clientId,
            date: widget._date,
          ),
        ],
      ),
    );
  }
}

class _ExerciseHeader extends StatelessWidget {
  const _ExerciseHeader({
    required ExerciseInTrainingEntity exerciseInTraining,
    required String clientId,
    required String date,
  })  : _date = date,
        _clientId = clientId,
        _exerciseInTraining = exerciseInTraining;

  final ExerciseInTrainingEntity _exerciseInTraining;
  final String _clientId;
  final String _date;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: Dimens.sMargin),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(Dimens.trainerCardBorderRadius),
        child: ColoredBox(
          color: Colors.white,
          child: ListTile(
            leading: _getIconForTags(_exerciseInTraining.exerciseEntity.tags),
            // subtitle: _exerciseInTraining.exerciseEntity.exerciseOptionsData.supersetName != null
            //     ? Text(
            //         _exerciseInTraining.exerciseEntity.supersetName,
            //         style: ThemeText.footnoteRegular,
            //       )
            //     : null,
            title: Text(
              _exerciseInTraining.exerciseEntity.title,
              style: ThemeText.bodyBoldBlackText,
            ),
            trailing: const Icon(Icons.reorder),
            onTap: () {
              context.pushNamed(
                ScreenNavigationKey.exerciseDetails,
                queryParameters: {
                  NavigationConstants.clientId: _clientId,
                  NavigationConstants.date: _date,
                },
                extra: _exerciseInTraining,
              );
            },
          ),
        ),
      ),
    );
  }

  Icon _getIconForTags(List<String> tags) {
    return const Icon(Icons.fitness_center);
  }
}
